.PHONY: help up down restart logs ps qdrant-health wait-qdrant wipe

# Variables
PROJECT_NAME	?= boxboxai
COMPOSE_FILE	?= infra/docker-compose.yaml
COMPOSE			= docker compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE)

QDRANT_HOST		?= localhost
QDRANT_PORT		?= 6333
QDRANT_URL		= http://$(QDRANT_HOST):$(QDRANT_PORT)

# Targets
help:
	@echo "make up             # Start Qdrant in detached mode"
	@echo "make down           # Stop Qdrant containers"
	@echo "make restart        # Restart Qdrant"
	@echo "make logs           # Tail Qdrant logs"
	@echo "make ps             # Show Qdrant container status"
	@echo "make qdrant-health  # Health check on $(QDRANT_URL)"
	@echo "make wait-qdrant    # Wait until Qdrant is ready (timeout 10s)"
	@echo "make wipe           # ⚠️ Stop and remove containers + volumes"

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

restart: down up

logs:
	$(COMPOSE) logs -f --tail=200

ps:
	$(COMPOSE) ps

qdrant-health:
	curl -s $(QDRANT_URL)/collections | jq . || echo "Qdrant up?"

wait-qdrant:
	@echo "Waiting for Qdrant to be ready at $(QDRANT_URL)"
	@for i in $$(seq 1 20); do \
		if curl -sf $(QDRANT_URL) >/dev/null; then \
			echo "Qdrant is ready ✅"; exit 0; \
		fi; \
		sleep 0.5; \
	done; \
	echo "Qdrant did not become ready ❌" >&2; exit 1

wipe:
	$(COMPOSE) down -v