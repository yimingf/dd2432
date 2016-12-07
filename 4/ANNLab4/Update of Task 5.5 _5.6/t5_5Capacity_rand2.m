clc, clear, pict

%x_i           = [p1; p2; p3; p4; p5; p6; p7;p8;p9];%sgn(randn(1,1024)); sgn(randn(1,1024)); sgn(randn(1,1024))];%p5; p6; p7];
%x_i           = sgn(randn(300,100));%sgn(randn(1,1024)); sgn(randn(1,1024)); sgn(randn(1,1024))];
x=[];
% load the attractors.
%[p, N]      = size(x);
%w           = x' * x;
%epochs      = 100;
create = 50;
N=100;

capacity = [];
stablity = [];
for i = 1 : create
    x= [x;sgn(randn(1,100)+0.5)];
    W  = x' * x;
    W = W + diag(-diag(W));
    c=0;
    s = 0;
    for j = 1:i
        if isequal(sgn(W * x(j,:)')', x(j,:))
            c = c+1;
            if j~=i
                s=s+1;
            end
        end
    end
    c=c/i;
    capacity = [capacity, c];
    if i == 1
        s = 0;
    else
        s = s/(i-1);
    end
    stablity = [stablity, s];
end

subplot(1,2,1);
plot(capacity);
title('capacity');
subplot(1,2,2);
plot(stablity);
title('stablity');