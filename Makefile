DOCKER = docker
REPO = quay.io/aptible/debian

TAGS = $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null)
ifeq ($(TAGS), wheezy)
	TAGS = wheezy latest
endif

all: release

release: test build
	$(DOCKER) push $(REPO)

build:
	for tag in $(TAGS) ; do $(DOCKER) build -t $(REPO):$$tag . ; done
