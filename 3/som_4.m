function [ weight ] = som_4( patterns, y, epochs )
% som, self-organizing maps
% dd2432, lab 3, part 4

[pattern_size, weight_size] = size(patterns);
weight                  = rand(y, weight_size);
eta                     = 0.2;
tau                     = 1000;
neighbor_size           = 2;
% initialize the vectors and variables.

for i = 1 : epochs
    for j = 1 : pattern_size
        x       = patterns(j, :);
        foo     = bsxfun(@plus, -weight, x);
        [~, d]  = min(diag(foo * foo'));
        % find the winner.
        range   = find_circular_range(d, y, neighbor_size);
        % find the range. 
        foo     = bsxfun(@plus, -weight(range, :), x);
        weight(range, :) = weight(range, :) + eta * foo;
        % update the weight.
    end
    if (i > 50) neighbor_size = 1; end
    % update the neighbor size.
end

end

