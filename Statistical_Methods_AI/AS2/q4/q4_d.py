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

reg = linear_model.LinearRegression()
reg.fit(trainData,trainLabels)

Score = reg.predict(testData)
Score[Score>0] = 1
Score[Score<=0] = 0
for i in range(len(Score)):
    print int(Score[i])
