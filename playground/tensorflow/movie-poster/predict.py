import tensorflow as tf
from tensorflow.python.framework.config import set_memory_growth


import keras
from keras.models import Sequential
from keras.models import load_model
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras.utils import to_categorical
# from keras.preprocessing import image
import keras.utils as image
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from tqdm import tqdm

import gc

train = pd.read_csv("train.csv")

model=load_model("model.h5")
def test(testing_photo):
  img = image.load_img(testing_photo,target_size=(400,400,3))
  img = image.img_to_array(img)
  img = img/255
  classes = np.array(train.columns[2:])
  proba = model.predict(img.reshape(1,400,400,3))
  top_3 = np.argsort(proba[0])[:-4:-1]
  res=[]
  for i in range(3):
      print("{}".format(classes[top_3[i]])+" ({:.3})".format(proba[0][top_3[i]]))
  return res

# res=test('sample1.jpg')
# res=test('sample2.jpg')
# res=test('sample3.jpg')
# res=test('sample4.jpg')
# res=test('sample5.jpg')
res=test('sample6.jpg')