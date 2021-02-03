#!/bin/bash
# Give your job a name, so you can recognize it in the queue overview
# Use at most 8 characters (only 8 are printed when the queue is shown)
#SBATCH --job-name=ClrCrew
#SBATCH --output=%N.out                                                                                            
#SBATCH --error=%N.out
# Number of cores to be used. This option uses only one core                                                 
#SBATCH -n 1                                                                        
# This option would use one node with all its cores
# #SBATCH -N 1                          
#SBATCH --ntasks=1

# Remember to ask for enough memory for your process. The default is 2Gb
#SBATCH --mem-per-cpu=2048                                                                                       
# It is mandatory to indicate a maximum time for the process. 
# If you have no idea about how much time it will take, set it at a big value
#SBATCH --time=15:00:00   
# So far there is only one queue, compute       
#SBATCH --partition=2018allq

echo $SLURMD_NODENAME
echo "Removing everything"
rm -r /var/tmp/ugarciarena
mkdir /var/tmp/ugarciarena
ls /var/tmp/ugarciarena/
echo "Removed. Copying venv"
cp venv.zip /var/tmp/ugarciarena
echo "Copied. Unzipping"
unzip /var/tmp/ugarciarena/venv.zip -d /var/tmp/ugarciarena
echo "Unzipped"
rm /var/tmp/ugarciarena/venv.zip
ls /var/tmp/ugarciarena/
