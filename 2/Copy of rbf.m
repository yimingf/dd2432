 
%Matlab code for Radial Basis Functions
clc;
x=-1:0.05:1;
%generating training data with Random Noise
for i=1:length(x)
    y(i)=1.2*sin(pi*x(i))-cos(2.4*pi*x(i))+0.3*randn;
end
% Framing the interpolation matrix for training data
t=length(x);
for i=1:1:t 
    for j=1:1:t
        h=x(i)-x(j);
        k=h^2/.02;
        train(i,j)=exp(-k);
    end
end
W=inv(train)*y';
% Testing the trained RBF
xtest=-1:0.01:1;
%ytest is the desired output
ytest=1.2*sin(pi*xtest)-cos(2.4*pi*xtest);
% Framing the interpolation matrix for test data
t1=length(xtest);
t=length(x);
for i=1:1:t1 
    for j=1:1:t
        h=xtest(i)-x(j);
        k=h^2/.02;
        test(i,j)=exp(-k);
    end
end
actual_test=test*W;
        % Plotting the Performance of the network
        figure;
        plot(xtest,ytest,'b-',xtest,actual_test,'r+');
        xlabel('Xtest value');
        ylabel('Ytest value');
        h = legend('Desired output','Approximated curve',2);
        set(h);
 
