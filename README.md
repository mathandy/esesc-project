# Andy Port's 202 ESESC Project Repo

## Short Steps to Reproduce

1. [install protobuf](https://github.com/protocolbuffers/protobuf/blob/master/src/README.md)

2. install dependencies mentioned in tiny-dnn dockerfile
note: this step may be unnecessary, but if you’re missing libraries, take a look.

3. clone this repo and run reproduce results
    
    $ git clone https://github.com/mathandy/esesc-project.git
    $ cd esesc-project
    $ ./reproduce-x86-results.sh
    $ ./reproduce-ESESC-results.sh

**Note:** If your ESESC paths differe from those used in the ESESC lab, you'll need to edit esesc-project.sh to specify the correct paths for the following two directories: 

    * esesc_dir (defaults to ~/build/release)
    * benchmarks_dir (defaults to ~/benchmarks)


## Long steps to Reproduce (just in case the above doesn't work)
1. [install protobuf](https://github.com/protocolbuffers/protobuf/blob/master/src/README.md)

2. install dependencies mentioned in tiny-dnn dockerfile
note: this step may be unnecessary, but if you’re missing libraries, take a look.

3. clone and compile tiny-dnn for x86
    $ git clone https://github.com/tiny-dnn/tiny-dnn.git
    $ cd tiny-dnn
    $ export CC=riscv64-linux-gnu-g++; export CXX=riscv64-linux-gnu-g++   # probably unnecessary, but I did it
    $ cmake . -DBUILD_EXAMPLES=ON
    $ make

4. get cifar10 (binary version) and untar into the tiny-dnn/data directory
    $ cd data
    $ wget https://www.cs.toronto.edu/~kriz/cifar-10-binary.tar.gz
    $ tar -xvzf cifar-10-binary.tar.gz

**You can now run the example with**

    $ cd ../examples 
    $ perf stat ./example_mnist_train --data_path /home/andy/Downloads/tiny-dnn/data --epochs 1  # MNIST example
    $ perf stat ./example_cifar_train --data_path /home/andy/Downloads/tiny-dnn/data/cifar-10-batches-bin  # CIFAR example

5. clone and compile tiny-dnn for RISC-V (first go to some new directory)
    $ git clone https://github.com/tiny-dnn/tiny-dnn.git
    $ cd tiny-dnn
    $ export CC=riscv64-linux-gnu-g++; export CXX=riscv64-linux-gnu-g++   # probably unnecessary, but I did it
    $ cmake . -DBUILD_EXAMPLES=ON -DUSE_AVX=OFF -DUSE_SSE=OFF -DEXTRA_C_FLAGS=-static -DEXTRA_CXX_FLAGS=-static -DCMAKE_C_COMPILER=riscv64-linux-gnu-gcc -DCMAKE_CXX_COMPILER=riscv64-linux-gnu-g++
    $ make CC=riscv64-unknown-linux-gnu-g++
    note: compilation will fail at end but that's ok ... just fails on one of the unused examples

7. Clone and setup this repo
    $ git clone https://github.com/mathandy/esesc-project.git

    * in esesc-project.sh set results_dir and esesc_config_dir to match your setup
        * results_dir=~/Dropbox/esesc-lab/results  # where the results go
        * esesc_config_dir=~/Dropbox/esesc-lab/config  # where to find default config files
        Note: esesc.conf should be setup as described in the esesc lab.
        
    * and in run_tinydnn.sh set
        * esesc_dir=~/build/release  # as in the esesc-lab
        * benchmarks_dir=~/benchmarks  # as in the esesc-lab
        * data_path=$HOME/Downloads/tiny-dnn/data/cifar-10-batches-bin  # where you untarred cifar data to 
        * binary_dir=$HOME/Downloads/tiny-dnn/examples  # the examples directory of tiny-dnn

8. you're good to go, just
    $ ./esesc-project.sh
