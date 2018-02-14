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
Alpha = (1,0.1,0.01,0.001,0.0001,0.00001)
#Tol = (0.1,0.01,0.001,0.0001,0.00001,1e-5,1e-6,1e-7)
#Max_iter = (10,100,1000,10000,1e+5,1e+6,1e+7)
#Solver = ('auto', 'svd', 'cholesky', 'lsqr','sparse_cg', 'sag', 'saga')
#for i, C in enumerate(Alpha):
     # reg = linear_model.Ridge(alpha=Alpha, fit_intercept=True, normalize=False, copy_X=True, max_iter=None, tol=0.001, solver='auto', random_state=None)
reg = linear_model.Ridge(alpha=1e-4, copy_X=True, fit_intercept=True, max_iter=1000,normalize=False, solver='auto', tol=0.001)
reg.fit(trainData,trainLabels)

Score = reg.predict(testData)
Score[Score>0] = 1
Score[Score<=0] = 0
for i in range(len(Score)):
    print int(Score[i])
