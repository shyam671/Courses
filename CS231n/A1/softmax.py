import numpy as np
from random import shuffle

def softmax_loss_naive(W, X, y, reg):
  """
  Softmax loss function, naive implementation (with loops)

  Inputs have dimension D, there are C classes, and we operate on minibatches
  of N examples.

  Inputs:
  - W: A numpy array of shape (D, C) containing weights.
  - X: A numpy array of shape (N, D) containing a minibatch of data.
  - y: A numpy array of shape (N,) containing training labels; y[i] = c means
    that X[i] has label c, where 0 <= c < C.
  - reg: (float) regularization strength

  Returns a tuple of:
  - loss as single float
  - gradient with respect to weights W; an array of same shape as W
  """
  # Initialize the loss and gradient to zero.
  loss = 0.0
  dW = np.zeros_like(W)
      
  for i in xrange(X.shape[0]):
    score = X[i].dot(W)
    score -= np.amax(score)
    score = np.exp(score)
    
    score_sum = np.sum(score) 
    score_div = score/score_sum
    #print(score_div[y[i]])
    lossi = np.log(score_div[y[i]])
    loss -= lossi
    dW += X[i].reshape(X[i].shape[0],1).dot(score_div.reshape(score_div.shape[0],1).T)
    dW[:,y[i]] -= X[i]
  
  loss /= X.shape[0]
  loss += 0.5*reg*np.sum(W*W)
    
  dW /= X.shape[0]
  dW += reg*W
  #score = X.dot(W)
  #score -= np.amax(score,axis = 1).reshape(score.shape[0],1)
  
  #score_exp  = np.exp(score)
  #score_sum_exp = np.sum(np.exp(score), axis = 1).reshape(score.shape[0],1)
  #score_sum_div = score_exp/score_sum_exp
    
  #x_index =  xrange(X.shape[0])
  #index = np.zeros_like(score)
  #index[x_index,y] = 1
  
  #loss = index*score_sum_div
  #loss = -np.log(np.sum(loss))/X.shape[0] + 0.5*reg*np.sum(W*W)
  
  #############################################################################
  # TODO: Compute the softmax loss and its gradient using explicit loops.     #
  # Store the loss in loss and the gradient in dW. If you are not careful     #
  # here, it is easy to run into numeric instability. Don't forget the        #
  # regularization!                                                           #
  #############################################################################
  pass
  #############################################################################
  #                          END OF YOUR CODE                                 #
  #############################################################################

  return loss, dW


def softmax_loss_vectorized(W, X, y, reg):
  """
  Softmax loss function, vectorized version.

  Inputs and outputs are the same as softmax_loss_naive.
  """
  # Initialize the loss and gradient to zero.
  loss = 0.0
  dW = np.zeros_like(W)
  score = X.dot(W)
  score -= np.amax(score,axis = 1).reshape(score.shape[0],1)
  
  score_exp  = np.exp(score)
  score_sum_exp = np.sum(score_exp, axis = 1).reshape(score.shape[0],1)
  score_sum_div = score_exp/score_sum_exp
    
  x_index =  xrange(X.shape[0])
  index = np.zeros_like(score)
  index[x_index,y] = 1
 
  loss = index*score_sum_div
  #print(loss[0:10,:])
  loss = np.sum(loss, axis = 1)
  loss = -np.sum(np.log(loss))/X.shape[0] + 0.5*reg*np.sum(W*W)
  
  dW = X.T.dot(score_sum_div) - X.T.dot(index) 
  dW /= X.shape[0] 
  dW += reg*W
  #############################################################################
  # TODO: Compute the softmax loss and its gradient using no explicit loops.  #
  # Store the loss in loss and the gradient in dW. If you are not careful     #
  # here, it is easy to run into numeric instability. Don't forget the        #
  # regularization!                                                           #
  #############################################################################
  pass
  #############################################################################
  #                          END OF YOUR CODE                                 #
  #############################################################################

  return loss, dW

