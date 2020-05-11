# for conda try and then merge
conda install -y autopep8

pip install apache-airflow minio qgrid
apt install -y iproute2
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
mv minio /usr/local/bin
