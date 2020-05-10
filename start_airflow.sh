#!/bin/bash
source /opt/miniconda3/etc/profile.d/conda.sh
conda activate

export AIRFLOW_HOME=$PWD/airflow
if [ ! -d $AIRFLOW_HOME ]; then
    airflow initdb
fi
STATE=1
if [ -f $AIRFLOW_HOME/airflow-webserver.pid ]; then
    PID=`cat $AIRFLOW_HOME/airflow-webserver.pid`
    echo $PID
    ps -p $PID > /dev/null
    STATE=$?
fi
if [ $STATE -eq "0" ]
then
	echo "server is alive, port $PID"
else
    echo "enable port $1"
	airflow webserver -p 8080 > /tmp/airflow_webserver.log &
	airflow scheduler > /tmp/airflow_scheduler.log &
fi
