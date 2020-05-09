#!/bin/bash
source /opt/miniconda3/etc/profile.d/conda.sh
conda activate

export AIRFLOW_HOME=~/airflow
STATE=1
if [ -f ~/airflow/airflow-webserver.pid ]; then
    PID=`cat ~/airflow/airflow-webserver.pid`
    echo $PID
    ps -p $PID > /dev/null
    STATE=$?
fi
if [ $STATE -eq "0" ]
then
	echo "server is alive, port $PID"
else
	airflow webserver -p 8080 > /tmp/airflow_webserver.log &
	airflow scheduler > /tmp/airflow_scheduler.log &
fi
