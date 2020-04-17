docker_build:
	docker build -t jupyterlab:latest .
docker_run:
	docker run -i -t jupyterlab
docker_image:
	docker image ls -a
docker_save:
	docker save jupyterlab:latest | gzip > jupyterlab.tgz
docker_test:
	docker import jupyterlab.tgz jupyterlab:test
docker_clean:
	docker system prune
	docker container rm jupyterlab
docker_push:
	docker login
	docker tag jupyterlab chengyehwang/jupyterlab
	docker push chengyehwang/jupyterlab
docker_pull:
	docker pull chengyehwang/jupyterlab
