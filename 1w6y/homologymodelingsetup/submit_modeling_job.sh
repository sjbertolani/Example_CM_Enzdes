#!/bin/bash
#SBATCH --job-name=homologymodel.log
#SBATCH --output=homologymodl.log
#SBATCH --mem 4G
#SBATCH --nodes 1
#SBATCH --time 1-0

$ROSETTA_BIN/rosetta_scripts.default.linuxgccrelease -database $ROSETTA_DB @flags 
