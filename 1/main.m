% main script for dd2432, lab 1

patterns    = nsepdata();
%patterns   = sepdata();
% create random input patterns.
foo         = ones(1, 100);
targets     = [foo, -1*foo];
ndata       = 200;

%patterns    = eye(8) * 2 - 1;
%targets     = patterns;
% for the encoder problem.

%x=[-5:1:5]';
%y=x;
%z=exp(-x.*x*0.1) * exp(-y.*y*0.1)' - 0.5;
%[gridsize, ~]  = size(x);
%ndata       = gridsize ^ 2;

%targets     = reshape (z, 1, ndata);
%[xx, yy]    = meshgrid (x, y);
%patterns    = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];
% for function approximation.

permute     = randperm(ndata);
%[~,pos]     = sort(permute);
patterns    = patterns(:, permute);
targets     = targets(:, permute);
% add to patterns and target w/random order.

epochs      = 200;
eta         = 0.05;
alpha       = 0.9;
hidden      = 3;
% set the value of parameters.

weight     = delta(patterns, targets, eta, epochs);
%out         = delta_twolayer(patterns, targets, eta, epochs, alpha, hidden);    
% operate the delta function.

%zz          = out(:,pos);
%zz          = reshape(zz, gridsize, gridsize);
%mesh(x, y, zz);
%axis([-5 5 -5 5 -0.7 0.7]);
%drawnow;