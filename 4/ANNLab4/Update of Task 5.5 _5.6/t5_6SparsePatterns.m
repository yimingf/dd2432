%Sparse Patterns
%Test is not successfull TAT

clc, clear

epochs = 50;
rho = 0.05;  %sparse rate, rho = 0.1 or 0.05 or 0.01 %only 10% neurons active
theta = 0:0.1:5; %bias rate
patternsize = 90;
units = 100;

x = zeros(patternsize,units);
[p, n] = size(x);
for i = 1:p
    activeUnitsIndices = randperm(n, n * rho);
    x(i,activeUnitsIndices) = 1;
end

w = (x'-rho) * (x-rho);
w = w + diag(-diag(w));

capacity = [];
for bias = theta
    d = 0.5 + (0.5 * sgn((w * x')' - bias)); %Slightly update rule
    c = sum(ismember(d, x,'rows'));
    capacity = [capacity, c/p];
end

plot(theta, capacity);
axis([theta(1) theta(end) 0 1]);