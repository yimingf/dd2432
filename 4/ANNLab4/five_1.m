%% 5.1 Convergence and attractors
clear;

%% Input data
x1 = vm([0 0 1 0 1 0 0 1]);
x2 = vm([0 0 0 0 0 1 0 0]);
x3 = vm([0 1 1 0 0 1 0 1]);
% x4 = vm([0 1 1 1 1 1 0 1]); % Extra test x

x1d = vm([1 0 1 0 1 0 0 1]); % 1 bit err
x2d = vm([1 1 0 0 0 1 0 0]); % 2 bit err
x3d = vm([1 1 1 0 1 1 0 1]); % 2 bit err

% Various cases
X = [x1; x2; x3;];                 % Original, 14
% X = [x1; x2; x3; x1; x1];          % Fewer, 8
%X = [x1; x2; x3; x1; x2; x3];      % Same, 14
%X = [x1; x2; x3; x4];              % More, 21
% X = [x2;x1;];

Xd = [x1d; x2d; x3d];

N = size(X, 2)
X
attractors = [-2 -2 -2 -2 -2 -2 -2 -2]; % With a dummy row

%% Weight matrix
W = X' * X

% Is the diagonal supposed to be 0s? This will never terminate
% for i=1:N
%    W(i,i) = 0; 
% end

%% A. Get rid of noise

%  xd = x2d;
 xd =[x1d; x2d; x3d];
% xd =vm([1 1 0 1 1 0 0 1]);
iters = 0;

while sum(ismember(X, sgn(xd), 'rows')) == 0
    
    xd = sgn((W * xd')');
    
    iters = iters + 1;
end

disp(iters)

%% B. Find the number of attractors
attractors = [];
for i=0:2^N-1
    
   d = vm(abs(de2bi(i, N))); % test vectors 00000000, 0000001, ...11111111
   dprev = d;
   delta = 1;
   
   it = 0;
   while delta > 0
    d = sgn(W * d')';
    delta = sum(abs(d - dprev));
    dprev = d;
    it = it +1;
   end
   
   if sum(ismember(attractors, d, 'rows')) == 0 % New attractor found
       attractors = [attractors; d];
   end
end

t0(attractors)
size(attractors)