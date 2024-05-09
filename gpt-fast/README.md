## Environment Setup

### Connecting to the System
```sh
# Connect to GWDG
$ ssh –i /path/to/ssh-key <username>@glogin-p3.hpc.gwdg.de
```

### Download Repo
```sh
$ cd $HOME
$ git clone https://github.com/CaSToRC-CyI/isc2024-tutorial.git
```

### Setup Paths and Activate Environment
```sh
# Shared Project path
$ export SHARED_PATH=/mnt/lustre-emmy-ssd/projects/isc2024_accel_genai_pytorch
# Checkpoints contain the Llama2 7B weights
$ ls $SHARED_PATH/gpt-fast
  gpt-fast gpt-fast-checkpoints
# Activate environment - Needed for generating plots
$ module load python/3.9.16
$ source $SHARED_PATH/torch/bin/activate
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