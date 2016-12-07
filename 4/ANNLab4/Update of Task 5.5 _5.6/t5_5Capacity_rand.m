clc, clear, pict

%x_i           = [p1; p2; p3; p4; p5; p6; p7;p8;p9];%sgn(randn(1,1024)); sgn(randn(1,1024)); sgn(randn(1,1024))];%p5; p6; p7];
x           = [];%sgn(randn(1,1024)); sgn(randn(1,1024)); sgn(randn(1,1024))];
% load the attractors.
%[p, N]      = size(x);
%w           = x' * x;
%epochs      = 100;
create = 300;
N=1024;

capacity = [];
for i = 1 : create
    x= [x;sgn(randn(1,1024))+0.5]; %bias
    W  = x' * x;
    
    c=0;
    for j = 1:i
        if isequal(sgn(W * x(j,:)')', x(j,:))
            c = c+1;
        end
    end
    c=c/i;
    capacity = [capacity, c];
end

plot(capacity);
