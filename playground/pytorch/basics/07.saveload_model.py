# https://pytorch.org/tutorials/beginner/basics/saveloadrun_tutorial.html

import torch
import torchvision.models as models


""" 모델 가중치 저장 및 불러오기 """
model = models.vgg16(pretrained=True)
torch.save(model.state_dict(), 'model_weights.pth')

model = models.vgg16() # we do not specify pretrained=True, i.e. do not load default weights
model.load_state_dict(torch.load('model_weights.pth'))
model.eval()


""" 구조를 포함한 모델 저장 및 불러오기 """
torch.save(model, 'model.pth')
model = torch.load('model.pth')