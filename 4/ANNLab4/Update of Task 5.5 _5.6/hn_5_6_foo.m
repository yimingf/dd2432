

%x           = sign(0.5+randn(300,100));%sign(randn(300, 100));
%x           = t0(sign(randn(300,100)-bias));%sign(randn(300, 100));
x = zeros(300,100);
[p, n] = size(x);
for i = 1:300
    activeUnitsIndices = randperm(p, n * rho);
    x(i,activeUnitsIndices) = 1;
end
% load the attractors.
clc, clear
epochs      = 10;
rho         = 0.1;
theta       = 0:0.5:4;

W = (x-rho)' * (x-rho);
W = W + diag(-diag(W));
d=x;

capacity = [];
for bias = theta
    
    c=0;
    for j = 1:p
        for k = 1:5
            d = 0.5 + (0.5 * sign((W * d')' - bias));
        end
        for k= 1:p
            if ismember(d(p,:), x,'rows')
                c = c+1;
            end
        end
    end
    c=c/p;
    capacity = [capacity, c];
end

plot(theta, capacity);
   