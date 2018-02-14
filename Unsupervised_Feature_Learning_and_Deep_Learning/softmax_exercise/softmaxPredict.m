function [pred] = softmaxPredict(softmaxModel, data)

% softmaxModel - model trained using softmaxTrain
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
%
% Your code should produce the prediction matrix 
% pred, where pred(i) is argmax_c P(y(c) | x(i)).
 
% Unroll the parameters from theta
theta = softmaxModel.optTheta;  % this provides a numClasses x inputSize matrix
size(theta)
pred = zeros(1, size(data, 2));
%size(pred)
%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute pred using theta assuming that the labels start 
%                from 1.

Z1 = theta*data;

M = bsxfun(@minus, Z1, max(Z1, [], 1));
M=exp(M);

Z33 = bsxfun(@rdivide,M,sum(M));
for i=1:size(data,2)
    [~,I]=max(Z33(:,i));
    pred(i)= I;
end
size(pred)
%pred = max(log(Z33));
%size(Z3)
% ---------------------------------------------------------------------
end

