#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

module load python/3.9.16

python3 -m venv $SCRIPT_DIR/venv
source $SCRIPT_DIR/venv/bin/activate

python3 -m pip install -r $SCRIPT_DIR/requirements.txt
