#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo $SCRIPT_DIR

if [ -z "$1" ]; then
    ENV_PATH=/mnt/lustre-emmy-ssd/projects/isc2024_accel_genai_pytorch
else
    ENV_PATH=$1
fi

module load python/3.9.16

python3 -m venv $ENV_PATH/torch
source $ENV_PATH/torch/bin/activate

python3 -m pip install -r $SCRIPT_DIR/requirements.txt