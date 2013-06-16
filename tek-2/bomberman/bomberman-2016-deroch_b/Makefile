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

SRCS		=	Core/Vector3f.cpp	\
			Core/Block.cpp		\
			Core/Map.cpp		\
			Core/Bombe.cpp		\
			Core/Bomberman.cpp	\
			Core/MyGame.cpp		\
			Core/Camera.cpp		\
			Core/main.cpp		\

OBJS		=	$(SRCS:.cpp=.o)

LIBPATH		=	GDLLIB/libgdl_gl-2012.4

CXXFLAGS	+=	-W -Wall -I$(LIBPATH)/include -L$(LIBPATH)/lib -Wl,--rpath=$(LIBPATH)/lib -lgdl_gl -lGL -lGLU

LDFLAGS		+=	-I$(LIBPATH)/include -L$(LIBPATH)/lib -Wl,--rpath=$(LIBPATH)/lib -lgdl_gl -lGL -lGLU

CXX		=	g++

RM		=	rm -f

all		:	$(NAME)

$(NAME)		:	$(OBJS) 
			$(CXX) $(CXXFLAGS) -o $(NAME) $(OBJS) $(LDFLAGS)

clean		:
			$(RM) Core/*.o Core/*~ Core/*# Menu/*.o Menu/*~ Menu/*#

fclean		:	clean
			$(RM) $(NAME)

re		:	fclean all
