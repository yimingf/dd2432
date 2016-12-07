%% 5.2 Sequential update
%%Asynchronous update: 
%%(Each iteration updating one unit)

clc
clear;
pict; % Load data

% Weight matrix. Select units randomly
W = p1' * p1 + p2' * p2 + p3' * p3;

% Parameters
iters = 3000;

% Choose degraded image
d = p11;
%d = p22;

for i=1:iters
    % Pick a random number between 1 and 1024

   idx = randi([1,1024]); 
 
      d(idx) = sgn(sum(W(idx,:) .* d))';
   
%    if mod(i,100)==0
%        vis(d)
%        pause(1)
%    end

end

vis(d);