neighbor_size=4;
epochs = 100;
a=zeros(1,epochs);
for i= 1:epochs
    a(i) = neighbor_size;
    neighbor_size = floor(neighbor_size * exp(-i/1000));
end

plot(a)
xlabel('epochs');
ylabel('neighbour');