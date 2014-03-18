#!/usr/bin/env bash 

fp=condor-submit-jobs.txt
touch $fp 
seed=1
njobs=0
for nf in ` seq 100 250 3000`; do 
  for ns in 5 10 25 50; do
    for nb in `seq 25 25 1000`; do
      echo "executable = /usr/local/bin/matlab" >> $fp
      echo "arguments = -nodisplay -singleCompThread -nojvm -r condor_run_scale_bootstraps($seed,$nf,$nb,$ns)" >> $fp
      echo "error = crbs-nb$nb-nf$nf-ns$ns.txt"  >> $fp
      echo "Requirements = Memory > 1024"  >> $fp
      echo "queue"  >> $fp
      echo ""  >> $fp
      njobs=$(($njobs+1))
    done
  done
done

echo "There were $njobs jobs prepared"
