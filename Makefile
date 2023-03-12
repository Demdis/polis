
BASEURL ?= https://127.0.0.1.sslip.io
E2E_RUN = cd e2e; CYPRESS_BASE_URL=$(BASEURL)
# Export environment variables from .env file
include .env
export $(shell sed 's/=.*//' .env)

pull: ## Pull most recent Docker container builds (nightlies)
	docker compose pull

down:
	docker compose down

start: ## Start all Docker containers
	docker compose up --detach

start-rebuild: ## Start all Docker containers, [re]building as needed
	docker compose up --detach --build

# Helpful CLI shortcuts
rbs: start-rebuild


%:
	@true

.PHONY: help

help:
	@echo 'Usage: make <command>'
	@echo
	@echo 'where <command> is one of the following:'
	@echo
	@grep -E '^[a-z0-9A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
