function [cost,grad] = sparseAutoencoderCost(theta, visibleSize, hiddenSize, ...
                                             lambda, sparsityParam, beta, data)

% visibleSize: the number of input units (probably 64) 
% hiddenSize: the number of hidden units (probably 25) 
% lambda: weight decay parameter
% sparsityParam: The desired average activation for the hidden units (denoted in the lecture
%                           notes by the greek alphabet rho, which looks like a lower-case "p").
% beta: weight of sparsity penalty term
% data: Our 64x10000 matrix containing the training data.  So, data(:,i) is the i-th training example. 
  
% The input theta is a vector (because minFunc expects the parameters to be a vector). 
% We first convert theta to the (W1, W2, b1, b2) matrix/vector format, so that this 
% follows the notation convention of the lecture notes. 

W1 = reshape(theta(1:hiddenSize*visibleSize), hiddenSize, visibleSize);
W2 = reshape(theta(hiddenSize*visibleSize+1:2*hiddenSize*visibleSize), visibleSize, hiddenSize);
b1 = theta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
b2 = theta(2*hiddenSize*visibleSize+hiddenSize+1:end);

%%%%%%%%%%%% Forward Propagation %%%%%%%%%%%%%%%%
A1=data;

%Z1=W1*A1+repmat(b1,1,size(data,2));
Z1=bsxfun(@plus,W1*A1,b1);

A2=sigmoid(Z1);

%Z2=W2*A2+repmat(b2,1,size(data,2));
Z2=bsxfun(@plus,W2*A2,b2);

A3=sigmoid(Z2);

Average_activation = sum(A2,2)/size(data,2);

cost_squre_error=sum(((A3(:) - A1(:)).^2))/(2*size(data,2));

cost_weight_decay=(lambda/2)*(sum(W2(:).^2)+sum(W1(:).^2));

t_KLD1=sparsityParam*(log(sparsityParam./Average_activation));
t_KLD2=(1.-sparsityParam)*(log((1.-sparsityParam)./(1.-Average_activation)));

cost_KLD = beta*sum(t_KLD1+t_KLD2);

cost=cost_squre_error+cost_weight_decay+cost_KLD;

%%%%%%%%%%%%%%%%%% Backpropagation %%%%%%%%%%%%%%%%%%%

delta_W2grad=(A3-A1).*(A3.*(1.-A3));

W2grad=(delta_W2grad/size(data,2))*A2'+(lambda*W2);

b2grad=(delta_W2grad/size(data,2))*ones(size(data,2),1);

d_KLD= beta*(((1.-sparsityParam)./(1.-Average_activation))-(sparsityParam./Average_activation));

%delta_W1grad=(W2'*delta_W2grad + repmat(d_KLD,1,size(data,2))).*(A2.*(1.-A2));
delta_W1grad=(bsxfun(@plus,W2'*delta_W2grad,d_KLD)).*(A2.*(1.-A2));

W1grad=(delta_W1grad/size(data,2))*A1'+(lambda*W1);

b1grad=(delta_W1grad/size(data,2))*ones(size(data,2),1);
%-------------------------------------------------------------------
% After computing the cost and gradient, we will convert the gradients back
% to a vector format (suitable for minFunc).  Specifically, we will unroll
% your gradient matrices into a vector.

grad = [W1grad(:) ; W2grad(:) ; b1grad(:) ; b2grad(:)];

end
%-------------------------------------------------------------------
% Here's an implementation of the sigmoid function, which you may find useful
% in your computation of the costs and the gradients.  This inputs a (row or
% column) vector (say (z1, z2, z3)) and returns (f(z1), f(z2), f(z3)). 

function sigm = sigmoid(x)
  
    sigm = 1 ./ (1 + exp(-x));
end

