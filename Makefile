NAME = inception
HOST_URL = cyglardo.42.fr
YML	= ./srcs/docker-compose.yml
CMP = docker-compose -f $(YML)

all: $(NAME)

$(NAME): up

up:
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	$(CMP) up -d --build
	echo "127.0.0.1 $(HOST_URL)" >> /etc/hosts

down:
	$(CMP) down

backup:
	if [ -d ~/data ]; then sudo tar -czvf ~/data.tar.gz -C ~/data/ ; fi

clean:
	docker container stop $$(docker container ps -aq)
	docker container rm $$(docker container ps -aq)
	docker image rmi -f $$(docker image ls -aq)
	docker volume rm $$(docker volume ls -q)
	docker network rm $(docker network ls -q)

fclean: backup clean
	docker system prune -af --volumes
	rm -rf ~/data/wordpress
	rm -rf ~/data/mariadb
	#rm -rf secrets/
	rm -f $(NAME)

re:	fclean all

.PHONY: all clean fclean re up down backup 
