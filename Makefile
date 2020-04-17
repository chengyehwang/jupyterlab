docker_build:
	docker build -t jupyterlab:latest .
docker_run:
	docker run -p 8888:8888 -t jupyterlab /root/start_jupyterlab.sh
	#docker run -p 8888:8888 -i -t jupyterlab
docker_image:
	docker image ls -a
docker_save:
	docker save jupyterlab:latest | gzip > jupyterlab.tgz
docker_test:
	docker import jupyterlab.tgz jupyterlab:test
docker_clean:
	-docker stop $(docker ps -a -q)
	-docker rm $(docker ps -a -q)
docker_all_clean:
	docker system prune
docker_push:
	docker login
	docker tag jupyterlab chengyehwang/jupyterlab
	docker push chengyehwang/jupyterlab
docker_pull:
	docker pull chengyehwang/jupyterlab
