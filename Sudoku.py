from json import dumps

import torch

from deepproblog.dataset import DataLoader
from deepproblog.engines import ApproximateEngine, ExactEngine
from deepproblog.evaluate import get_confusion_matrix
from data.dataset import Sudoku_dataset, SudokuTensorSource, getDatasets, getTransform
from deepproblog.examples.MNIST.network import MNIST_Net
from deepproblog.model import Model
from sudoku_network import Sudoku_Net
from deepproblog.network import Network
from deepproblog.train import train_model
import sys

try:
    sudoku_format = int(sys.argv[1])
except:
    sudoku_format = "2x3"

model_pl = f"sudoku_model_{sudoku_format}.pl"
num_cells = {"2x2": 4, "2x3": 6, "3x3": 9}
num_symbols = {"2x2": 3, "2x3": 4, "3x3": 4}
transform = getTransform(sudoku_format)
image_file=f'data/image_dict{sudoku_format}.p'
label_file=f'data/label_dict_{sudoku_format}.p'
samples_num = [15,17,19,21,23,25]

queries = ["both", "empty", "compl"]
num_epochs = {"both":80, "empty":80, "compl":5}

for sample_num in samples_num:
    datasets, image_dict, label_dict = getDatasets(image_file, label_file, 23, {"train": sample_num, "test": 75})
    train_images = SudokuTensorSource("train", image_dict, datasets, transform)
    test_images = SudokuTensorSource("test", image_dict, datasets, transform)
    train_labels = SudokuTensorSource("train", label_dict, datasets, transform)
    test_labels = SudokuTensorSource("test", label_dict, datasets, transform)
    for query in queries:
        fun_to_query = f"solve{sudoku_format}_{query}"
        train_set = Sudoku_dataset(datasets, image_dict, label_dict, "train", fun_to_query, transform)
        test_set = Sudoku_dataset(datasets, image_dict, label_dict, "test", fun_to_query, transform)
        for i in range(5):
            network = Sudoku_Net(num_cells[sudoku_format], num_symbols[sudoku_format])
            net = Network(network, "sudoku_net", batching=False)
            net.optimizer = torch.optim.Adam(network.parameters(), lr=1e-3)
            model = Model(model_pl, [net])
            model.set_engine(ExactEngine(model), cache=True)
            model.add_tensor_source("train", train_images) #la substitution della query dipende dal contenuto di questi tensor source
            model.add_tensor_source("test", test_images)
            loader = DataLoader(train_set, 1, False)
            print(f"------ Try {i} for query {query} for {sample_num} samples for {sudoku_format} sudoku format ------")

            name = f"sudoku_{query}_{sample_num}_{sudoku_format}_{i}"

            train = train_model(model, loader, num_epochs[query], log_iter=1, profile=0)
            model.save_state("snapshot/" + name + ".pth")
            train.logger.comment(dumps(model.get_hyperparameters()))
            train.logger.comment(
                "Accuracy {}".format(get_confusion_matrix(model, test_set, verbose=0).accuracy())
            )
            train.logger.write_to_file("log/" + name)
