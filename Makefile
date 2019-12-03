DOCKER_REGISTER ?= tarbase
DOCKER_TAG ?= latest

all: build run

build:
	docker build -t $(DOCKER_REGISTER)/jenkins:$(DOCKER_TAG) .

run:
	docker run \
		-p 8080:8080										\
		-p 50000:50000										\
		-e HTTP_PROXY="$(HTTP_PROXY)"						\
		-e HTTPS_PROXY="$(HTTPS_PROXY)" 					\
		-e AWS_ACCESS_KEY_ID="$(AWS_ACCESS_KEY_ID)"			\
		-e AWS_SECRET_ACCESS_KEY="$(AWS_SECRET_ACCESS_KEY)"	\
		-e AWS_REGION="$(AWS_REGION)"						\
		-v $(shell pwd)/var/jenkins_home					\
		$(DOCKER_REGISTER)/jenkins:$(DOCKER_TAG)

clean:
	docker rmi -f $(shell docker images tarbase/jenkins -aq)
