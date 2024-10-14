# Define the Docker Compose file
DOCKER_COMPOSE_FILE=docker-compose.yml

# Define the Docker Compose project name (optional)
PROJECT_NAME=myproject

# Target to start the Docker Compose services
up:
    docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) up -d

# Target to stop the Docker Compose services
down:
    docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) down

# Target to view the logs of the Docker Compose services
logs:
    docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) logs -f

# Target to restart the Docker Compose services
restart: down up

# Target to build the Docker Compose services
build:
    docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) build

# Target to remove all stopped containers, networks not used by at least one container, dangling images, and build cache
clean:
    docker system prune -f

# Target to show the status of the Docker Compose services
status:
    docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) ps

# Target to execute a shell in the WordPress container (example)
shell-wordpress:
    docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) exec wordpress bash

# Target to execute a shell in the MariaDB container (example)
shell-mariadb:
    docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) exec mariadb bash