function [e]=energy(x,w)
nx = size(x,1);
nw =size(w,1);
e=[];
for k= 1:nx
    su=0;
for i= 1:nw
    for j=1:nw
        su=su+w(i,j)*x(i)*x(j);        
    end
    
end
e=[e ;-su];
end