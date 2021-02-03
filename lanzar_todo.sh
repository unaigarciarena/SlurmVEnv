#!/bin/bash

## This script launches all the combinations of parameters for a job
## You can either set the possible values by hand or read them from the command line
## For the first case, comment the lines corresponding to the parsing of arguments
## For the second case, use the script (for example) as: 
##         bash slrum_launch.sh --samplers='runif rbeta' --sizes='50 100'

_NETSINS='i0 n0 n1 n2 n3 n4 n5'
_NETSOUTS='n0 n1 n2 n3 n4 n5 o0 o1 o2'
_NETS='n0 n1 n2 n3 n4 n5'
#################################
## Launch all the combinations          ##
#################################

# We can pass variables to the slurm script using the --export option
for n in $_NETS
do
	sbatch lanzarClones.sh test_operators.py $n
done

