#!/usr/bin/bash

# clone and compile tiny-dnn for x86
git clone https://github.com/tiny-dnn/tiny-dnn.git
cd tiny-dnn
cmake . -DBUILD_EXAMPLES=ON
make

# get cifar10 (binary version) and untar into the tiny-dnn/data directory
cd data
wget https://www.cs.toronto.edu/~kriz/cifar-10-binary.tar.gz
tar -xvzf cifar-10-binary.tar.gz

# You can now reproduce the perf x86 results with

cd ../examples 

echo ----------------------------------------
echo perf MNIST results \(IPC \~ 0.87 expected\)
echo ----------------------------------------
perf stat ./example_mnist_train --data_path ../data --epochs 1

echo --------------------------------------
echo perf CIFAR results \(high IPC expected\)
echo --------------------------------------
perf stat ./example_cifar_train --data_path ../data/cifar-10-batches-bin
