source /opt/miniforge3/etc/profile.d/conda.sh
conda activate
git clone https://gitlab.com/fdroid/fdroidserver.git
cp fdroidserver/examples/makebuildserver.config.py fdroidserver/
echo "PATH=\$PATH:$HOME/fdroidserver" >> ~/.bashrc
cd fdroidserver
./makebuildserver --skip-cache-update
git clone https://gitlab.com/fdroid/fdroiddata.git
cp fdroidserver/examples/config.py fdroiddata/
sed -i "s@^[# ]*build_server_always.*@build_server_always = True@" fdroiddata/config.py
