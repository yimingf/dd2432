function [ weight, pos ] = som_5( patterns, y, epochs )
% som, self-organizing maps
% dd2432, lab 3, part 5
% 2-dimension som.

[pattern_size, weight_size] = size(patterns);
output_size             = y ^ 2;
weight                  = rand(output_size, weight_size);
eta                     = 0.2;
neighbor_size           = floor(y / 2);
[I, J]                  = ind2sub([y, y], 1 : output_size);
manhattan_dist          = mandist([I; J]);
% initialize the vectors and variables.

for i = 1 : epochs
    for j = 1 : pattern_size
        x       = patterns(j, :);
        foo     = bsxfun(@plus, -weight, x);
        [~, d]  = min(diag(foo * foo'));
        % find the winner.
        bar     = manhattan_dist(d, :);
        range   = find(bar < neighbor_size);
        % find the range. 
        foo     = bsxfun(@plus, -weight(range, :), x);
        weight(range, :) = weight(range, :) + eta * foo;
        % update the weight.
    end
    if (mod(i, 10) == 0)
        neighbor_size = neighbor_size - 1;
    end
    % update the neighbor size.
end

pos = zeros(pattern_size, 1);
for i = 1 : pattern_size
    x           = patterns(i, :);
    foo         = bsxfun(@plus, -weight, x);
    [~, pos(i)]      = min(diag(foo * foo'));
    %pos(i, :)   = [I(d), J(d)];
end

end