%%%Generate a weight matrix by setting the weights to normally distributed random numbers, and try iterating an arbitrary starting state. What happens?
%%%Make the weight matrix symmetric (e.g. by setting w=0.5*(w+w')). What happens now? Why?

clear
clc
pict
%Learn
x = [p1; p2; p3];
xd = [p11; p22];

[npatterns, units] = size(x);
[ndistorts, dummy] = size(xd);

%%%Learn
w = normrnd(0 ,1 ,units, units);
w = 0.5 * ( w + w' );   %Make the weight matrix symmetric

e = - diag(x * w * x') %energy of attractors
ed_ini = - diag(xd * w * xd')%energy of attractors

%update
itr = 0;
maxitr = 300;
ed = zeros(ndistorts, maxitr);
while ~isequal(xd, x) && itr < maxitr
    itr = itr +1;
    for n = 1:ndistorts
        permute = randperm(units); 
        for i = permute   %update asynchronously
            xd(n,i) = sgn(w(i,:) * xd(n,:)')';
        end
        ed(n, itr) = - xd(n,:) * w * xd(n,:)'; %energy of distort patterns
        xx = t0(xd);
    end
end 

e_out = [ed_ini,ed(:, 1:itr)]
subplot(2,2,1);
plot(1:(itr+1), e_out(1,:),'-',...
    1,e,'*');
title('Energy for p11');
subplot(2,2,2);
plot(1:(itr+1), e_out(2,:),'-',...
    1,e,'*');
title('Energy for p12');

subplot(2,2,3); 
vis(xd(1,:));
title('Recall from p11');
subplot(2,2,4); 
vis(xd(2,:));
title('Recall from p22');