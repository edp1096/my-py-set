# http://dlib.net/svm_binary_classifier.py.html

import dlib

print(dlib.__version__)

try:
    import cPickle as pickle
except ImportError:
    import pickle

x = dlib.vectors()
y = dlib.array()


""" Make a training dataset """
x.append(dlib.vector([1, 2, 3, -1, -2, -3]))
y.append(+1)

x.append(dlib.vector([-1, -2, -3, 1, 2, 3]))
y.append(-1)


""" Now make a training object """
svm = dlib.svm_c_trainer_linear()
svm.be_verbose()
svm.set_c(10)


""" Now train the model """
classifier = svm.train(x, y)


""" Now run the model on our data and look at the results """
print("prediction for first sample:  {}".format(classifier(x[0])))
print("prediction for second sample: {}".format(classifier(x[1])))


""" classifier models can also be pickled in the same was as any other python object """
with open('saved_model.pickle', 'wb') as handle:
    pickle.dump(classifier, handle, 2)