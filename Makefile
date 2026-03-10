NAME = inception
YML	= srcs/docker-compose.yml

all: $(NAME)

$(NAME):
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	docker compose -f $(YML) up --build -d

up:
	docker compose -f $(YML) up -d

down:
	docker compose -f $(YML) down

prune:
	docker system prune --all --volumes

volume:
	sudo rm -rf ~/data/wordpress
	sudo rm -rf ~/data/mariadb
	sudo rm -rf ~/data/
	
domain:	
	echo "127.0.0.1 cyglardo.42.fr" >> /etc/hosts

logs: 
	docker compose -f $(YML) logs

clean:
	- docker container stop $$(docker container ps -aq)
	- docker container rm $$(docker container ps -aq)
	- docker image rm -f $$(docker image ls -aq)
	- docker volume rm $$(docker volume ls -q)
	- docker network rm $(shell docker network ls --filter type=custom -q)

fclean: clean volume

re:	fclean all

