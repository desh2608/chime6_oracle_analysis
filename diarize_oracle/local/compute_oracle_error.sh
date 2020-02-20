#! /bin/bash

split_dir=$1

sess1=$( head -1 $split_dir/stats | cut -d' ' -f1 )
sess2=$( head -1 $split_dir/stats | cut -d' ' -f4 )
cat $split_dir/stats | awk -v a=$sess1 -v b=$sess2 '{
  der1+=$2; 
  jer1+=$3; 
  der2+=$5; 
  jer2+=$6; 
} END {
  print a, der1/NR, jer1/NR;
  print b, der2/NR, jer2/NR;
}'
#rm -rf $split_dir/*/
