# for conda try and then merge
conda install -y -c bioconda autopep8 snakemake

pip install minio qgrid
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
mv minio /usr/local/bin
