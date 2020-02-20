# CHiME-6 multi-array analysis

This is some shell code to do an analysis of multi-array
SAD and diarization in CHiME-6 data. The `data` directory
should contain a reference RTTM file with the name 
`ref_rttm` and hypothesis RTTMs generated using different
arrays with names `rttm.U01` and so on.

## How to run?

Go to `sad_oracle` or `diarize_oracle` and use: 
```
./run.sh <data-dir> <interval>
```
where `interval` is the interval size to consider for
segmenting the RTTM. For each segment, the best (oracle)
array is selected, and then best possible error rate 
is computed.
