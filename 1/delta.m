function [weight] = delta(patterns, targets, eta, epochs);
% perform the delta rule.

[insize, ndata] = size(patterns);
[outsize, ~]    = size(targets);

patterns        = [patterns; ones(1, ndata)];
% add patterns w/bias.

weight          = rand(outsize, insize+1) * 0.05;
delta           = zeros(outsize, insize);
% initialize the delta matrix.

axis ([-2, 2, -2, 2], 'square');

for i = 1:epochs
   % perform the recursive delta operation.
   delta        = -eta * (weight * patterns - targets) * patterns';
   weight       = weight + delta;
end

p               = weight(1,1:2);
k               = -weight(1, insize+1) / (p*p');
l               = sqrt(p*p');
plot(patterns(1, find(targets>0)), ...
    patterns(2, find(targets>0)), '*', ...
    patterns(1, find(targets<0)), ...
    patterns(2, find(targets<0)), '+', ...
    [p(1), p(1)]*k + [-p(2), p(2)]/l, ...
    [p(2), p(2)]*k + [p(1), -p(1)]/l, '-');
drawnow;