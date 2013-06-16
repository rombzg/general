##
## Makefile for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
## 
## Made by benjamin deroche
## Login   <deroch_b@epitech.net>
## 
## Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
## Last update Sun Feb 23 19:25:42 2013 benjamin deroche
##

NAME		=	Bomberman

SRCS		=	Vector3f.cpp	\
			Block.cpp	\
			Map.cpp		\
			Bombe.cpp	\
			Bomberman.cpp	\
			MyGame.cpp	\
			Camera.cpp	\
			main.cpp

OBJS		=	$(SRCS:.cpp=.o)

LIBPATH		=	../GDLLIB/libgdl_gl-2012.4

CXXFLAGS	+=	-W -Wall -I$(LIBPATH)/include -L$(LIBPATH)/lib -Wl,--rpath=$(LIBPATH)/lib -lgdl_gl -lGL -lGLU

LDFLAGS		+=	-I$(LIBPATH)/include -L$(LIBPATH)/lib -Wl,--rpath=$(LIBPATH)/lib -lgdl_gl -lGL -lGLU

CXX		=	g++

RM		=	rm -f

all		:	$(NAME)

$(NAME)		:	$(OBJS) 
			$(CXX) $(CXXFLAGS) -o $(NAME) $(OBJS) $(LDFLAGS)

clean		:
			$(RM) *.o *~ *#

fclean		:	clean
			$(RM) $(NAME)

re		:	fclean all
