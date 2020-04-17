IP=$(shell hostname -I | awk '{print $$1}')
docker_build:
	docker build -t jupyterlab:latest .
docker_server:
	docker run -p 8888:8888 -w /root -t jupyterlab /root/start_jupyterlab.sh $(IP)
docker_shell:
	docker run -i -t jupyterlab
docker_image:
	docker image ls -a
docker_save:
	docker save jupyterlab:latest | gzip > jupyterlab.tgz
docker_test:
	docker import jupyterlab.tgz jupyterlab:test
docker_clean:
	-docker stop $(shell docker ps -a -q)
	-docker rm $(shell docker ps -a -q)
docker_all_clean:
	docker system prune
docker_push:
	docker login
	docker tag jupyterlab chengyehwang/jupyterlab
	docker push chengyehwang/jupyterlab
docker_pull:
	docker pull chengyehwang/jupyterlab
