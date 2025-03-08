new-item -ea 0 -itemtype directory -path cuda\dll | out-null
new-item -ea 0 -itemtype directory -path cuda\zip | out-null

cd cuda

import-module bitstransfer

start-bitstransfer -destination cudart.zip https://developer.download.nvidia.com/compute/cuda/redist/cuda_cudart/windows-x86_64/cuda_cudart-windows-x86_64-12.6.77-archive.zip
start-bitstransfer -destination cublas.zip https://developer.download.nvidia.com/compute/cuda/redist/libcublas/windows-x86_64/libcublas-windows-x86_64-12.6.4.1-archive.zip
start-bitstransfer -destination cufft.zip https://developer.download.nvidia.com/compute/cuda/redist/libcufft/windows-x86_64/libcufft-windows-x86_64-11.3.0.4-archive.zip
start-bitstransfer -destination curand.zip https://developer.download.nvidia.com/compute/cuda/redist/libcurand/windows-x86_64/libcurand-windows-x86_64-10.3.7.77-archive.zip
start-bitstransfer -destination cusolver.zip https://developer.download.nvidia.com/compute/cuda/redist/libcusolver/windows-x86_64/libcusolver-windows-x86_64-11.7.1.2-archive.zip
start-bitstransfer -destination cusparse.zip https://developer.download.nvidia.com/compute/cuda/redist/libcusparse/windows-x86_64/libcusparse-windows-x86_64-12.5.4.2-archive.zip
start-bitstransfer -destination cudnn.zip https://developer.download.nvidia.com/compute/redist/cudnn/v8.7.0/local_installers/11.8/cudnn-windows-x86_64-8.7.0.84_cuda11-archive.zip
start-bitstransfer -destination nvcc.zip https://developer.download.nvidia.com/compute/cuda/redist/cuda_nvcc/windows-x86_64/cuda_nvcc-windows-x86_64-12.6.85-archive.zip


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
