# for conda try and then merge
conda install -y autopep8

pip install apache-airflow minio qgrid
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
mv minio /usr/local/bin
