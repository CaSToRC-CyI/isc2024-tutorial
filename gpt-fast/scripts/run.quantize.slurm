#!/bin/bash -l

#SBATCH --job-name=gpt-fast-quantize
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH -G A100:1
#SBATCH --cpus-per-task=16 
#SBATCH --partition=grete
#SBATCH --time=01:00:00
#SBATCH --exclusive
#SBATCH --output=%x.out

TRAINING_PATH=/mnt/lustre-emmy-ssd/projects/isc2024_accel_genai_pytorch
CHECKPOINTS_PATH=$TRAINING_PATH/gpt-fast-checkpoints

module load anaconda3/2020.11
conda activate torch

export OMP_NUM_THREADS=1
export DEVICE=cuda
export MODEL_REPO=meta-llama/Llama-2-7b

echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
echo "Nodelist:= " $SLURM_JOB_NODELIST
echo "Number of nodes:= " $SLURM_JOB_NUM_NODES
echo "Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
echo "Example:= quantize + compile"
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "

echo "Preparing $MODEL_REPO to run on $DEVICE"
python generate.py --compile --checkpoint_path $CHECKPOINTS_PATH/$MODEL_REPO/model_int8.pth \
                   --prompt "Hello, my name is"