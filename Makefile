IP=$(shell hostname -I | awk '{print $$1}')
ARGS=-e DISPLAY --mount src=`pwd`,target=/jupyterlab,type=bind -w /jupyterlab
# run process
pull:
	docker pull chengyehwang/jupyterlab
	docker tag chengyehwang/jupyterlab jupyterlab
run:
	docker run -i $(ARGS)  -p 8000-9100:8000-9100 -t jupyterlab /jupyterlab/start_jupyterlab.sh $(IP)
cmd:
	docker run -i $(ARGS) -t jupyterlab /root/miniconda3/bin/ipython demo.py
ut:
	docker run -i $(ARGS) -t jupyterlab /root/miniconda3/bin/python -m unittest demo_module
stop:
	-docker stop $(shell docker ps -a -q)
	-docker rm $(shell docker ps -a -q)
# build process
build:
	docker build -t jupyterlab:latest .
shell:
	docker run -i $(ARGS) --net host -t jupyterlab
push:
	docker login
	docker tag jupyterlab chengyehwang/jupyterlab
	docker push chengyehwang/jupyterlab
clean:
	docker system prune -a
image:
	docker image ls -a

