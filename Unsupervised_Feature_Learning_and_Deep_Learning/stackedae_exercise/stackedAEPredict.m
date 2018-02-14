function [pred] = stackedAEPredict(theta, inputSize, hiddenSize, numClasses, netconfig, data)
                                         
% stackedAEPredict: Takes a trained theta and a test data set,
% and returns the predicted labels for each example.
                                         
% theta: trained weights from the autoencoder
% visibleSize: the number of input units
% hiddenSize:  the number of hidden units *at the 2nd layer*
% numClasses:  the number of categories
% data: Our matrix containing the training data as columns.  So, data(:,i) is the i-th training example. 

% Your code should produce the prediction matrix 
% pred, where pred(i) is argmax_c P(y(c) | x(i)).
 
%% Unroll theta parameter

% We first extract the part which compute the softmax gradient
softmaxTheta = reshape(theta(1:hiddenSize*numClasses), numClasses, hiddenSize);

% Extract out the "stack"
stack = params2stack(theta(hiddenSize*numClasses+1:end), netconfig);

%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute pred using theta assuming that the labels start 
%                from 1.

A1 = data;

Z1 = bsxfun( @plus, stack{1}.w*A1, stack{1}.b );

A2 = sigmoid(Z1);

Z2 = bsxfun( @plus, stack{2}.w*A2, stack{2}.b );

A3 = sigmoid(Z2);

Y1 = softmaxTheta*A3;

M1 = bsxfun(@minus, Y1, max(Y1, [], 1));

M1 = exp(M1);

Y33 = bsxfun(@rdivide,M1,sum(M1));

%Y3 = log(Y33).*groundTruth;


for i=1:size(data,2)
    
    [~,I]=max(Y33(:,i));
    
    pred(i)= I;
    
end






% -----------------------------------------------------------

end


% You might find this useful
function sigm = sigmoid(x)
    sigm = 1 ./ (1 + exp(-x));
end
