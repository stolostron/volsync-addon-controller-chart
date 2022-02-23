OS := $(shell go env GOOS)
ARCH := $(shell go env GOARCH)
PROJECT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

HELM_VERSION := v3.7.1

.PHONY: lint
lint: ensure-helm ## Lint Helm chart
	$(HELM) lint stable/volsync-addon-controller

.PHONY: ensure-helm
HELM := $(PROJECT_DIR)/bin/helm
HELM_URL := https://get.helm.sh/helm-$(HELM_VERSION)-$(OS)-$(ARCH).tar.gz
ensure-helm: ## Download helm
ifeq (,$(wildcard $(HELM)))
	mkdir -p $(PROJECT_DIR)/bin
	curl -sSL "$(HELM_URL)" | tar xzf - -C $(PROJECT_DIR)/bin --strip-components=1 --wildcards '*/helm'
endif
