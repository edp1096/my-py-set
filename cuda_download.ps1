new-item -ea 0 -itemtype directory -path cuda\dll | out-null
new-item -ea 0 -itemtype directory -path cuda\zip | out-null

cd cuda

import-module bitstransfer

start-bitstransfer -destination cudart.zip https://developer.download.nvidia.com/compute/cuda/redist/cuda_cudart/windows-x86_64/cuda_cudart-windows-x86_64-11.6.55-archive.zip
start-bitstransfer -destination cublas.zip https://developer.download.nvidia.com/compute/cuda/redist/libcublas/windows-x86_64/libcublas-windows-x86_64-11.10.1.25-archive.zip
start-bitstransfer -destination cufft.zip https://developer.download.nvidia.com/compute/cuda/redist/libcufft/windows-x86_64/libcufft-windows-x86_64-10.7.2.50-archive.zip
start-bitstransfer -destination curand.zip https://developer.download.nvidia.com/compute/cuda/redist/libcurand/windows-x86_64/libcurand-windows-x86_64-10.2.10.91-archive.zip
start-bitstransfer -destination cusolver.zip https://developer.download.nvidia.com/compute/cuda/redist/libcusolver/windows-x86_64/libcusolver-windows-x86_64-11.4.0.1-archive.zip
start-bitstransfer -destination cusparse.zip https://developer.download.nvidia.com/compute/cuda/redist/libcusparse/windows-x86_64/libcusparse-windows-x86_64-11.7.3.50-archive.zip
start-bitstransfer -destination cudnn.zip https://developer.download.nvidia.com/compute/redist/cudnn/v8.4.1/local_installers/11.6/cudnn-windows-x86_64-8.4.1.50_cuda11.6-archive.zip
start-bitstransfer -destination nvcc.zip https://developer.download.nvidia.com/compute/cuda/redist/cuda_nvcc/windows-x86_64/cuda_nvcc-windows-x86_64-11.7.99-archive.zip


$files = Get-ChildItem -Path "./" -Filter "*.zip"

foreach ($f in $files) {
    move-item -Path $f ./zip
    tar -xf ./zip/$f
}

$folders = Get-ChildItem -Directory "*cu*"
foreach ($folder in $folders) {
    copy-item -r -force -path $folder\* -destination .\dll\
    remove-item -r -force -path $folder
}

cd ..

echo "Done"
