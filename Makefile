all: build

build:
	docker build -t centos-dev --rm=true -f Dockerfile ./
rmi:
	docker rmi centos-dev
rm:
	docker stop centos-dev
	docker rm centos-dev
run:
	docker run -d -v /c/Users/:/c/Users/ --name centos-dev centos-dev
	#docker run -d -v /home/:/host_home/ --name centos-dev centos-dev

attach:
	docker exec -i -t centos-dev /bin/bash
