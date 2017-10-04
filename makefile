
NAME=ryankurte/docker-omnetpp

IP=$(shell ifconfig en0 | grep inet | awk '$$1=="inet" {print $$2}')

build: Dockerfile
	docker build -t $(NAME) .

setup-xhost:
	xhost + $(IP)

run-xhost:
	docker run --rm -it -v `pwd`:/work -e DISPLAY=$(IP):0 -v /tmp/.X11-unix:/tmp/.X11-unix $(NAME)


