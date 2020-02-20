#! /bin/bash

split_dir=$1

eval_speech=$(awk '{sum += $1} END {print sum}' $split_dir/stats)
scored_speech=$(awk '{sum += $2} END {print sum}' $split_dir/stats)
missed_speech=$(awk '{sum += $3} END {print sum}' $split_dir/stats)
falarm_speech=$(awk '{sum += $4} END {print sum}' $split_dir/stats)

missed_error=$(echo "$missed_speech*100/$scored_speech" | bc -l)
falarm_error=$(echo "$falarm_speech*100/$scored_speech" | bc -l)
total_error=$(echo "$missed_error+$falarm_error" | bc -l)

echo "EVAL SPEECH = " $eval_speech " seconds"
echo "SCORED TIME = " $scored_speech " seconds"
echo "MISSED SPEECH = " $missed_speech " seconds (" $missed_error "%)"
echo "FALARM SPEECH = " $falarm_speech " seconds (" $falarm_error "%)"
echo "TOTAL ERROR = " $total_error "%"

#rm -rf $split_dir/*/
