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
maxitr = 500;
ed = zeros(ndistorts, maxitr);

% %update asynchronously
for itr = 1: maxitr
    for n = 1:ndistorts
        permute = randperm(units); 
        for i = permute   
            xd(n,i) = sgn(w(i,:) * xd(n,:)')';
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
