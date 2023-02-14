from json import dumps

import torch

from deepproblog.dataset import DataLoader
from deepproblog.engines import ApproximateEngine, ExactEngine
from deepproblog.evaluate import get_confusion_matrix
from data.dataset import Sudoku_dataset, SudokuTensorSource, image_dict, label_dict, datasets, transform
from deepproblog.examples.MNIST.network import MNIST_Net
from deepproblog.model import Model
from sudoku_network import Sudoku_Net
from deepproblog.network import Network
from deepproblog.train import train_model

train_images = SudokuTensorSource("train", image_dict, datasets, transform)
test_images = SudokuTensorSource("test", image_dict, datasets, transform)
train_labels = SudokuTensorSource("train", label_dict, datasets, transform)
test_labels = SudokuTensorSource("test", label_dict, datasets, transform)

name = "sudoku"

train_set = Sudoku_dataset(datasets, image_dict, label_dict, "train", "solve_test", transform)
test_set = Sudoku_dataset(datasets, image_dict, label_dict, "test", "solve_test", transform)

network = Sudoku_Net()

net = Network(network, "sudoku_net", batching=False)
net.optimizer = torch.optim.Adam(network.parameters(), lr=1e-3)

model = Model("sudoku_model.pl", [net])

model.set_engine(ExactEngine(model), cache=False)

model.add_tensor_source("train", train_images) #la substitution della query dipende dal contenuto di questi tensor source
model.add_tensor_source("test", test_images)
model.add_tensor_source("train_results", train_labels)
model.add_tensor_source("test_results", test_labels)

loader = DataLoader(train_set, 1, False)
train = train_model(model, loader, 1, log_iter=100, profile=0)
model.save_state("snapshot/" + name + ".pth")
train.logger.comment(dumps(model.get_hyperparameters()))
train.logger.comment(
    "Accuracy {}".format(get_confusion_matrix(model, test_set, verbose=1).accuracy())
)
train.logger.write_to_file("log/" + name)
