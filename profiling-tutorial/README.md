# How to run the notebook and connect to the jupyter server and Tensorboard
First, connect to Emmy through ssh:
```
ssh <username>@glogin.hlrn.de`
```
Clone the repository: 
```
git clone https://github.com/CaSToRC-CyI/isc2024-tutorial.git --depth=1
```
Go to the folder of the tutorial:
```
cd isc2024-tutorial/profiling-tutorial/
```
Then, submit a job to launch the Jupyter notebook and Tensorboard servers:  
```
sbatch --reservation=isc2024genai run_jupyter.job
```

Check that the job is running on a node with `squeue -u $USER`; i.e. `STATE` must be `RUNNING`:
```
glogin8:~/isc2024-tutorial/profiling-tutorial $ squeue -u $USER
             JOBID    PARTITION         NAME     USER  ACCOUNT     STATE       TIME NODES NODELIST(REASON)
           5698453 grete:shared run_jupyter.   u11229 isc2024_   RUNNING       0:42     1 ggpu201
```
When it's running, you can check the content of `~/connection_instructions.txt`:
```
cat ~/connection_instructions.txt
```
Which should print something like this:
```
glogin8:~/isc2024-tutorial/profiling-tutorial $ cat ~/connection_instructions.txt 
##################################################################################################
To connect to the notebook type the following command into your local terminal:
ssh -N -J u11229@glogin.hlrn.de u11229@ggpu201 -L 5626:localhost:5626 -L 5151:localhost:5151

After the connection is established in your local browser, go to the following addresses:
Jupyter notebooks: http://localhost:5626/tree?token=c73fcaa921cafc721624dfdb79a6081e70e911f4d85bff94
Tensorboard: http://localhost:5151/
##################################################################################################
```

Then, open a new **local** terminal, and follow the connection instructions from the output file.
I.e., first:
```
ssh -N -J u11229@glogin.hlrn.de u11229@ggpu201 -L 5626:localhost:5626 -L 5151:localhost:5151
```
Then in your previous terminal (on the cluster), click on the links (on linux Ctrl+LeftMouse) or copy the URL's to your browser.

In your browser, you should see two tabs open; one for the Jupyter notebook, and one for Tensorboard:
![image](https://github.com/CaSToRC-CyI/isc2024-tutorial/assets/5969044/96d6b396-2d08-45b8-84ed-a5ccfb737b38)

![image](https://github.com/CaSToRC-CyI/isc2024-tutorial/assets/5969044/8c0d7814-284b-4611-866f-854cee7be740)

