NAME		=	Bomberman

SRCS		=	Game.cpp	\
			MyGame.cpp

OBJS		=	$(SRCS:.cpp=.o)

CXXFLAGS	+=	-W -Wall -I$(LIBPATH)/include -L$(LIBPATH)/lib -Wl,--rpath=$(LIBPATH)/lib -lgdl_gl -lGL -lGLU

LIBPATH		=	../GDLLIB/libgdl_gl-2012.4

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
