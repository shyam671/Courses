function [cost, grad] = sparseCodingWeightCost(weightMatrix, featureMatrix, visibleSize, numFeatures,  patches, gamma, lambda, epsilon, groupMatrix)
%sparseCodingWeightCost - given the features in featureMatrix, 
%                         computes the cost and gradient with respect to
%                         the weights, given in weightMatrix
% parameters
%   weightMatrix  - the weight matrix. weightMatrix(:, c) is the cth basis
%                   vector.
%   featureMatrix - the feature matrix. featureMatrix(:, c) is the features
%                   for the cth example
%   visibleSize   - number of pixels in the patches
%   numFeatures   - number of features
%   patches       - patches
%   gamma         - weight decay parameter (on weightMatrix)
%   lambda        - L1 sparsity weight (on featureMatrix)
%   epsilon       - L1 sparsity epsilon
%   groupMatrix   - the grouping matrix. groupMatrix(r, :) indicates the
%                   features included in the rth group. groupMatrix(r, c)
%                   is 1 if the cth feature is in the rth group and 0
%                   otherwise.

    if exist('groupMatrix', 'var')
        assert(size(groupMatrix, 2) == numFeatures, 'groupMatrix has bad dimension');
    else
        groupMatrix = eye(numFeatures);
    end

    numExamples = size(patches, 2);

    weightMatrix = reshape(weightMatrix, visibleSize, numFeatures);
    featureMatrix = reshape(featureMatrix, numFeatures, numExamples);
 
    %   Write code to compute the cost and gradient with respect to the
    %   weights given in weightMatrix.     
    % -------------------- YOUR CODE HERE --------------------
    t1 = weightMatrix*featureMatrix - patches; % As-x
    error_term = (t1).^2 ;  % (As-x)^2
    
    t2 = groupMatrix*(featureMatrix.^2) + epsilon ; %% Vss' + e
    sparse_term = lambda*(sqrt(t2));   % lambda* sqrt(Vss' +e)
    
    weight_decay_term = gamma*(weightMatrix.^2);                    % gamma * (A^2)
    
    cost = (sum(error_term(:)) + sum(sparse_term(:)))/numExamples + sum(weight_decay_term(:));   
    
    temp_grad = (2*t1*(featureMatrix'))./numExamples + 2*gamma*(weightMatrix);   %% 2*(As -x)*s' 
    
    grad = temp_grad(:);   
    
end