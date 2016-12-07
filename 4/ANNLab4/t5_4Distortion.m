pict

% subplot(1, 2, 1);
% vis(p1);
% subplot(1, 2, 2);
% vis(p1dist);

x = [p1; p2; p3];
[npatterns, units] = size(x);
%%%Learn
w = x' * x; %/units;


%%%Add noise
noise = [0, 0.2, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.8, 1];
xd = [];
for i = noise
    p1dist = flip(p1, units * i);
    p2dist = flip(p2, units * i);
    p3dist = flip(p3, units * i);
    xd = [xd; p1dist; p2dist; p3dist];
end
    
itr = 50;

%Little Model
for i = 1:itr
    xd = sgn(w * xd')';
end 

figure(1) 
for i = 1 : 18
    subplot(6,3,i); 
    vis(xd(i,:));
    if mod(i,3) == 0   
        title(['noise = ' num2str(noise(i/3))]);
    end
end

figure(2) 
for i = 19 : (size(xd,2))
    subplot(5,3,(i-18)); 
    vis(xd(i,:));
    if mod(i,3) == 0   
        title(['noise = ' num2str(noise(i/3))]);
    end
end





