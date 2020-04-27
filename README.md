# CPD1-AWS-Test

Run:
1. source install-mpi.sh
2. Copy and execute on each NODE the file 'install.sh'
3. Change password for cpd1 user

# Test
Try the following commands for test MPI Environment:
1. ssh localhost
2. save in /etc/hosts file the alias name for each node (e.g. <ip> node01, <ip2> node02, etc.)
3. try from each node to connect at other nodes with ssh

# Deploy test
One time that the hosts file has been fixed with fair dns for each node, launch a sample of MPI software with following syntax:

  sh employAWS.sh machinefile 8 a.out

A simple execution in MPI enviroment with 8 processors for launching "a.out" executable has been shown.

N.B. The "machinefile" must contain the hostname of each node with related free slots.

# Some compilation issues 
If there are some problems related to 'mpicc' compilation procedure, launch on each NODE the command 'sudo ldconfig'.
