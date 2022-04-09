SRCS		= ft_printf.c

OBJS		= ${SRCS:.c=.o}

NAME		= libftprintf.a

CC		= gcc

RM		= rm -f

CFLAGS		= -Wall -Wextra -Werror

.c.o:
		${CC} ${CFLAGS} -c $< -o ${<:.c=.o}

${NAME}:	${OBJS}
			ar rcs ${NAME} ${OBJS}
			ranlib $(NAME)

all:		${NAME}

clean:
			${RM} ${OBJS}

fclean:		clean
			${RM} ${NAME}

re:		fclean all

.PHONY: 	all clean fclean re .c.o