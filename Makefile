all: build

build:
	docker build -t centos-dev --rm=true -f Dockerfile ./
rmi:
	docker rmi centos-dev
stop:
	docker stop centos-dev
setup-net:
	docker network create --subnet=192.168.30.0/24 --driver bridge centos-dev
rm-net:
	docker network rm centos-dev
rm:stop
	docker rm centos-dev

run:
	#Windows style folders share
	#docker run -d -v /c/Users/:/Users/ --name centos-dev centos-dev
	#Mac OS
	docker run -d -v /Users/:/Users/ --net=centos-dev --name centos-dev centos-dev

start:
	docker start centos-dev
attach:
	docker exec -i -t centos-dev /bin/bash
