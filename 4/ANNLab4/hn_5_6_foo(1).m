clc, clear

x           = sign(0.5+randn(300,100));%sign(randn(300, 100));
% load the attractors.
[p, n]      = size(x);
epochs      = 10;
rho         = 0.1;
theta       = 0.1;

for i=1:n
    for j=1:n
        Wij(i,j) = 0;
        for mu=1:p
            Wij(i,j) = Wij(i,j) + (x(mu,i) - rho) * (x(mu,j) - rho);
        end
    end
end
w           = Wij;

% Testpatterns:
d_foo       = randn(1, 100);
d           = d_foo;
dist        = zeros(1, p);

for i = 1 : p
    foo     = x(1:i, :);
    w       = foo' * foo;
    w       = w - diag(diag(w));
    bar     = d_foo;
    for j = 1 : epochs  
        % apply the update rule.
        bar = 0.5 + 0.5 * sgn(w*bar' - theta)';
    end
    dist(i) = sum(sign(abs(d - bar)), 2); % replace by d.
    d       = bar;
end
 
plot(dist);