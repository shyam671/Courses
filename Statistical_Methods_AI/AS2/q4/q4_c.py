#!/usr/bin/env python

import numpy as np
import sys
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import ElasticNet
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
#Alpha = (100, 10, 1, 0.1,0.01,0.001,0.0001,0.00001)
Alpha = (1,1e-1,1e-2,1e-3,1e-4)
L1_ratio = (0.4,0.5,0.6)

reg = ElasticNet(alpha = 1e-3, l1_ratio=0.4, fit_intercept=True, normalize=False, precompute=False, max_iter=100000, copy_X=True, tol=1e-6)
reg.fit(trainData,trainLabels)

Score = reg.predict(testData)

Score[Score>0] = 1
Score[Score<=0] = 0
for i in range(len(Score)):
    print int(Score[i])
