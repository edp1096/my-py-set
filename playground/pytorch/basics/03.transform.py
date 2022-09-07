# https://pytorch.org/tutorials/beginner/basics/transforms_tutorial.html

import torch
from torchvision import datasets
from torchvision.transforms import ToTensor, Lambda
from torch.utils.data import DataLoader

ds = datasets.FashionMNIST(
    root="data",
    train=True,
    download=True,

    # ToTensor()
    transform=ToTensor(),

    # Lambda Transforms
    target_transform=Lambda(lambda y: torch.zeros(
        10, dtype=torch.float).scatter_(0, torch.tensor(y), value=1))
)

loader = DataLoader(ds, batch_size=64, shuffle=True)
