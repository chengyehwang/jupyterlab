docker_build:
	docker build -t jupyterlab .
docker_run:
	docker run -i -t jupyterlab
docker_image:
	docker image ls
docker_save:
	docker save jupyterlab | gzip > jupyterlab.tgz
