NAME = inception
YML	= ./srcs/docker-compose.yml
CMP = docker compose -f $(YML)

all: $(NAME)

$(NAME): up

up:
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	$(CMP) up -d --build

down:
	$(CMP) down -v --remove-orphans
	
#domain:	
#	echo "127.0.0.1 cyglardo.42.fr" >> /etc/hosts

#logs: 
#	$(CMP) logs

clean:
	- docker container stop $$(docker container ps -aq)
	- docker container rm $$(docker container ps -aq)
	- docker image rmi -f $$(docker image ls -aq)
	- docker volume rm $$(docker volume ls -q)
	- docker network rm $(docker network ls -q)

fclean: clean
	#rm -rf ~/data/wordpress
	#rm -rf ~/data/mariadb
	#rm -rf secrets/
	rm -f $(NAME)

re:	fclean all

.PHONY: all clean fclean re up down 
