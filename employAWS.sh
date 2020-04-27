#!/bin/bash

if [ "$1" != "" ]; then
    echo "Starting MPI employing"
else
    echo "Insert arguments: <machinefile> <nProcessors> <executableFile>\n"
    exit
fi

{
	scp $3 node01:
	scp $3 node02:
	scp $3 node03:
} &> /dev/null

mpirun --hostfile $1 -np $2 ./$3
