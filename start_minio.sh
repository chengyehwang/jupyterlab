#!/bin/bash
source /opt/miniforge3/etc/profile.d/conda.sh
conda activate

export MINIO_ACCESS_KEY=jupyterlab
export MINIO_SECRET_KEY=jupyterlab
minio server $PWD >minio.log 2>&1 &

