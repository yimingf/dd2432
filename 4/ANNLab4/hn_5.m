clc, clear, pict

x           = [p1; p2; p3; p4; sgn(randn(1,1024)); sgn(randn(1,1024)); sgn(randn(1,1024))];%p5; p6; p7];
% load the attractors.
[p, n]      = size(x);
w           = x' * x;
epochs      = 100;

% Testpatterns:
d           = [p11; p22];
subplot(3,4,1); vis(x(1,:)); title('p1');
subplot(3,4,2); vis(x(2,:)); title('p2');
subplot(3,4,3); vis(x(3,:)); title('p3');
subplot(3,4,4); vis(x(4,:)); title('p4');
subplot(3,4,5); vis(x(5,:)); title('p5');
subplot(3,4,6); vis(x(6,:)); title('p6');
subplot(3,4,7); vis(x(7,:)); title('p7');
subplot(3,4,8); vis(d(1,:)); title('p11 degraded of p1');
subplot(3,4,9); vis(d(2,:)); title('p22 mix of p2 & p3');

for i       = 1 : epochs
    % apply the update rule.
    d       = sgn(w*d')';
end

subplot(3,4,10); 
vis(d(1,:));
title('Recall from p11');
subplot(3,4,11); 
vis(d(2,:));
title('Recall from p22');