docker_build:
	docker build -t jupyterlab:latest .
docker_run:
	docker run -i -t jupyterlab
docker_image:
	docker image ls -a
docker_save:
	docker save jupyterlab | gzip > jupyterlab.tgz
docker_clean:
	docker system prune
	docker container rm jupyterlab
