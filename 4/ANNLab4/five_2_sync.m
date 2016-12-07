%% 5.2 Sequential update
%%Synchronous update (Little network):

clear all
close all
pict

X = [p1;p2;p3];
N = size(X,2);%units =1024
P = size(X,1);%patterns=3
W = X'*X;
%W = p1'*p1+p2'*p2+p3'*p3; %learning first three

for i=1:N
    for j=1:N
        Wij(i,j) = 0;
        for mu=1:P
            Wij(i,j) = Wij(i,j) + X(mu,i)*X(mu,j);
        end
    end
end
Wij = Wij/N;
%W=W/N;
figure(1);
% Testpatterns:
Xd = [p11;p22];
subplot(3,2,1); vis(X(1,:));
title('p1');
subplot(3,2,3); vis(X(2,:));
title('p2');
subplot(3,2,5); vis(X(3,:));
title('p3');
subplot(3,2,2); vis(Xd(1,:));
title('p11 degraded of p1');
subplot(3,2,4); vis(Xd(2,:));
title('p22 mix of p2 & p3');
%pause(1)
figure(2);
E=[];
for i = 1:2
    % Apply update rule
    figure(2);
    Xd = sgn(W*Xd')';
    subplot(2,2,2); 
    vis(Xd(1,:));
    title('Recall from p11');
    subplot(2,2,4); 
    vis(Xd(2,:));
    title('Recall from p22');
    %pause(0.1)
    E=[E energy(Xd,W)];
end
figure(3);
plot(E');
title('Energy');