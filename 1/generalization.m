% partly reused wang huijie(my teammate)'s code
n           = 25;

%split data
%nsepdata
%original function
X           = [-5:0.25:5]';
Y           = X;
Z           = exp(-X .* X * 0.1) * exp(-Y .* Y * 0.1)' - 0.5;
mesh(X, Y, Z);
axis([-5 5 -5 5 -0.7 0.7]);

%reshape function
[gridsize, ~] = size(Z);
ndata       = gridsize ^ 2;
targets     = reshape (Z, 1, ndata);
[xx, yy]    = meshgrid(X, Y);
patterns    = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];

%random
permute     = randperm(ndata);
[~,pos]     = sort(permute);
patterns    = patterns(:,permute);
targets     = targets(:,permute);

patterns_   = patterns;
targets_    = targets;
patterns    = patterns_(:, 1:n);
targets     = targets_(:, 1:n);
test_patterns = patterns_(:, (n+1):end);
test_targets = targets_(:, (n+1):end);

%%%%first pass
[insize, ndata] = size(patterns);
[outsize, ~] = size(targets);
epoch       = 1000;
hidden      = 100;

%initial data & weights
x           = [patterns; ones(1, ndata)];
w           = [randn(hidden,insize), zeros(hidden,1)];
v           = [randn(outsize,hidden), zeros(outsize,1)];
eta         = 0.001;
alpha       = 0.9;
dw          = 0;
dv          = 0;

error = [];

for i = 1:epoch
    %forward pass
    hin     = w * x;
    hout    = [2./ (1+exp(-hin)) - 1 ; ones(1,ndata)];

    oin     = v * hout;
    out     = 2./ (1+exp(-oin)) - 1;

    %backward pass
    delta_o = (out - targets) .* ((1 + out) .* (1 - out)) * 0.5;
    delta_h = (v' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
    delta_h = delta_h(1:hidden, :); %removing extra row

    %weight update
    dw      = (dw .* alpha) - (delta_h * x') .* (1-alpha);
    dv      = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
    w       = w + dw .* eta;
    v       = v + dv .* eta;
    
    %plot seperation?
    %plot_pattern(w, patterns, targets);
    %save error
    %error   = [error; sum(sum(abs(sign(out) - targets)./2))];
end

train_out   = out;


%%%%second pass: calculate error
[insize, ndata] = size(test_patterns);
[outsize, ~] = size(test_targets);

%initial data & weights
x           = [test_patterns; ones(1, ndata)];

%forward pass
hin         = w * x;
hout        = [2./ (1+exp(-hin)) - 1 ; ones(1,ndata)];
oin         = v * hout;
out         = 2./ (1+exp(-oin)) - 1;
zz          = [train_out, out];

zz          = zz(:,pos);
zz          = reshape(zz, gridsize, gridsize);
mesh(X, Y, zz);
drawnow;