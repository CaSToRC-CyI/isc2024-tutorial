# Setting Up Environment for Accelerating Generative AI with PyTorch
Use the information provided here to get started with using the HPC clusters at GWDG.

## Installing SSH Client
### Linux
The [OpenSSH client](https://www.openssh.com/) is usually already installed. To check if it is, pull up a terminal and see what the following command returns:
```console
ssh -V
```
If it prints something like `OpenSSH_8.9p1 [...]`, it is already installed. Otherwise, use your package manager to install it:
#### Ubuntu and Debian
```console
sudo apt install openssh-client
```
#### Fedora and RHEL/Rockylinux/Almalinux 8+
```console
sudo dnf install openssh-clients
```
#### RHEL/CentOS/SL 7
```console
sudo yum install openssh-clients
```
#### Arch
```console
sudo pacman -S openssh
```


### MacOS
Mac OS X and newer already have a terminal and OpenSSH client installed, so nothing more has to be done. The builtin terminal program’s name is `Terminal`. If you need X11 forwarding in your terminal, you will additionally need to install and use [XQuartz](https://www.xquartz.org/).


### Windows
The already installed PowerShell (or the classic `cmd.exe`) provides the terminal. They should be listed in the Start menu. To check if OpenSSH is installed, run:
```console
ssh --version
```
If it does not work, try:
```console
ssh -V
```
This will print the OpenSSH client's version if it is present, and fail if it isn't installed. If it is not installed, re-run PowerShell as an administrator (right click on it's Start menu entry to see this option) and install it with:
```console
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```
Then confirm that it works with `ssh --version` or `ssh -V`.


## Configuring SSH
### Config file location
The OpenSSH configuration file is a plain text file that defines Hosts with short, easy to type names and corresponding full DNS names (or IPs) and advanced configuration options, which private key to use, etc. It is usually located in your home directory or user profile directory under `.ssh/config`. ***If you do not find such a file or directory, create them manually*** (the `config` file  has no extension). The directory and the file for different OSs are shown below:
#### Linux
```console
~/.ssh/config
/home/$USERNAME/.ssh/config
```
#### MacOS
```console
~/.ssh/config
/User/$USERNAME/.ssh/config
```
#### Windows
```
%USERPROFILE%\.ssh\config
C:\Users\your_username\.ssh\config
```
### SSH key
To set up your SSH key, first download it from [here](https://owncloud.gwdg.de/index.php/f/2885857924) using the provided download password. The key consists of two files: a private key named `id_XXXX` and a public key named `id_XXXX.pub`. You will also receive a key password, which you'll need when prompted for your passphrase in the terminal. Finally, put the provided public and private SSH keys in the `.ssh/config` directory.
### Config file contents
Now, edit the config file as shown below:
```
Host Grete
	Hostname glogin-gpu.hpc.gwdg.de
	User uXXXXXX
	IdentityFile ~/.ssh/id_XXXX
	MACs hmac-sha2-512,hmac-sha2-256,hmac-sha1
```
where the `uXXXXXX` is your project username and the `id_XXXX` is the name of your SSH key.


## Logging In into an NHR Grete login node
With the `.ssh/config` file setup from above, you need to run only the following command:
```console
ssh Grete
```
After running the command, you'll be prompted to enter your SSH key passphrase. The passphrase is provided with your SSH key.  
The terminal session could look something like:
```console
jdoe1@laptop:~> ssh Grete
Enter passphrase for key '/home/jdoe1/.ssh/id_ed25519':
Last login: Wed Mar 20 09:05:45 2024 from 192.168.0.1

********************************************************************************
*                                                                              *
*                     Welcome to HLRN-IV site Goettingen,                      *
*                     this is node glogin10 on "Emmy".                         *
*                                                                              *
*  Documentation  ->  https://www.hlrn.de/doc/                                 *
*  Support        ->  mailto:support@hlrn.de                                   *
*                                                                              *
********************************************************************************

Found "/scratch/usr/gzadmfnord", setting $WORK
Found "/scratch/tmp/gzadmfnord", setting $TMPDIR
Module sw.skl loaded.
Module slurm (current version 23.11.4) loaded.
Module HLRNenv loaded.

Loading HLRNenv
  Loading requirement: sw.skl slurm
glogin10:~ $
```


## Clone the GitHub repository
Clone the GitHub repository in your user directory executing the following command:
```console
git clone https://github.com/CaSToRC-CyI/isc2024-tutorial.git
```


## Allocating a computing node from the NHR Grete cluster
To view the available computing nodes, execute the following command:
```console
sacctmgr list clusters
```
The output should look similar to the example below, where the name of the available node is `ghlrn4`:
```console
   Cluster     ControlHost  ControlPort   RPC     Share GrpJobs       GrpTRES GrpSubmit MaxJobs       MaxTRES MaxSubmit     MaxWall                  QOS   Def QOS
---------- --------------- ------------ ----- --------- ------- ------------- --------- ------- ------------- --------- ----------- -------------------- ---------
    ghlrn4   10.241.201.73         6817 10240

```
To allocate this computing node, execute the following command:
```console
salloc --clusters=ghlrn4 -N -1
```
The terminal session could look something like:
```console
glogin10:~ $ salloc --clusters=ghlrn4 -N -1
salloc: Pending job allocation 5698241
salloc: job 5698241 queued and waiting for resources
salloc: job 5698241 has been allocated resources
salloc: Granted job allocation 5698241
salloc: Waiting for resource configuration
salloc: Nodes gcn1234 are ready for job
gcn1234:~ $
```
In this case, `gcn1234` is the name of your allocated computing node, which will be required for building the SSH tunnel.


## Activate the virtual environment
The virtual environment `introenv` is already created in the shared space `/mnt/lustre-emmy-ssd/projects/isc2024_accel_genai_pytorch/`.  
To activate the virtual environment execute the following command: 
```console
source /mnt/lustre-emmy-ssd/projects/isc2024_accel_genai_pytorch/introenv/bin/activate
```


## Run your first notebook on the cluster
Navigate to the project directory:
```console
cd isc2024-tutorial/intro/
```
Run the Jupyter Notebook by executing the following command:
```console
jupyter notebook --ip=0.0.0.0 --no-browser
```
Setting the `--ip` option to `0.0.0.0` means that the server will listen on all available network interfaces. In practical terms, this allows the server to accept connections from any IP address.

The terminal session could look something like:
```console
(introenv) gcn1234:~/isc2024-tutorial/intro $ jupyter notebook --ip=0.0.0.0 --no-browser
[I 01:43:42.949 NotebookApp] Serving notebooks from local directory: /home/your_username/uXXXXXX/isc2024-tutorial/intro
[I 01:43:42.950 NotebookApp] Jupyter Notebook 6.4.10 is running at:
[I 01:43:42.950 NotebookApp] http://gcn1234:8888/?token=a22d1349b8e2b42db09715a27a3c6831f2defe64d10c4db3
[I 01:43:42.950 NotebookApp]  or http://127.0.0.1:8888/?token=a22d1349b8e2b42db09715a27a3c6831f2defe64d10c4db3
[I 01:43:42.950 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 01:43:42.961 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///home/your_username/uXXXXXX/.local/share/jupyter/runtime/nbserver-603528-open.html
    Or copy and paste one of these URLs:
        http://gcn1234:8888/?token=a22d1349b8e2b42db09715a27a3c6831f2defe64d10c4db3
     or http://127.0.0.1:8888/?token=a22d1349b8e2b42db09715a27a3c6831f2defe64d10c4db3

```
Copy and paste the URL starting with `http://127.0.0.1:8888` into your browser after establishing the SSH tunnel.


## Build SSH tunnel to visualize the notebook
Open a new terminal and execute the following command (you'll be prompted to enter your SSH key passphrase):
```console
ssh -v Grete -N -L 8888:gcn1234:8888
```
Ensure that the port number `8888` matches the one from the previous step, and `gcn1234` is the name of the computing node.


## Visualize the notebook in your local browser
Open your web browser and paste the copied URL starting with `http://127.0.0.1:8888`. Press Enter. You should see the Jupyter Notebook opened in the directory you navigated to, `isc2024-tutorial/intro/`.  
Open and run the `Intro_Notebook.ipynb`. It is expected to display information similar to the following:
```console
posix.uname_result(sysname='Linux', nodename='gcn1234', release='3.10.0-1160.95.1.el7.x86_64', version='#1 SMP Mon Jul 24 13:59:37 UTC 2023', machine='x86_64')
```


## Congratulations! You ran your first notebook on the NHR Grete cluster.
To stop the Jupyter server, you can either use the interface or execute `Ctrl+C` in the terminal. To terminate the tunnel, use `Ctrl+C` again. To deactivate the activated environment, execute `deactivate`. To terminate the computing node or the cluster, use the command `exit`.

