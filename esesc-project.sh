#!/bin/bash

results_dir=results
esesc_config_dir=base_configs

cpu=boom2
benchmark=tinydnn

parameter=memLatency
line_number=2
for value in {60,15}; do
	name=${benchmark}_${parameter}_$value

	# change a parameter
	simulation_config=$esesc_config_dir/${name}_simu.conf.$cpu
	python change_line_value.py $esesc_config_dir/simu.conf.$cpu $simulation_config $value -l $line_number -n $parameter

	# run simulation
	esesc_config=$esesc_config_dir/esesc.conf
	log=$results_dir/${name}_results.txt
	echo ./run_tinydnn.sh $benchmark $esesc_config $simulation_config $name $log
	./run_tinydnn.sh $benchmark $esesc_config $simulation_config $name $log
done

# issueWidth experiment

# parameter=assoc
# line_number=315
# for value in {0,1,2,8,16}; do
# 	name=${benchmark}_${parameter}_$value

# 	# change a parameter
# 	simulation_config=$esesc_config_dir/${name}_simu.conf.$cpu
# 	python change_line_value.py $esesc_config_dir/simu.conf.$cpu $simulation_config $value -l $line_number -n $parameter

# 	# run simulation
# 	esesc_config=$esesc_config_dir/esesc.conf
# 	log=$results_dir/${name}_results.txt
# 	echo ./run_tinydnn.sh $benchmark $esesc_config $simulation_config $name $log
# 	./run_tinydnn.sh $benchmark $esesc_config $simulation_config $name $log
# done


# parameter=issueWidth
# line_number=2
# for value in {1,}; do
# 	name=${benchmark}_${parameter}_$value

# 	# change a parameter
# 	simulation_config=$esesc_config_dir/${name}_simu.conf.$cpu
# 	python change_line_value.py $esesc_config_dir/simu.conf.$cpu $simulation_config $value -l $line_number -n $parameter

# 	# run simulation
# 	esesc_config=$esesc_config_dir/esesc.conf
# 	log=$results_dir/${name}_results.txt
# 	echo ./run_tinydnn.sh $benchmark $esesc_config $simulation_config $name $log
# 	./run_tinydnn.sh $benchmark $esesc_config $simulation_config $name $log
# done


# parameter=nRegs
# line_number=2
# for value in {2048, 512}; do
# 	name=${benchmark}_${parameter}_$value

# 	# change a parameter
# 	simulation_config=$esesc_config_dir/${name}_simu.conf.$cpu
# 	python change_line_value.py $esesc_config_dir/simu.conf.$cpu $simulation_config $value -l $line_number -n $parameter

# 	# run simulation
# 	esesc_config=$esesc_config_dir/esesc.conf
# 	log=$results_dir/${name}_results.txt
# 	echo ./run_tinydnn.sh $benchmark $esesc_config $simulation_config $name $log
# 	./run_tinydnn.sh $benchmark $esesc_config $simulation_config $name $log
# done
