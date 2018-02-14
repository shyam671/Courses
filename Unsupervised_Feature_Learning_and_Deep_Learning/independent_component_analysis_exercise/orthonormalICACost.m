function [cost, grad] = orthonormalICACost(theta, visibleSize, numFeatures, patches, epsilon)
%orthonormalICACost - compute the cost and gradients for orthonormal ICA
%                     (i.e. compute the cost ||Wx||_1 and its gradient)

    weightMatrix = reshape(theta, numFeatures, visibleSize);
    
    %cost = 0;
    %grad = zeros(numFeatures, visibleSize);
    numExamples = size(patches,2);
    % -------------------- YOUR CODE HERE --------------------
    % Instructions:
    %   Write code to compute the cost and gradient with respect to the
    %   weights given in weightMatrix.     
    % -------------------- YOUR CODE HERE --------------------
    t1 = sqrt((weightMatrix*patches).^2 + epsilon);                                           %sqrt((Wx).^2 + epsilon)
    
    cost = sum(t1(:))/numExamples;
    
    grad = (((weightMatrix*patches)./t1)*patches');
    
    grad = grad(:)/numExamples;
end

