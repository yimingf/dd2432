% dd2432, lab 3

% clear, animals
% patterns        = props;
% y               = 100;
% epochs          = 100;
% [~, pos]        = som_3(patterns, y, epochs);

% [~, order]      = sort(pos);
% snames(order)'
% part 3, topological ordering of animal species.

% clear, cities
% patterns        = city;
% y               = 10;
% epochs          = 100;
% weight          = som_4(patterns, y, epochs);
% 
% tour            = [weight; weight(1, :)];
% plot(tour(:, 1), tour(:, 2), 'b-*', city(:, 1), city(:, 2), '+')
% part 4, cyclic tour.

clear
