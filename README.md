# Sudoku Deep ProbLog
## Deep ProbLog sudoku solver

### Requirements
0. We assume Anaconda is installed. One can install it according to its [installation page](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html).
1. Clone this repo:
```
git clone https://github.com/chiara-camilla-rambaldi-migliore/Sudoku_deepProbLog.git
cd Sudoku_deepProbLog
```
2. Create a virtual environment `sudoku_dpl`. 
```
conda create --name sudoku_dpl
conda activate sudoku_dpl
pip install deepproblog
```

## Test deep problog
```
pip install pytest
python -m deepproblog test
```

## Run
```
python3 Sudoku.py
```