%Sparse Patterns
%Test is not successfull TAT

clc, clear

epochs = 50;
rho = 0.1;  %sparse rate, rho = 0.1 or 0.05 or 0.01 %only 10% neurons active
theta = 0:0.1:5; %bias rate
patternsize = 100;
units = 100;

x_ini = zeros(patternsize,units);
for i = 1:patternsize
    activeUnitsIndices = randperm(units, units * rho);
    x_ini(i,activeUnitsIndices) = 1;
end

capacity = [];
for bias = theta
    x = [];
    for i = 1:patternsize
        i
        x = [x; x_ini(i,:)];
        w = (x'-rho) * (x-rho);
        w = w + diag(-diag(w));
        d = 0.5 + (0.5 * sgn((w * x')' - bias)); %Slightly update rule
    	if isequal(d, x) == 0
            capacity = [capacity, i];
            break;
        end
    end
end

plot(theta, capacity);
axis([theta(1) theta(end) 0 patternsize]);