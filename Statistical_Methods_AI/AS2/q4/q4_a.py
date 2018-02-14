#!/usr/bin/env python

import numpy as np
import sys
from sklearn.preprocessing import StandardScaler
from sklearn import linear_model

train = sys.argv[1]
test = sys.argv[2]

raw_train_data = np.genfromtxt(train,delimiter=',')
raw_test_data = np.genfromtxt(test,delimiter=',')

trainLabels = raw_train_data[np.arange(0,raw_train_data.shape[0]),raw_train_data.shape[1]-1]
trainData = raw_train_data[:,np.arange(0,raw_train_data.shape[1]-1)]
trainData = StandardScaler().fit_transform(trainData)

#testLabels = raw_test_data[np.arange(0,raw_test_data.shape[0]),raw_test_data.shape[1]-1]
testData = raw_test_data
testData = StandardScaler().fit_transform(testData)

trainLabels[trainLabels==0] = -1
#testLabels[testLabels==0] = -1
# Best threshold is 0.001 feature scaling helps in reaching the results faster
Alpha = (1,1e-1,1e-2,1e-3,1e-4,1e-5)

reg = linear_model.Lasso(alpha =1e-4,fit_intercept=True, normalize=False, precompute=False, copy_X=True, max_iter=1000, tol=0.001, warm_start=False, positive=False)

reg.fit(trainData,trainLabels)

Score = reg.predict(testData)

Score[Score>0] = 1
Score[Score<=0] = 0
for i in range(len(Score)):
  print int(Score[i])
