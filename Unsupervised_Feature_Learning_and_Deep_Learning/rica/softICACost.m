%% Your job is to implement the RICA cost and gradient
function [cost,grad] = softICACost(theta, x, params)

% unpack weight matrix
W = reshape(theta, params.numFeatures, params.n);

% project weights to norm ball (prevents degenerate bases)
Wold = W;
W = l2rowscaled(W, 1);
%numExamples = size(x,2);

%%% YOUR CODE HERE %%%

t1 = sqrt((W*x).^2 + params.epsilon);                    % sqrt ((Wx).^2 + epsilon)

t2 = (W'*W*x - x);                                        %% 

cost = (params.lambda*sum(t1(:)) + (sum(t2(:).^2))/2);

temp_grad1 = params.lambda*(((W*x)./t1)*x');

temp_grad2 = W*t2*x' + W*x*(t2)' ; 

Wgrad = (temp_grad1 + temp_grad2);
% unproject gradient for minFunc
grad = l2rowscaledg(Wold, W, Wgrad, 1);
grad = grad(:);