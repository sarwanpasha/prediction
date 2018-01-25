targetsVector = [1 1 1 1 1 1]; % True classes
outputsVector = [1 2 1 1 3 2]; % Predicted classes
% Convert this data to a [numClasses x 6] matrix
targets = zeros(length(unique(outputsVector)),length(targetsVector));
outputs = zeros(length(unique(outputsVector)),length(outputsVector));
targetsIdx = sub2ind(size(targets), targetsVector, 1:length(targetsVector));
outputsIdx = sub2ind(size(outputs), outputsVector, 1:length(outputsVector));
targets(targetsIdx) = 1;
outputs(outputsIdx) = 1;
% Plot the confusion matrix for a 3-class problem
plotconfusion(targets,outputs)