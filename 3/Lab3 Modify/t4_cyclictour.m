cities;
%plot(city(:,1),city(:,2),'*');
[npatterns, xsize] = size(city);
y = 10;
w = rand(y, xsize);

eta= 0.2;
epochs = 100;
nei_size = 2;
nei_size_f = nei_size;

ax=zeros(1,epochs);
for i = 1:epochs
    for a = 1:npatterns
        p = city(a,:);
        foo     = bsxfun(@plus, -w, p);    %% equals to p-w(:,:)
        [~, win]  = min(diag(foo * foo'));

        range   = find_circular_range(win, y, nei_size);
        foo     = bsxfun(@plus, -w(range, :), p);
        w(range, :) = w(range, :) + eta * foo;

    end
    ax(i) = nei_size;
    nei_size_f = nei_size_f * exp(-i/1000);
    nei_size = floor(nei_size_f);
    %if (i > 50) nei_size = 1; end
end

plot(ax)
xlabel('epochs');
ylabel('neighbour');

tour = [w; w(1, :)];
plot(tour(:, 1), tour(:, 2), 'b-*', city(:, 1), city(:, 2), '+')
