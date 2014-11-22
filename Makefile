DOCKER = docker
REPO = quay.io/aptible/debian

TAG = $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null)
ifeq ($(TAG), master)
	TAG = latest
else ifeq ($(TAG), HEAD)
	TAG = latest
endif

all: release

release: test build
	$(DOCKER) push $(REPO)

build:
	$(DOCKER) build -t $(REPO):$(TAG) .
