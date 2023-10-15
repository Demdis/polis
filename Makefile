
BASEURL ?= https://127.0.0.1.sslip.io
E2E_RUN = cd e2e; CYPRESS_BASE_URL=$(BASEURL)
# Export environment variables from .env file
include .env
export $(shell sed 's/=.*//' .env)

.PHONY: help

help:  ## Show this help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

prod: ## Start all Docker containers
	@docker compose up --detach

build: ## Start all Docker containers
	@docker compose build

dev: ## Start all Docker containers
	@docker compose -f docker-compose.dev.yml up --detach

down:
	@docker compose down

restart:  ## Restart containers
	@docker compose restart

start-rebuild: ## Start all Docker containers, [re]building as needed
	@docker compose up --detach --build

logs:  ## Show logs
	@docker compose logs -f

ps: ## Show status of containers
	@docker ps

%:
	@true

.DEFAULT_GOAL := help
