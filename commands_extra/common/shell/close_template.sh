#!/bin/bash

PidFind(){   
    PIDCOUNT=`ps -ef | grep $1 | grep -v "grep" | grep -v $0 | awk '{print $2}' | wc -l`;  
    echo "Found process num: ${PIDCOUNT} "
    if [ ${PIDCOUNT} -gt 0 ] ; then  
        echo "There are ${PIDCOUNT} process contains name[$1]" 
        PID=`ps -ef | grep $1 | grep -v "grep" | awk '{print $2}'` ;
        echo "$1 's PID is: $PID"
        kill -9  ${PID};
        echo "$1 's PID has killed!";
    elif [ ${PIDCOUNT} -le 0 ] ; then 
        echo "No such process[$1]!"  
    fi  
} 

PidFind  '/install/'
PidFind  'ros-args'
# exit 1
