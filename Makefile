all:
	docker build -t centos-dev --rm=true -f Dockerfile ./
rmi:
	docker rmi centos-dev
rm:
	docker stop centos-dev
	docker rm centos-dev
run:
	docker run -d --name centos-dev centos-dev

attach:
	docker exec -i -t centos-dev /bin/bash