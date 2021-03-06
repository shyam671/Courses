import numpy as np
#import keras
from keras import backend as K
K.set_image_dim_ordering('th')
import numpy as np
import sys
import os
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from keras.preprocessing.image import ImageDataGenerator
from sklearn.preprocessing import OneHotEncoder
from keras.datasets import cifar10
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Dropout
from keras.layers import Flatten
from keras.constraints import maxnorm
from keras.optimizers import SGD
from keras.layers.convolutional import Conv2D
from keras.layers.convolutional import MaxPooling2D
from keras.layers.convolutional import MaxPooling3D
from keras.utils import np_utils
from keras.optimizers import Adam
from keras.layers.normalization import BatchNormalization
from keras.layers.advanced_activations import LeakyReLU, PReLU
from keras.utils import plot_model
from keras.models import model_from_json

def unpickle(file):
    import cPickle
    with open(file, 'rb') as fo:
        dict = cPickle.load(fo)
    return dict

if "__name__" != "__main__":
 
 num_classes = 10
 lr = 0.003
 epochs = 9
 #Reading Arguments
 traindir = sys.argv[1]
 test = sys.argv[2]

 listing = os.listdir(traindir)
 #Loading training data
 train_data = np.zeros((10000*len(listing),3072))
 train_labels = np.zeros((10000*len(listing)))
 for i,filename in enumerate(listing):
    if filename == 'batches.meta':
       Class_names = unpickle(traindir+filename)
       continue
    a = unpickle(traindir+filename)
    data = a['data']
    labels = a['labels']
    train_data[i*10000:(i+1)*10000,:] = data
    train_labels[i*10000:(i+1)*10000] = labels
 # Data preprocessing   
 train_data = StandardScaler().fit_transform(train_data)    
 train_data = train_data.reshape(train_data.shape[0], 3, 32, 32)
 #One hot encoding of train labels
 onehot_encoder = OneHotEncoder(sparse=False)
 train_labels_C = train_labels
 train_labels = train_labels.reshape(len(train_labels), 1)
 train_labels = onehot_encoder.fit_transform(train_labels)
 # Create the model
 model = Sequential()
 model.add(Conv2D(32, (3, 3), activation='linear', padding='same',input_shape=train_data.shape[1:]))
 model.add(PReLU()) 
 model.add(MaxPooling2D(pool_size=(2, 2)))
 model.add(BatchNormalization()) 
 model.add(Conv2D(48,(3, 3), activation='linear', padding='same'))
 model.add(PReLU()) 
 model.add(MaxPooling2D(pool_size=(2, 2)))
 model.add(BatchNormalization())         
 model.add(Conv2D(64, (3, 3), activation='linear', padding='same'))
 model.add(PReLU()) 
 model.add(Dropout(0.1))
 model.add(Flatten()) 
 model.add(BatchNormalization())          
 model.add(Dense(1024, activation='linear', kernel_constraint=maxnorm(3)))
 model.add(PReLU()) 
 model.add(Dropout(0.2))
 model.add(Dense(84, activation='linear', kernel_constraint=maxnorm(3)))
 model.add(PReLU()) 
 model.add(Dense(num_classes, activation='softmax'))
 model.compile(loss='categorical_crossentropy',optimizer=Adam(lr=lr, decay = lr*0.9),metrics=['accuracy'])
 #Training the Model
 datagen = ImageDataGenerator(zoom_range=0.2,horizontal_flip=True)
 model.fit_generator(datagen.flow(train_data, train_labels, batch_size=128),steps_per_epoch=len(train_data) /128, epochs=epochs,verbose =0)
 #Testing the Model
 #Reading test data
 test_file = unpickle(test)
 test_data = test_file["data"]
 test_data = StandardScaler().fit_transform(test_data.astype(float))
 test_data = test_data.reshape(test_data.shape[0], 3, 32, 32)
 Prediction =  np.argmax(model.predict(test_data), axis = 1)
 thefile = open('q2_b_output.txt', 'w')
 for i in range(len(test_data)):
     thefile.write("%s\n" % Class_names['label_names'][Prediction[i]]) 
 











