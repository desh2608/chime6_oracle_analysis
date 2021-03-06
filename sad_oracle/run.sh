#! /bin/bash

data_dir=$1
interval=$2

name=`basename $data_dir`
split_dir=exp/${name}_split${interval}

echo "$0: Creating splits of interval $interval seconds"
local/create_split_dirs.sh $data_dir $interval

echo "$0: Getting best array for each interval"
local/compute_stats.sh $split_dir

echo "$0: Computing oracle error rate"
local/compute_oracle_error.sh $split_dir

#rm -rf $split_dir/*/


