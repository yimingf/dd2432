clc, clear, pict

x_i           = [p1; p2; p3; p4; p5; p6; p7;p8;p9];%sgn(randn(1,1024)); sgn(randn(1,1024)); sgn(randn(1,1024))];%p5; p6; p7];
% load the attractors.
[p, N]      = size(x_i);
%w           = x' * x;
%epochs      = 100;

capacity = [];
for i = 1 : 9
    x= x_i(1:i, :);
    W  = x' * x;
    
    c=0;
    for j = 1:i
        if isequal(sgn(W * x(i,:)')', x(i,:))
            c = c+1;
        end
    end
    c=c/i;
    capacity = [capacity, c];
end

plot(capacity);
