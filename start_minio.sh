#!/bin/bash
source /opt/miniconda3/etc/profile.d/conda.sh
conda activate

export MINIO_ACCESS_KEY=jupyter
export MINIO_SECRET_KEY=jupyter
minio server $PWD > minio.log &

