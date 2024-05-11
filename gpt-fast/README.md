## Environment Setup

### Connecting to the System with X11 Forwarding
```sh
# Connect to GWDG
$ ssh -X –i /path/to/ssh-key <username>@glogin-gpu.hpc.gwdg.de
# Or: ssh -X Grete
```
**Note** For MacOS users, to enable X11 forwarding you will additionally need to install and use [XQuartz](https://www.xquartz.org/). X11 is a mechanism that allows a user to start up remote applications, and then forward the application display to their local Windows machine. To enable this mechanism, during `ssh` you add the `-X` option.

### Download Repo
If haven't already downloaded the GitHub repo:
```sh
$ cd $HOME
$ git clone https://github.com/CaSToRC-CyI/isc2024-tutorial.git
```

### Setup Paths and Activate Environment
If you already have an active environment, please start a new terminal session, and activate the following steps to setup the correct environment:
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
$ sbatch --reservation=isc2024genai scripts/run.baseline.slurm
  Submitted batch job <JOBID>
# Check your job status
$ squeue --user=$USER
  JOBID  PARTITION NAME     USER ST TIME …
  <JOBID>    grete gpt-fast cstyl R 0:01 …
```
Once the job completes (takes 2-4 mins) proceed with ploting and displaying the results.
```sh
# Look for the output file
$ ls gpt-fast-baseline
  gpt-fast-baseline.out
# Plot the results
$ python plots/extract_and_plot.py gpt-fast-baseline.out
$ display combined_plot.jpg # Requires X11 forwarding (ssh -X)
```
**Note** If X11 forwarding not available, you can copy the plot from the server to your local environment. Open a new terminal and copy the file using `scp`:
```sh
$ scp Grete:/user/<name>/<username>/isc2024-tutorial/gpt-fast/combined_plot.jpg /local/path/to/download/in
```
where name (kursXXX) and username (uXXXXXX) can be found on the paper provided at the start of the tutorial.

## Running the Compiled Version
```sh
# Go to Code Repository
$ cd $HOME/isc2024-tutorial/gpt-fast
$ sbatch --reservation=isc2024genai scripts/run.compile.slurm
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
$ display combined_plot.jpg # Requires X11 forwarding (ssh -X)
```

## Running Quantized Version
```sh
# Go to Code Repository
$ cd $HOME/isc2024-tutorial/gpt-fast
$ sbatch --reservation=isc2024genai scripts/run.quantize.slurm
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
$ display combined_plot.jpg # Requires X11 forwarding (ssh -X)
```

## Running Speculative Version
```sh
# Go to Code Repository
$ cd $HOME/isc2024-tutorial/gpt-fast
$ sbatch --reservation=isc2024genai scripts/run.speculative.slurm
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
$ display combined_plot.jpg # Requires X11 forwarding (ssh -X)
```

## Running Tensor Parallelism Version
```sh
# Go to Code Repository
$ cd $HOME/isc2024-tutorial/gpt-fast
$ sbatch --reservation=isc2024genai scripts/run.tp.slurm
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
$ display combined_plot.jpg # Requires X11 forwarding (ssh -X)
```