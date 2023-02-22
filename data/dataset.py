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
        # sudoku_lbl = Term("label")
        subs[sudoku_img] = Term(
            "tensor",
            Term(
                self.dataset_name,
                Constant(filename),
            ),
        )
        # subs[sudoku_lbl] = Term(
        #     "tensor",
        #     Term(
        #         f"{self.dataset_name}_results",
        #         Constant(filename),
        #     ),
        # )

        # Build query
        return Query(
            Term(
                self.function_name,
                sudoku_img,
                Constant(int(filename.replace(".png", ""))),
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
image_file='data/image_dict2x3.p'
label_file='data/label_dict_2x3.p'

transform = transforms.Compose([
            transforms.ToPILImage(),
            transforms.Grayscale(),
            #transforms.Resize((32,32)), #2x2
            transforms.Resize((32,36)), #2x3
            #transforms.Resize((36,36)), #3x3
            transforms.ToTensor(),
            transforms.Normalize([.5],[.5])
            ])

datasets, image_dict, label_dict = getDatasets(image_file, label_file, 23, {"train": 17, "test": 75})


class SudokuTensorSource(object):
    def __init__(self, subset, dict, datasets, transform = None):
        self.dataset = {}
        self.transform = transform
        for key in datasets[subset]:
            self.dataset[key] = dict[key]

    def __getitem__(self, item):
        x = self.dataset[str(item[0])]
        x = torch.from_numpy(x).permute(2,0,1).float()
        if self.transform:
            x = self.transform(x)
        return x
