#! /bin/bash

function join_by { local IFS="$1"; shift; echo "$*"; }

data_dir=$1

> $data_dir/stats
for d in $data_dir/*/ ; do
  declare -a best_stats
  for f in $d/rttm.U0*; do
    sed 's/_U0[1-6]//g' $d/ref_rttm > $d/ref_rttm.scoring
    sed 's/_U0[1-6]//g' $f > $d/tmp
    stats_str=$(./md-eval.pl -1 -c 0.25 -r $d/ref_rttm.scoring -s $d/tmp |\
      grep -e "EVAL SPEECH" -e "SCORED TIME" -e "MISSED SPEECH" -e "FALARM SPEECH" |\
      awk 'BEGIN{ORS=","}{print $4}')
    IFS=',' read -r -a cur_stats <<< $stats_str
    cur_error=$( echo "${cur_stats[*]}" | tr ' ' + | bc -l )
    best_error=$( echo "${best_stats[*]}" | tr ' ' + | bc -l )
    if [ ${#best_stats[@]} -eq 0 ] || (( $(echo "$cur_error < $best_error" | bc -l) )); then
      best_stats=$cur_stats
    fi
  done
  echo "${best_stats[*]}" >> $data_dir/stats
  echo "Done $d.."
  unset best_stats
done
