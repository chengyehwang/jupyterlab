all:
wasienv_env:
	wget https://raw.githubusercontent.com/wasienv/wasienv/master/install.sh -O wasienv-install.sh
	chmod 755 wasienv-install.sh
	sudo ./wasienv-install.sh
wasmer_env:
	wget https://raw.githubusercontent.com/wasmerio/wasmer-install/master/install.sh -O wasmer-install.sh
	chmod 755 wasmer-install.sh
	./wasmer-install.sh
app_init:
	androidjs init
build:
	cd wasm ; androidjs build
wasmer:
	cd wasm ; npm install wasmer
	npm install wabt
compile:
	wasicc readfile.c -o readfile
	wasmcc addTwo.c -o addTwo
	./node_modules/.bin/wat2wasm add.wat -o add.wasm
run:
	node  --experimental-wasm-modules test.mjs
python:
	wapm install python
	wapm run python
pip:
	wget https://pypi.python.org/packages/source/p/pip/pip-8.0.2.tar.gz
	tar zxvf pip-8.0.2.tar.gz
