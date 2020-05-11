#!/bin/bash
source /opt/miniconda3/etc/profile.d/conda.sh
conda activate

export AIRFLOW_HOME=$PWD/airflow
if [ ! -d $AIRFLOW_HOME ]; then
    airflow initdb
    sed -i 's/load_examples = True/load_examples = False/' $AIRFLOW_HOME/airflow.cfg
    airflow resetdb -y
    mkdir -p $AIRFLOW_HOME/dags
    echo "create airflow directory $AIRFLOW_HOME"
fi

if [ ! -f $AIRFLOW_HOME/dags/demo_airflow.py ]; then
    echo "copy demo_ariflow.py into $AIRFLOW_HOME/dags"
    cp ./demo_airflow.py $AIRFLOW_HOME/dags/demo_airflow.py
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
	echo "server is alive, pid $PID"
else
    echo "enable port 8880"
	airflow webserver -p 8880 > /tmp/airflow_webserver.log &
	airflow scheduler > /tmp/airflow_scheduler.log &
fi
