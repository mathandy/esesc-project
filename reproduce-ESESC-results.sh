#!/usr/bin/bash

# clone and compile tiny-dnn for RISC-V (first go to some new directory)
mv tiny-dnn tiny-dnn-x86
git clone https://github.com/tiny-dnn/tiny-dnn.git
cd tiny-dnn
export CC=riscv64-linux-gnu-g++; export CXX=riscv64-linux-gnu-g++   # probably unnecessary, but I did it
cmake . -DBUILD_EXAMPLES=ON -DUSE_AVX=OFF -DUSE_SSE=OFF -DEXTRA_C_FLAGS=-static -DEXTRA_CXX_FLAGS=-static -DCMAKE_C_COMPILER=riscv64-linux-gnu-gcc -DCMAKE_CXX_COMPILER=riscv64-linux-gnu-g++
make -j7 CC=riscv64-unknown-linux-gnu-g++
echo note: compilation is expected to fail at end but that is ok ... just fails on one of the unused examples

# get cifar10 (binary version) and untar into the tiny-dnn/data directory
cd data
wget https://www.cs.toronto.edu/~kriz/cifar-10-binary.tar.gz
tar -xvzf cifar-10-binary.tar.gz

# setup this repo
cd ../..
mkdir results
echo ""
echo ""
echo ""
echo ""
echo Note if you do not have ~/projs/esesc/conf, ~/build/release and ~/benchmarks directories set up as in the ESESC Lab, you must update conf_dir, benchmarks_dir and esesc_dir in run_tinydnn.sh
echo ""
echo ""
echo ""
echo ""
./esesc-project.sh
