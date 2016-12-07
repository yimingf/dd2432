plotinit
data=read('cluster');
units=3;
% Plot data and place rbf units randomly
vqinit;
% Winner takes all strategy (only the unit having the higher score is updated)
singlewinner=1; %0 updates all rbf clusters

%vqstep; %One iteration
vqiter; %Successive iterations