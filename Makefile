# Define the Docker Compose file
DOCKER_COMPOSE_FILE=docker-compose.yml

# Target to start the Docker Compose services
up:
	docker compose -f ./srcs/$(DOCKER_COMPOSE_FILE) up  -d

# Target to stop the Docker Compose services
down:
	docker compose -f ./srcs/$(DOCKER_COMPOSE_FILE) down -v

# Target to view the logs of the Docker Compose services
logs:
	docker compose -f ./srcs/$(DOCKER_COMPOSE_FILE) logs

status:
	docker compose -f ./srcs/$(DOCKER_COMPOSE_FILE) ps

# Target to restart the Docker Compose services
restart:
	down up

# Target to remove all stopped containers, networks not used by at least one container, dangling images, and build cache
clean:
	docker system prune -fa
