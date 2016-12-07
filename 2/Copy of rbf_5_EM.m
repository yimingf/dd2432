plotinit
data=read('cluster');
units=3;
% Plot data and place rbf units randomly
vqinit;
singlewinner=1;

% EM algorithm
%emstepb; %One iteration
emiterb; %Multiple iterations