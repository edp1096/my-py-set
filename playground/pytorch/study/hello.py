from tkinter.tix import Tree
import torch
from torch import nn
from torch.utils.data import DataLoader
from torchvision import datasets
from torchvision.transforms import ToTensor

# Training data
training_data = datasets.FashionMNIST(root="data", train=True, download=True, transform=ToTensor())

# Test data
test_data = datasets.FashionMNIST(root="data", train=True, download=True, transform=ToTensor())
