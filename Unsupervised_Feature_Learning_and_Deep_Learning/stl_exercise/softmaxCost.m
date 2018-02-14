function [cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, data, labels)

% numClasses - the number of classes 
% inputSize - the size N of the input vector
% lambda - weight decay parameter
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
% labels - an M x 1 matrix containing the labels corresponding for the input data
%

% Unroll the parameters from theta
theta = reshape(theta, numClasses, inputSize);
numCases = size(data, 2);

groundTruth = full(sparse(labels, 1:numCases, 1));

cost = 0;

thetagrad = zeros(numClasses, inputSize);
size(thetagrad);
%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute the cost and gradient for softmax regression.
%                You need to compute thetagrad and cost.
%                The groundTruth matrix might come in handy.

Z1 = theta*data;

M = bsxfun(@minus, Z1, max(Z1, [], 1));
M=exp(M);

Z33 = bsxfun(@rdivide,M,sum(M));

Z3 = log(Z33).*groundTruth;

cost = -1*(sum(Z3(:))/numCases) + (lambda/2)*(sum(theta(:).^2));

thetagrad = -1*((groundTruth - Z33)*data')/numCases + lambda*theta;
% ------------------------------------------------------------------
% Unroll the gradient matrices into a vector for minFunc
grad = [thetagrad(:)];
end

