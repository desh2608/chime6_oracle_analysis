#! /bin/bash

data_dir=$1
interval=$2

name=`basename $1`
mkdir -p exp/${name}_split${interval}
split_dir=exp/${name}_split${interval}

count=0
while true; do
  mkdir -p ${split_dir}/$count
  segments_found="false"
  start_time=$((count*interval))
  end_time=$(((count+1)*interval))
  for rttm in $data_dir/*; do
    file_name=`basename $rttm`
    awk -v a="$start_time" -v b="$end_time" '{
      if ($4 >= a && $4+$5 < b)
        print $0
    }' $rttm > ${split_dir}/$count/$file_name
    if [ -s ${split_dir}/$count/$file_name ]; then
      segments_found="true"
    fi
  done
  if [ $segments_found == "false" ]; then
    rm -r ${split_dir}/$count
    break
  fi
  echo "Done $((count*interval)) seconds.."
  count=$((count+1))
done
