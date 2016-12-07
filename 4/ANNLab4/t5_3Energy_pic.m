%%%Test energy on 5.2

clear
clc
pict
%Learn
x = [p1; p2; p3];
xd = [p11; p22];

[npatterns, units] = size(x);
[ndistorts, dummy] = size(xd);

%%%Learn
w = x' * x; %/units;
%w = w + diag(-diag(w)); %%???diag = 0???
e = - diag(x * w * x') %energy of attractors
ed_ini = - diag(xd * w * xd')%energy of attractors

%update
maxitr = 20;
itr = 0;
ed = zeros(ndistorts, maxitr);
ed_detailed = zeros(ndistorts, maxitr*units);
while ~isequal(xd, x) && itr < maxitr
    itr = itr +1;
    for n = 1:ndistorts
        permute = randperm(units); 
        dummy = 1;
        for i = permute   %update asynchronously
            xd(n,i) = sgn(w(i,:) * xd(n,:)')';
            ed_detailed(n, ((itr-1)*units+dummy)) = - xd(n,:) * w * xd(n,:)';
            dummy = dummy + 1;
        end
        ed(n, itr) = - xd(n,:) * w * xd(n,:)'; %energy of distort patterns
        xx = t0(xd);
    end
end 

%Little Model
% for itr = 1:maxitr
%     xd = sgn(w * xd')';
%     ed(:, itr) = - diag(xd * w * xd');
% end 

figure(1)
plot(1:size(ed_detailed,2), ed_detailed(1,:),'-',...
     1:size(ed_detailed,2), ed_detailed(2,:),'-',...
     1,e,'*');
axis([0, 10000, -2000000, 0]);

figure(2)
e_out = [ed_ini,ed(:, 1:itr)];
subplot(2,2,1);
plot(1:(itr+1), e_out(1,:),'-',...
    1,e(1),'*');
title('Energy for p11');
subplot(2,2,2);
plot(1:(itr+1), e_out(2,:),'-',...
    1,e(2:3),'*');
title('Energy for p12');

subplot(2,2,3); 
vis(xd(1,:));
title('Recall from p11');
subplot(2,2,4); 
vis(xd(2,:));
title('Recall from p22');
