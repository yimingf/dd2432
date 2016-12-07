%%%Test energy on 5.1
clear
x1 = vm([0 0 1 0 1 0 0 1]);
x2 = vm([0 0 0 0 0 1 0 0]);
x3 = vm([0 1 1 0 0 1 0 1]);
x1d = vm([1 0 1 0 1 0 0 1]);
x2d = vm([1 1 0 0 0 1 0 0]);
x3d = vm([1 1 1 0 1 1 0 1]);

x = [x1; x2; x3];
xd = [x1d; x2d; x3d];
[npatterns, units] = size(x);
[ndistorts, dummy] = size(xd);

%%%Learn
w = x' * x;
%w = w + diag(-diag(w)); %%???diag = 0???
e = - diag(x * w * x') %energy of attractors
ed_ini = - diag(xd * w * xd');%energy of attractors

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

% e = diag(x * w * x')
% 
% 
% w = normrnd(0 ,1 ,units, units)
% w = 0.5 * ( w + w' )