function [ weight, pos ] = som_3( patterns, y, epochs )
% som, self-organizing maps
% dd2432, lab 3, part 3

[pattern_size, weight_size] = size(patterns);
weight                  = rand(y, weight_size);
eta                     = 0.2;
tau                     = 1000;
neighbor_size           = floor(y / 4);
% initialize the vectors and variables.

for i = 1 : epochs
    for j = 1 : pattern_size
        x       = patterns(j, :);
        foo     = bsxfun(@plus, -weight, x);
        [~, d]  = min(diag(foo * foo'));
        % find the winner.
        range   = [max(1, (floor(d - neighbor_size))) : 1 : min(y, (floor(d + neighbor_size)))];
        % find the range. 
        foo     = bsxfun(@plus, -weight(range, :), x);
        weight(range, :) = weight(range, :) + eta * foo;
        % update the weight.
    end
    %neighbor_size = neighbor_size - 1;
    neighbor_size = neighbor_size * exp(-i/tau);
    % update the neighbor size.
end

pos = zeros(pattern_size, 1);
for i = 1 : pattern_size
    x           = patterns(i, :);
    foo         = bsxfun(@plus, -weight, x);
    [~, pos(i)] = min(diag(foo * foo'));
end
% presentation of the maximum response.

end

