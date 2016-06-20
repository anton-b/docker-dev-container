all: build

build:
	docker build -t centos-dev --rm=true -f Dockerfile ./
rmi:
	docker rmi centos-dev
rm:
	docker stop centos-dev
	docker rm centos-dev
run:
    #Windows style folders share
	docker run -d -v /c/Users/:/Users/ --name centos-dev centos-dev
	#Mac OS
	#docker run -d -v /Users/:/Users/ --name centos-dev centos-dev

attach:
	docker exec -i -t centos-dev /bin/bash
