#!/bin/bash -l
#$ -S /bin/bash
#$ -j y 
#$ -P rosenPrj
#$ -M gcd34@drexel.edu
#$ -t 1-10:1
#$ -q all.q

seed=1
n=1

for nf in $( seq 100 250 3000 ); do 
  for ns in 5 10 25 50; do
    for nb in $( seq 25 25 1000 ); do
      if [ "$SGE_TASK_ID" -eq "$n" ]; then
        nfeat=$nf
        nboot=$nb
        nsels=$ns 
      fi 
      n=$( expr $n + 1 )
    done
  done
done

export MATLABPATH=/home/gcd34/Git/npfs-bias-prj/src/
matlab -nodisplay -singleCompThread -nojvm -r "run_condor_scale_bootstraps($seed,$nfeat,$nboot,$nsels)"

