import numpy as np
import torch
import random
from torch.utils.data import Dataset as TorchDataset

from deepproblog.dataset import Dataset
from deepproblog.query import Query
from torchvision.transforms import transforms
import pickle

from deepproblog.query import Query
from problog.logic import Term, Constant



def save_pickle(obj,filename):
    with open(filename+'.p', 'wb') as fp:
        pickle.dump(obj, fp, protocol=pickle.HIGHEST_PROTOCOL)
    return None

def load_pickle(file_to_load):
    with open(file_to_load, 'rb') as fp:
        labels = pickle.load(fp)
    return labels

def change_labels_dataset(label_path):
    label_dict=load_pickle(label_path)
    new_label_dict={}
    for label_key in label_dict:
        label = to_vector(label_dict[label_key])
        position = 1
        for pos_label in label:
            new_label_dict[f"{label_key}_{position}"] = pos_label
            position += 1
    return new_label_dict

def change_image_dataset(image_path):
    image_dict=load_pickle(image_path)
    new_image_dict={}
    for image_key in image_dict:
        for position in range(1, 82):
            position_list = []
            for _ in range(image_dict[image_key].shape[1]):
                position_list.append([position, position, position])
            position_list = np.array([position_list])
            new_image_dict[f"{image_key}_{position}"] = np.append(image_dict[image_key], position_list, 0)
    return new_image_dict

def change_image_dataset_2(image_path):
    image_dict=load_pickle(image_path)
    new_image_dict={}
    for image_key in image_dict:
        for position in range(1, 82):
            new_image_dict[f"{image_key}_{position}"] = np.array([position, image_dict[image_key]])
    return new_image_dict

def getDatasets(
        image_path, 
        label_path, 
        seed, 
        dataset_size = {"train": 25, "test": 75}):
    datasets = {"train": [], "test": []}
    image_dict=load_pickle(image_path)
    label_dict=load_pickle(label_path)
    if seed is not None:
            #label_dict = dict(sorted(label_dict.items(), key=lambda x: random.random()))
            rng = random.Random(seed)
            label_dict = list(label_dict.items())
            rng.shuffle(label_dict)
            label_dict = dict(label_dict)

    trainSize=dataset_size["train"]
    testSize=dataset_size["test"]
    i = 0
    for key in label_dict:
        if i<trainSize:
            datasets["train"].append(key)
        elif i<trainSize+testSize:
            datasets["test"].append(key)
        i += 1
    return datasets, image_dict, label_dict

class Sudoku_dataset(Dataset, TorchDataset): 
    def __init__(
            self, 
            datasets,
            image_dict,
            label_dict,
            dataset_name: str,
            function_name: str,
            transform=None,
        ):
        super(Sudoku_dataset, self).__init__()
        self.dataset_name = dataset_name
        self.transform = transform
        self.function_name = function_name
        self.image_dict = image_dict
        self.label_dict = label_dict
        self.data = datasets[dataset_name]
        self.idx_to_filename = {key:value for key,value in enumerate(self.data)}
         
    def __len__(self):
        return len(self.data)
 
    def __getitem__(self, idx):
        filename=self.idx_to_filename[idx]
        x=self.image_dict[filename]
        x=torch.from_numpy(x).permute(2,0,1).float()
        y=self.label_dict[filename]
        print(idx, filename)
        if self.transform:
            x = self.transform(x)
        #y = to_vector(y)
        return x,y

    
    def to_query(self, i: int) -> Query:
        """Generate queries"""
        filename = self.idx_to_filename[i]
        expected_result = self.label_dict[filename].tolist()


        # Build substitution dictionary for the arguments
        subs = dict()
        sudoku_img = Term("sudoku")
        subs[sudoku_img] = Term(
            "tensor",
            Term(
                self.dataset_name,
                Constant(filename),
            ),
        )

        # Build query
        return Query(
            Term(
                self.function_name,
                sudoku_img,
                Constant(expected_result),
            ),
            subs,
        )

def to_vector(y):
    ''' creates a vector for the labels. y_vector will be of shape (81)'''
    y_vector=torch.zeros((81))
    i = 0
    for row in y:
        for cell in row:
            y_vector[i] = cell
            i += 1
    return y_vector


# initialze the dataset
image_file='deepproblog/src/deepproblog/examples/Sudoku/data/image_dict_reg_100.p'
label_file='deepproblog/src/deepproblog/examples/Sudoku/data/label_dict_reg_100.p'

transform = transforms.Compose([
            transforms.ToPILImage(),
            transforms.Grayscale(),
            transforms.Resize((250,250)), #resize images
            transforms.ToTensor(),
            transforms.Normalize([.5],[.5])
            ])

datasets, image_dict, label_dict = getDatasets(image_file, label_file, None, {"train": 25, "test": 75})
