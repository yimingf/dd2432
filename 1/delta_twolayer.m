function [ out ] = delta_twolayer(patterns, targets, eta, epochs, alpha, hidden)
% perform the two-layer delta rule.

[insize, ndata] = size(patterns);
[outsize, ~]    = size(targets);

%error           = zeros(1, epochs);
% add patterns w/bias.

w               = rand(hidden, insize+1);
v               = rand(outsize, hidden+1);
dw              = zeros(hidden, insize+1);
dv              = zeros(outsize, hidden+1);
patterns        = [patterns; ones(1, ndata)];
% initialize the variables and the patterns w/bias.
%gridsize        = sqrt(ndata);

for i = 1:epochs
    hin         = w * patterns;
    hout        = [2 ./ (1+exp(-hin)) - 1; ones(1,ndata)];
    oin         = v * hout;
    out         = 2 ./ (1+exp(-oin)) - 1;
    % the forward pass.
    
    delta_o = (out - targets) .* ((1 + out) .* (1 - out)) * 0.5;
    delta_h = (v' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
    delta_h = delta_h(1:hidden, :);
    % the backward pass.
    
    dw = (dw .* alpha) - (delta_h * patterns') .* (1-alpha);
    dv = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    % weight update.
    
    %error(i) = sum(abs(sign(out) - targets)./2);
    % update the error.
end

end