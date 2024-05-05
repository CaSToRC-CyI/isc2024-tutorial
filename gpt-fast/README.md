## Environment Setup

### Download Repo and Setup Paths
```sh
$ cd $HOME
$ git clone https://github.com/CaSToRC-CyI/isc2024-tutorial.git
```

### Initialise Conda
```sh
# Project Path Containing weights
$ export PROJ_PATH=/user/c.stylianou/u11227
# Check we can see the correct directories
$ ls $PROJ_PATH/gpt-fast-checkpoints
  meta-llama
# Setup conda and activate environment
$ module load anaconda3/2020.11
$ conda init
$ source ~/.bashrc
```

### Installing PyTorch
```sh
$ conda create -n torch python=3.11 -y
$ conda activate torch
$ pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
$ pip install sentencepiece matplotlib
```

## Running the Baseline Version
```sh
$ cd $HOME/isc2024-tutorial/gpt-fast
$ sbatch scripts/run.baseline.slurm
  Submitted batch job <JOBID>
# Check your job status
$ squeue --user=$USER
  JOBID  PARTITION NAME     USER ST TIME …
  <JOBID>    grete gpt-fast cstyl R 0:01 …
# Look for the output file
$ ls gpt-fast-baseline
  gpt-fast-baseline.out
# Plot the results
$ python plots/extract_and_plot.py gpt-fast-baseline.out
```

## Running the Compiled Version
```sh
# Go to Code Repository
$ cd $HOME/isc2024-tutorial/gpt-fast
$ sbatch scripts/run.compile.slurm
  Submitted batch job <JOBID>
# Check your job status
$ squeue --user=$USER
  JOBID  PARTITION NAME     USER ST TIME …
  <JOBID>    grete gpt-fast cstyl R 0:01 …
# Look for the output file
$ ls gpt-fast-compile
  gpt-fast-compile.out
# Plot the results
$ python plots/extract_and_plot.py gpt-fast-baseline.out gpt-fast-compile.out
```

## Running Quantized Version
```sh
# Go to Code Repository
$ cd $HOME/isc2024-tutorial/gpt-fast
$ sbatch scripts/run.quantize.slurm
  Submitted batch job <JOBID>
# Check your job status
$ squeue --user=$USER
  JOBID  PARTITION NAME     USER ST TIME …
  <JOBID>    grete gpt-fast cstyl R 0:01 …
# Look for the output file
$ ls gpt-fast-quantize
  gpt-fast-quantize.out
# Plot the results
$ python plots/extract_and_plot.py gpt-fast-baseline.out gpt-fast-compile.out gpt-fast-quantize.out
```

## Running Speculative Version
```sh
# Go to Code Repository
$ cd $HOME/isc2024-tutorial/gpt-fast
$ sbatch scripts/run.speculative.slurm
  Submitted batch job <JOBID>
# Check your job status
$ squeue --user=$USER
  JOBID  PARTITION NAME     USER ST TIME …
  <JOBID>    grete gpt-fast cstyl R 0:01 …
# Look for the output file
$ ls gpt-fast-speculative
  gpt-fast-speculative.out
# Plot the results
$ python plots/extract_and_plot.py gpt-fast-baseline.out gpt-fast-compile.out gpt-fast-quantize.out gpt-fast-speculative.out
```

## Running Tensor Parallelism Version
```sh
# Go to Code Repository
$ cd $HOME/isc2024-tutorial/gpt-fast
$ sbatch scripts/run.tp.slurm
  Submitted batch job <JOBID>
# Check your job status
$ squeue --user=$USER
  JOBID  PARTITION NAME     USER ST TIME …
  <JOBID>    grete gpt-fast cstyl R 0:01 …
# Look for the output file
$ ls gpt-fast-tp
  gpt-fast-tp.out
# Plot the results
$ python plots/extract_and_plot.py gpt-fast-baseline.out gpt-fast-compile.out gpt-fast-quantize.out gpt-fast-speculative.out gpt-fast-tp.out
```