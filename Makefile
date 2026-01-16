DOCKER_COMPOSE = docker-compose

build:
	$(DOCKER_COMPOSE) build
.PHONY: build

up:
	$(DOCKER_COMPOSE) up -d
.PHONY: up

down:
	$(DOCKER_COMPOSE) down
.PHONY: down

logs:
	$(DOCKER_COMPOSE) logs -f
.PHONY: logs
