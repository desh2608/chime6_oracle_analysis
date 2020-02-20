#! /bin/bash

function join_by { local IFS="$1"; shift; echo "$*"; }

data_dir=$1

> $data_dir/stats
for d in $data_dir/*/ ; do
  > $d/tmp_stats
  for f in $d/rttm.U0*; do
    sed 's/_U0[1-6]//g' $d/ref_rttm > $d/ref_rttm.scoring
    sed 's/_U0[1-6]//g' $f > $d/tmp
    stats_str=$(cd dscore && python score.py -r ../$d/ref_rttm.scoring -s ../$d/tmp && cd .. |\
      grep -v "WARNING")
    echo $stats_str >> $d/tmp_stats
  done
  best_stats1=$( cut -d' ' -f1-3 $d/tmp_stats | awk '{print $2+$3, $0}' | sort -n | head -1 | cut -d' ' -f2- )
  best_stats2=$( cut -d' ' -f4-6 $d/tmp_stats | awk '{print $2+$3, $0}' | sort -n | head -1 | cut -d' ' -f2- )
  echo $best_stats1 $best_stats2 >> $data_dir/stats
  echo "Done $d.."
done
