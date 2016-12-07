animals;
[npatterns, xsize] = size(props);
w = rand(32, xsize);

eta= 1;
epochs = 20;
nei_size = 25;
nei_size_f = 25;

for i = 1:epochs
    for a = 1:npatterns
        p = props(a,:);
        foo     = bsxfun(@plus, -w, p);    %% equals to p-w(:,:)
        [~, win]  = min(diag(foo * foo'));
        %%%why wrong: norm distance, not manhaten!!
        %[min_val,win] = min(mandist(w, p'));
        range = max(1,(win-nei_size)) : 1 : min(size(w,1),(win+nei_size));
        foo     = bsxfun(@plus, -w(range, :), p);
        w(range, :) = w(range, :) + eta * foo;
        %for j = max(1,(win-nei_size)):min(size(w,1),(win+nei_size))
        %    w(j,:) = w(j,:) + eta * (p - win_w);
        %end
    end
    % nei_size = nei_size - 1;
    nei_size_f = nei_size_f * exp(-i/1000);
    nei_size = floor(nei_size_f);
end

pos = zeros(npatterns,1);
for a = 1:npatterns
        p = props(a,:);
        foo     = bsxfun(@plus, -w, p);    %% equals to p-w(:,:)
        [~, win]  = min(diag(foo * foo'));
        pos(a) = win;
end

[dummy, order] = sort(pos);
snames(order)'