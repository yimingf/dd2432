%% 5.6 Sparse patterns

close all;
clear;
pict; % Load data

% Parameters
N = 100;
rho = 0.05; % Rate of active units
theta = 0.5; % Bias term
iters = 5;

% initial patterns
maxNumPatterns = 70;

% Create initial pattern and add it to X
pattern = zeros(1, N);
activeUnitsIndices = randperm(N, N * rho);
pattern(activeUnitsIndices) = 1;
X = [pattern];

successRatios = [];
patternSizes = [];

% For the number of patters 10 to maxNumPatterns
for numPatterns=2:maxNumPatterns, numPatterns
    
    % Add a new random pattern
    pattern = zeros(1, N);
    activeUnitsIndices = randperm(N, N * rho);
    pattern(activeUnitsIndices) = 1;
    X = [X; pattern];
    
    % Create weights with average of 0
    W = (X' - rho) * (X - rho);
    
    successPerBias = [];
    for bias=-1:0.5:1
        
        % find out how many registered patterns that can be restored
        numSuccessfull = 0;
        
        for p=1:numPatterns
            
            start = X(p, :);
            target = start;
            
            %d = flip(start, 15); % flip some of the bits
            d = start;
            
            for i=1:iters
                %d = sgn(W * d')';
                d = 0.5 + (0.5 * sign((W * d')' - bias));
            end
            
            if sum(ismember(target, d, 'rows')) > 0
                numSuccessfull = numSuccessfull + 1;
            end
        end
        
        successPerBias = [successPerBias (numSuccessfull/numPatterns)];
        %successRatios(bias) = [successRatios(bias) (numSuccessfull/numPatterns)];
        
    end
    successRatios = [successRatios; successPerBias];
    patternSizes = [patternSizes numPatterns];
end

myMap = [
    0 0 0
    0 0 1
    0 1 0
    0 1 1
    1 0 0
    1 0 1
    1 1 0
    1 1 1
];

%myMap = rand(size(successRatios, 2), 3);

% plot((0.138 * 100), 1, '*r');
hold on;
for i=1:size(successRatios, 2)
    %patternSizes
    %successRatios(i)
    plot(patternSizes, successRatios(:, i), '-s', 'Color', myMap(i,:));
    hold on;
    %figure;
end

%plot(patternSizes, successRatios, (0.138 * 100), 1, '*r');
xlabel('Number of patterns');
ylabel('Success Rate');
axis([1 maxNumPatterns 0 1.1])