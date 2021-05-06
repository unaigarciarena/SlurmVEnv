#!/bin/bash
# Give your job a name, so you can recognize it in the queue overview
# Use at most 8 characters (only 8 are printed when the queue is shown)
#SBATCH --job-name=GridClone

# Use this parameter to define the output and error files
# For job arrays, the %A represents the job ID and %a the array index
# You can add this files to a directory, but it has to exist (it does not create it)
#SBATCH --output=ManualMTL_%A_%a.out                                                                                            
#SBATCH --error=ManualMTL_%A_%a.err

# Number of cores to be used. This option uses only one core                                                 
#SBATCH -n 1                                                                        
# This option would use one node with all its cores
# #SBATCH -N 1                          
#SBATCH --ntasks=1

# Remember to ask for enough memory for your process. The default is 2Gb
#SBATCH --mem-per-cpu=8000                                                                                       
# It is mandatory to indicate a maximum time for the process. 
# If you have no idea about how much time it will take, set it at a big value
#SBATCH --time=1000:00:00   
# So far there is only one queue, compute       
#SBATCH --partition=2018allq
# #SBATCH -w, --nodelist=nodo31
    
# Determine the number of repetitions of the process
#SBATCH --array=7-100

# Leave these options commented                                                      
# #SBATCH --cpus-per-task=1                                                                                                 
# #SBATCH --threads-per-core=2                                                                                              
# #SBATCH --ntasks-per-core=2        

#####################
# Here starts your code #
#####################

# Define and create a unique scratch directory for this job
SCRATCH_DIRECTORY=/var/tmp/${USER}/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
mkdir -p ${SCRATCH_DIRECTORY}/temps
mkdir -p ${SCRATCH_DIRECTORY}/mediumRes
mkdir -p ${SCRATCH_DIRECTORY}/mediumRes/weights
mkdir -p ${SCRATCH_DIRECTORY}/endRes
cd ${SCRATCH_DIRECTORY}

# You can copy everything you need to the scratch directory
# ${SLURM_SUBMIT_DIR} points to the path where this script was submitted from
cp ${SLURM_SUBMIT_DIR}/*.py ${SCRATCH_DIRECTORY}
cp ${SLURM_SUBMIT_DIR}/*.npy ${SCRATCH_DIRECTORY}
cp ${SLURM_SUBMIT_DIR}/mediumRes/model_$SLURM_ARRAY_TASK_ID.txt ${SCRATCH_DIRECTORY}/mediumRes
cp ${SLURM_SUBMIT_DIR}/mediumRes/weights/$SLURM_ARRAY_TASK_ID* ${SCRATCH_DIRECTORY}/mediumRes/weights
cp -r ${SLURM_SUBMIT_DIR}/Mobile-99-94 ${SCRATCH_DIRECTORY}/Mobile-99-94

# This is where the actual work is done. In this case, the script only waits.
# You can use $SLURM_ARRAY_TASK_ID to differentiate the files of each repetition

source /var/tmp/ugarciarena/venv/bin/activate
echo "python3 testClone.py -p $1 -s $SLURM_ARRAY_TASK_ID > ${SCRATCH_DIRECTORY}/Output_testClone.py_$1_$SLURM_ARRAY_TASK_ID"
      python3 testClone.py -p $1 -s $SLURM_ARRAY_TASK_ID > ${SCRATCH_DIRECTORY}/Output_testClone.py_$1_$SLURM_ARRAY_TASK_ID
deactivate
# After the job is done we copy our output back to $SLURM_SUBMIT_DIR
cp -r ${SCRATCH_DIRECTORY}/Output* ${SLURM_SUBMIT_DIR}/outputs
cp -r ${SCRATCH_DIRECTORY}/endRes/* ${SLURM_SUBMIT_DIR}/endRes

# After everything is saved to the home directory, delete the work directory 
cd ${SLURM_SUBMIT_DIR}
rm -rf ${SCRATCH_DIRECTORY}

