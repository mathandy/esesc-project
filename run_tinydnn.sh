#!/bin/bash
# USAGE: ./run_benchmark.sh <benchmark_name> <esesc_config_file> <simulation_config_file> <run_name> <log_path>
#	e.g. ./run_benchmark.sh spec06_hmmer ~/Dropbox/esesc-lab/esesc.conf ~/Dropbox/esesc-lab/simu.conf testeroo ~/Dropbox/esesc-lab/test_results.txt

# esesc parameters
esesc_dir=~/build/release
benchmarks_dir=~/benchmarks
conf_dir=~/projs/esesc/conf
data_path=tiny-dnn/data/cifar-10-batches-bin
binary_dir=tiny-dnn/examples
cpu=boom2

# parse CLI arguments
BENCHMARK=$1
ESESC_CONFIG=$2
SIMULATION_CONFIG=$3
RUN_NAME=$4
LOG=$5

# report CLI arguments
echo
echo ---
echo Running experiment \"$RUN_NAME\" with benchmark \"$BENCHMARK\" ...
echo

# setup directory for experiment
run_dir=$esesc_dir/$RUN_NAME
mkdir $run_dir
cp -r config $run_dir/base_configs
cd $run_dir

cp -r $conf_dir/* .
cp -r $benchmarks_dir/* .

# switch to config file using TASS (and higher instruction count)
rm -f esesc.conf
cp $ESESC_CONFIG esesc.conf
cp $SIMULATION_CONFIG simu.conf.$cpu

# run experiment/benchmark
cp -r $binary_dir/* .
ESESC_benchname="./example_cifar_train --data_path $data_path" ../main/esesc | tee last-run-log.txt

# record results
./scripts/report.pl -last | tee $LOG
echo $PWD
echo $LOG
