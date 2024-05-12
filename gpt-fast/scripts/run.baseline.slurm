#!/bin/bash -l

#SBATCH --job-name=gpt-fast-baseline
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH -G A100:1
#SBATCH --cpus-per-task=16 
#SBATCH --partition=grete:shared
#SBATCH --time=01:00:00
#SBATCH --output=%x.out

# Figure out current script path
if [ -n "${SLURM_JOB_ID:-}" ] ; then
SCRIPT_PATH=$(scontrol show job "$SLURM_JOB_ID" | awk -F= '/Command=/{print $2}')
else
SCRIPT_PATH=$(realpath "$0")
fi
SCRIPT_DIR=$(dirname $SCRIPT_PATH)

SHARED_PATH=/mnt/lustre-emmy-ssd/projects/isc2024_accel_genai_pytorch
CHECKPOINTS_PATH=$SHARED_PATH/gpt-fast-checkpoints

# Check if the user provided the environment path
if [ -z "$1" ]; then
    ENV_PATH=$SHARED_PATH
else
    ENV_PATH=$1
fi
EXEC_PATH=$SCRIPT_DIR/..

module load python/3.9.16
source $ENV_PATH/torch/bin/activate

export OMP_NUM_THREADS=1
export DEVICE=cuda
export MODEL_REPO=meta-llama/Llama-2-7b

echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
echo "Nodelist:= " $SLURM_JOB_NODELIST
echo "Number of nodes:= " $SLURM_JOB_NUM_NODES
echo "Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
echo "Example:= baseline"
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "

echo "Preparing $MODEL_REPO to run on $DEVICE"
python $EXEC_PATH/generate.py --checkpoint_path $CHECKPOINTS_PATH/$MODEL_REPO/model.pth \
                              --prompt "Hello, my name is"