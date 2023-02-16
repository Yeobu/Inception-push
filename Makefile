COMPOSE	= cd srcs && docker compose

MB_VOLUME = /home/stfernan/data/mysql

WP_VOLUME = /home/stfernan/data/html

VOLUMES = $(MB_VOLUME) $(WP_VOLUME)

all:
			sudo mkdir -p /home/stfernan/data/mysql 
			sudo mkdir -p /home/stfernan/data/html
			sudo mkdir -p /home/stfernan/data/cache
			sudo docker compose -f ./srcs/docker-compose.yml up -d --build
build:
	$(COMPOSE) build
up :
	sudo docker compose -f ./srcs/docker-compose.yml up -d --build
down :
	$(COMPOSE) down
re : fclean all

clean :
	$(COMPOSE) down -v --rmi all --remove-orphans

fclean :	clean
			docker system prune --volumes --all --force
			docker network prune --force
			echo docker volume rm $(docker volume ls -q)
			docker image prune --force
			sudo docker system prune -af --volumes

.PHONY: all up down clean fclean re