# Python module installation memo


## Install DLib

* Have to install MSVC first

```powershell
pip install cmake
pip install dlib
```


## Install TF

* https://www.tensorflow.org/tutorials/quickstart/beginner?hl=ko
* https://storage.googleapis.com/tensorflow_docs/docs-l10n/site/ko/tutorials/quickstart/beginner.ipynb

```powershell
# CUDA
# https://developer.nvidia.com/cuda-downloads?target_os=Windows&target_arch=x86_64&target_version=11
# https://developer.nvidia.com/rdp/cudnn-download
# set PATH env diy
# see also cuda_download.cmd
set PATH=%cd%\cuda\dll\bin;%cd%\cuda\dll\lib;%PATH%

# https://www.tensorflow.org/install/gpu?hl=ko
pip install tensorflow

# Run MNIST sample
cd playground/tensorflow
python ./hello-tf.py
```


## Install PyTorch

```powershell
# https://pytorch.org/get-started/locally/#start-locally
# cpu - pip3 install torch torchvision torchaudio
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116

# Run MNIST sample - https://wikidocs.net/60324
cd playground
pip install matplotlib
python ./hello-torch.py
```


## Install Transformer

```powershell
# https://github.com/huggingface/transformers
pip install transformers
```


## Run Code-Gen sample

* https://github.com/moyix/fauxpilot
* https://huggingface.co/models?search=salesforce+codegen

```powershell
# First, check PyTorch, Transformer are installed

cd playground
python ./hello-codegen.py
```


## Install Avalanche

```powershell
# https://avalanche.continualai.org/getting-started/how-to-install
pip install avalanche-lib
```


## Trouble shooting

* lib2to3 - https://stackoverflow.com/questions/42962765/embedded-python-3-5-python-setup-py-egg-info-failed-with-error-code-1
