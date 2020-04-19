IP=$(shell hostname -I | awk '{print $$1}')
# run process
pull:
	docker pull chengyehwang/jupyterlab
	docker tag chengyehwang/jupyterlab jupyterlab
run:
	docker run -p 8888:8888 --mount src=`pwd`,target=/jupyterlab,type=bind -w /jupyterlab -t jupyterlab /jupyterlab/start_jupyterlab.sh $(IP)
stop:
	-docker stop $(shell docker ps -a -q)
	-docker rm $(shell docker ps -a -q)
# build process
build:
	docker build -t jupyterlab:latest .
shell:
	docker run -i --mount src=`pwd`,target=/jupyterlab,type=bind -w /jupyterlab -t jupyterlab
push:
	docker login
	docker tag jupyterlab chengyehwang/jupyterlab
	docker push chengyehwang/jupyterlab
clean:
	docker system prune
image:
	docker image ls -a

