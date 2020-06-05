import cv2
import numpy as np 
import tensorflow as tf
from tensorflow.python.keras.models import Sequential
from tensorflow.python.keras.layers import *
from tensorflow.python.keras.optimizers import *

class GarbageDetector():

    def create_model(self):
        tf.compat.v1.disable_eager_execution()
        model=Sequential()
        model.add(InputLayer(input_shape=[64,64,1]))
        model.add(Conv2D(filters=8,kernel_size=5,strides=1,padding='same',activation='relu'))
        model.add(MaxPool2D(pool_size=5,padding='same'))         
        model.add(Conv2D(filters=16,kernel_size=5,strides=1,padding='same',activation='relu'))
        model.add(MaxPool2D(pool_size=5,padding='same'))         
        model.add(Conv2D(filters=32,kernel_size=5,strides=1,padding='same',activation='relu'))
        model.add(MaxPool2D(pool_size=5,padding='same'))          
        model.add(Dropout(0.25)) 
        model.add(Flatten())
        model.add(Dense(512,activation='relu'))
        model.add(Dropout(rate=0.5))
        model.add(Dense(2,activation='softmax')) 

        optimizer=Adam(lr=1e-3)

        model.compile(optimizer=optimizer,loss='binary_crossentropy',metrics=['accuracy'])
        return model

    def detect(self, path):
        model = self.create_model()
        model.load_weights('/home/aryan/Documents/newsih2020/sih2020/Backend/SihProject/proj/MLModel/Detector_class/garbage_model.h5')
        img = cv2.imread(path,cv2.IMREAD_GRAYSCALE)
        img = cv2.resize(img,(64,64))
        img = np.array(img).reshape(-1,64,64,1)
        out = model.predict([img])
        if np.argmax(out)==1:
            return 0
        else:
            return 1
