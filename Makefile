NAME = inception

SRC_DIR = ./srcs
SRC =	docker-compose.yml \
		
OBJ = $(SRC:.c=.o)

SRC := $(addprefix $(SRC_DIR)/, $(SRC))

CC = cc
CFLAGS = -Wall -Wextra -Werror -I ./inc

all: $(NAME)

$(NAME): $(OBJ)
	@${CC} ${CFLAGS} ${OBJ}  -o $(NAME)

clean:
	@${MAKE} -C clean
	rm -f $(OBJ)
fclean: clean
	rm -f $(NAME)
re: fclean all

.PHONY : all clean fclean re