BUILD_DIR?="docker"

DOCKER_NAMESPACE?=krakentechnologies

IMAGE?=tensorflow-gpu-hub

TF_VERSION?=1.15.2
TF_PACKAGE?=tensorflow-gpu

TAG?=${TF_VERSION}-gpu-py3

HOST_PORT?=8888

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.DEFAULT_GOAL := help
.PHONY: help
help:  ## Display this auto-generated help message
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build push run

build:  ## Build docker image
	@echo "Building with ${TF_PACKAGE}==${TF_VERSION}"
	docker build \
		--build-arg TENSORFLOW_VERSION=${TF_VERSION} \
		--build-arg TENSORFLOW_PACKAGE=${TF_PACKAGE} \
		-t ${IMAGE}:${TAG} ${BUILD_DIR}

push:  ## Push docker image to
	@echo "Pushing ${IMAGE}:${TAG} to ${DOCKER_NAMESPACE}/${IMAGE}:${TAG}"
	docker login
	docker tag ${IMAGE}:${TAG} ${DOCKER_NAMESPACE}/${IMAGE}:${TAG}
	docker push ${DOCKER_NAMESPACE}/${IMAGE}:${TAG}

run:  ## Run image locally
	docker run -it -p ${HOST_PORT}:8888 ${IMAGE}:${TAG}
