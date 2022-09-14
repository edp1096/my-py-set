@echo off

@REM CUDA toolkit 11.6

@REM cudart64_110.dll,
@REM cublas64_11.dll, cublasLt64_11.dll,
@REM cufft64_10.dll,
@REM curand64_10.dll,
@REM cusolver64_11.dll,
@REM cusparse64_11.dll,
@REM cudnn64_8.dll


if not exist cuda (
    mkdir cuda
)
cd cuda

if not exist dll (
    mkdir dll
)
if not exist zip (
    mkdir zip
)


curl --progress-bar -Lo cudart.zip https://developer.download.nvidia.com/compute/cuda/redist/cuda_cudart/windows-x86_64/cuda_cudart-windows-x86_64-11.6.55-archive.zip
curl --progress-bar -Lo cublas.zip https://developer.download.nvidia.com/compute/cuda/redist/libcublas/windows-x86_64/libcublas-windows-x86_64-11.10.1.25-archive.zip
curl --progress-bar -Lo cufft.zip https://developer.download.nvidia.com/compute/cuda/redist/libcufft/windows-x86_64/libcufft-windows-x86_64-10.7.2.50-archive.zip
curl --progress-bar -Lo curand.zip https://developer.download.nvidia.com/compute/cuda/redist/libcurand/windows-x86_64/libcurand-windows-x86_64-10.2.10.91-archive.zip
curl --progress-bar -Lo cusolver.zip https://developer.download.nvidia.com/compute/cuda/redist/libcusolver/windows-x86_64/libcusolver-windows-x86_64-11.4.0.1-archive.zip
curl --progress-bar -Lo cusparse.zip https://developer.download.nvidia.com/compute/cuda/redist/libcusparse/windows-x86_64/libcusparse-windows-x86_64-11.7.3.50-archive.zip
curl --progress-bar -Lo cudnn.zip https://developer.download.nvidia.com/compute/redist/cudnn/v8.4.1/local_installers/11.6/cudnn-windows-x86_64-8.4.1.50_cuda11.6-archive.zip


FOR /F "delims=" %%a IN ('dir /b /a-d "*.zip"') DO (
    tar -xf %%a -C ./
    move /y %%a ./zip/
)

FOR /F "delims=" %%a IN ('dir /b /a:d "*cu*"') DO (
    xcopy /e/h/y/q .\%%a\* .\dll\*
    rmdir /s/q %%a
)

cd ..

echo Done
