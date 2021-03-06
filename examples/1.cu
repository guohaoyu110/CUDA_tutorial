'''
@File    :   1.cu
@Time    :   2021/04/22 18:03:05
@Author  :   Haoyu Guo 
@Version :   1.0
@Contact :   haoyuguo@usc.edu
'''
#include<stdio.h>
void CPUFunction(){
    printf("This function is defined to run on GPU.\n");
}

__global__ void GPUFunction(){
    printf("This function is defined to run on GPU.\n");
}

// __global__ void GPUFunction()

// The __global__ keyword indicates that the following function will run on the GPU, and can be invoked globally, 
// which in this context means either by the CPU, or, by the GPU.
// Often, code executed on the CPU is referred to as host code, and code running on the GPU is referred to as device code.
// Notice the return type void. It is required that functions defined with the __global__ keyword return type void.

int main (){
    CPUFunction();
    GPUFunction<<<1,1>>>();
    cudaDeviceSynchronize();
}
'''
GPUFunction<<<1, 1>>>();

Typically, when calling a function to run on the GPU, we call this function a kernel, which is launched.
When launching a kernel, we must provide an execution configuration, which is done by using the <<< ... >>> syntax just prior to passing the kernel any expected arguments.
At a high level, execution configuration allows programmers to specify the thread hierarchy for a kernel launch, which defines the number of thread groupings (called blocks), as well as how many threads to execute in each block. Execution configuration will be explored at great length later in the lab, but for the time being, notice the kernel is launching with 1 block of threads (the first execution configuration argument) which contains 1 thread (the second configuration argument).
cudaDeviceSynchronize();

Unlike much C/C++ code, launching kernels is asynchronous: the CPU code will continue to execute without waiting for the kernel launch to complete.
A call to cudaDeviceSynchronize, a function provided by the CUDA runtime, will cause the host (CPU) code to wait until the device (GPU) code completes, and only then resume execution on the CPU.
'''

