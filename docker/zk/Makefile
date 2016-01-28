include env_make
NS = vogt1005.scripps.edu:5000
VERSION ?= latest

IMAGE = zk
NAME = zk
INSTANCE = default

.PHONY: push shell run start stop rm 

build: docker/Dockerfile docker/files/zoo.cfg docker/files/zk.sh
	docker build -t $(NS)/$(IMAGE):$(VERSION) docker
	touch $@

buildclean:
	docker build -t $(NS)/$(IMAGE):$(VERSION) --no-cache docker
	touch $@

push:
	docker push $(NS)/$(IMAGE):$(VERSION)

shell:
	docker run --rm --name $(NAME)-$(INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE):$(VERSION)

start:
	docker run -d --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE):$(VERSION)

stop:
	docker stop $(NAME)-$(INSTANCE)

rm:
	docker rm $(NAME)-$(INSTANCE)

clean:
	docker rmi $(NS)/$(IMAGE):$(VERSION) 
	rm build release

release: build
	make push -e VERSION=$(VERSION)
	touch $@

default: build
