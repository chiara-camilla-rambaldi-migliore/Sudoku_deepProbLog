import sys
import os
import pickle
from PIL import Image
import numpy as np


def load_pickle(file_to_load):
    with open(file_to_load, 'rb') as fp:
        labels = pickle.load(fp)
    return labels

def save_images_from_pickle(image_file, num_training_files):
    parent_path = os.path.dirname(os.path.abspath(__file__))
    os.mkdir(os.path.join(parent_path, "images", "train"))
    os.mkdir(os.path.join(parent_path, "images", "test"))

    images = load_pickle(image_file)
    for key in images:
        if num_training_files > 0:
            num_training_files -= 1
            folder = "train"
        else:
            folder = "test"
        im = Image.fromarray(images[key])
        im.save(f"images/{folder}/{key}")

def to_vector(y):
    ''' creates a vector for the labels. y_vector will be of shape (81)'''
    y_vector = []
    for row in y:
        for cell in row:
            y_vector.append(cell)
    return y_vector

def save_labels_from_pickle(label_file, num_training_files):
    parent_path = os.path.dirname(os.path.abspath(__file__))
    if not(os.path.exists(os.path.join(parent_path, "labels"))):
        os.mkdir(os.path.join(parent_path, "labels"))

    labels = load_pickle(label_file)
    vector_labels_train = []
    vector_labels_test = []
    for key in labels:
        if num_training_files > 0:
            num_training_files -= 1
            vector_labels_train.append(to_vector(labels[key]))
        else:
            vector_labels_test.append(to_vector(labels[key]))
        
        np.savetxt('labels/train.csv', vector_labels_train, delimiter = ',', fmt='%d')
        np.savetxt('labels/test.csv', vector_labels_test, delimiter = ',', fmt='%d')

try:
    numOfData = int(sys.argv[1])
except:
    numOfData = 25

save_images_from_pickle('image_dict_reg_100.p', numOfData)
save_labels_from_pickle('label_dict_reg_100.p', numOfData)