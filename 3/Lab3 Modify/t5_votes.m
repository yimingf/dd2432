votes, mpparty, mpsex, mpdistrict;

[npatterns, xsize] = size(patterns);
% permute = randperm(npatterns);
% patterns = patterns(permute,:);

y = 10;
output_size = y ^ 2;
w = rand(output_size, xsize);
[I, J] = ind2sub([y, y], 1 : output_size);%????????index????????
manhattan_dist = mandist([I; J]);

eta= 0.2;
epochs = 100;
nei_size = floor(y / 2);

for i = 1:epochs
    for a = 1:npatterns
        p = patterns(a,:);
        foo     = bsxfun(@plus, -w, p);    %% equals to p-w(:,:)
        [~, win]  = min(diag(foo * foo'));

        range = find(manhattan_dist(win, :) < nei_size);
        foo     = bsxfun(@plus, -w(range, :), p);
        w(range, :) = w(range, :) + eta * foo;
    end
    if (mod(i, 10) == 0)
        nei_size = nei_size - 1;
    end
end

pos = zeros(npatterns, 1);
for a = 1:npatterns
        p = patterns(a,:);
        foo = bsxfun(@plus, -w, p);    %% equals to p-w(:,:)
        [~, win] = min(diag(foo * foo'));
        pos(a) = win;
end

a               = ones(1, y^2) * 350;
a(pos)          = 1:349;
mp_sex = mp_sex+1;
% mp_district2 = mp_district(permute,:);

colormap([0 0 0; 0 0 1; 0 1 1; 1 0 1; 1 0 0; 0 1 0; 1 1 1; 1 1 0;
    0 0 0.5; 0 0.5 1; 0.5 1 1; 1 0.5 1; 1 0 0.5; 0 1 0.5; 0.5 1 1; 1 1 0.5;
    0 0.5 0; 0.5 0 1; 0 0.3 1; 1 0.4 1; 1 0.6 0; 0.8 1 0; 0.4 1 1; 1 0.3 0.4;
    0.3 0.5 0; 0.5 0.3 1; 0.4 0.3 1; 1 0.4 0.8; 1 0.6 0.7; 0.8 1 0.2; 0.4 1 0.6; 0.4 0.3 0.4])

p               = [mp_party; 0]; % mp_party, mp_sex, mp_district.
subplot(1, 3, 1);
image(p(reshape(a, y, y)) + 1);

p               = [mp_sex; 0]; % mp_party, mp_sex, mp_district.
subplot(1, 3, 2);
image(p(reshape(a, y, y)) + 1);

p               = [mp_district; 0]; % mp_party, mp_sex, mp_district.
subplot(1, 3, 3);
image(p(reshape(a, y, y)) + 1);