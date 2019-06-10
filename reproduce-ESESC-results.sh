#!/usr/bin/bash

# clone and compile tiny-dnn for RISC-V (first go to some new directory)
mv tiny-dnn tiny-dnn-x86
git clone https://github.com/tiny-dnn/tiny-dnn.git
cd tiny-dnn
export CC=riscv64-linux-gnu-g++; export CXX=riscv64-linux-gnu-g++   # probably unnecessary, but I did it
cmake . -DBUILD_EXAMPLES=ON -DUSE_AVX=OFF -DUSE_SSE=OFF -DEXTRA_C_FLAGS=-static -DEXTRA_CXX_FLAGS=-static -DCMAKE_C_COMPILER=riscv64-linux-gnu-gcc -DCMAKE_CXX_COMPILER=riscv64-linux-gnu-g++
make CC=riscv64-unknown-linux-gnu-g++
echo note: compilation is expected to fail at end but that is ok ... just fails on one of the unused examples

# setup this repo
cd ..
mkdir results
echo ""
echo ""
echo ""
echo ""
echo Note if you do not have ~/build/release and ~/benchmarks directories set up as in the ESESC Lab, you must update benchmarks_dir and esesc_dir in run_tinydnn.sh
echo ""
echo ""
echo ""
echo ""
./esesc-project.sh
