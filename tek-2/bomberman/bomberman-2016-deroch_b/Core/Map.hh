/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#ifndef			__MAP_HH__
#define			__MAP_HH__

#include		<cstdlib>
#include		<vector>
#include		"Block.hh"

class			Map
{
private:
  std::vector<Block *>	_block_list;
  int			_x_size;
  int			_y_size;

public:
  Map();

public:
  void			initialize(int xs, int ys);
  void			update(gdl::GameClock const & gameClock, gdl::Input & input);
  void			draw();
  bool			isEmptyPos(float posx, float posy);
  bool			isOnFirePos(float posx, float posy);
  int			listPos(float px, float py);
  void			explodePos(float x, float y, int pow);
  void			explodeNextX(float x, float y, int pow);
  void			explodeNextY(float x, float y, int pow);
  void			explodePrevX(float x, float y, int pow);
  void			explodePrevY(float x, float y, int pow);
};

#endif
