/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#include	"Map.hh"
#include	<iostream>

Map::Map()
{

}

void		Map::initialize(int xs, int ys)
{
  Block		*b;
  int		x;
  int		y;

  _x_size = xs;
  _y_size = ys;
  for (x = 0; x < _x_size; x++)
    {
      for (y = 0; y < _y_size; y++)
	{
	  b = new Block(x, y);
	  b->initialize();
	  if (x % 2 && y % 2)
	    b->setType(Block::WALL);
	  else if (!(x < 2 && y < 2) && !(x > _x_size - 3 && y > _y_size - 3) && rand() % 10 < 6)
	    b->setType(Block::BLOCK);
	  else
	    b->setType(Block::EMPTY);
	  _block_list.push_back(b);
	}
    }
}

void		Map::update(gdl::GameClock const & gameClock, __attribute__((__unused__))gdl::Input & input)
{
  int		size;
  int		i;

  size = _x_size * _y_size;
  for (i = 0; i < size; i++)
    _block_list[i]->update(gameClock, input);  
}

void		Map::draw()
{
  int		size;
  int		i;

  size = _x_size * _y_size;
  for (i = 0; i < size; i++)
    _block_list[i]->draw();
}

int		Map::listPos(float px, float py)
{
  int		x;
  int		y;

  x = int(px) / 300;
  y = int(py) / 300;
  if (x >= 0 && y >= 0 && x < _x_size && y < _y_size)
    return (x * _x_size + y);
  else
    return (-1);
}

bool		Map::isEmptyPos(float x, float y)
{
  int		pos;

  if ((pos = listPos(x, y)) != -1)
    return (_block_list[pos]->isEmpty());
  else
    return (false);
}

bool		Map::isOnFirePos(float x, float y)
{
  int		pos;

  if ((pos = listPos(x, y)) != -1)
    return (_block_list[pos]->isOnFire());
  else
    return (false);
}

void		Map::explodePos(float x, float y, int pow)
{
  int		pos;

  if ((pos = listPos(x, y)) != -1)
    {
      _block_list[pos]->setType(Block::FIRE);
      explodeNextX(x + 300.0f, y, pow - 1);
      explodeNextY(x, y + 300.0f, pow - 1);
      explodePrevX(x - 300.0f, y, pow - 1);
      explodePrevY(x, y - 300.0f, pow - 1);
    }
}

void		Map::explodeNextX(float x, float y, int pow)
{
  int		pos;

  if ((pos = listPos(x, y)) != -1)
    {
      if (pow > 0 && _block_list[pos]->isEmpty())
	explodeNextX(x + 300.0f, y, pow - 1);
      if (!_block_list[pos]->isWall())
	_block_list[pos]->setType(Block::FIRE);
    }
}

void		Map::explodeNextY(float x, float y, int pow)
{
  int		pos;

  if ((pos = listPos(x, y)) != -1)
    {
      if (pow > 0 && _block_list[pos]->isEmpty())
	explodeNextY(x, y + 300.0f, pow - 1);
      if (!_block_list[pos]->isWall())
	_block_list[pos]->setType(Block::FIRE);
    }
}

void		Map::explodePrevX(float x, float y, int pow)
{
  int		pos;

  if ((pos = listPos(x, y)) != -1)
    {
      if (pow > 0 && _block_list[pos]->isEmpty())
	explodePrevX(x - 300.0f, y, pow - 1);
      if (!_block_list[pos]->isWall())
	_block_list[pos]->setType(Block::FIRE);
    }
}

void		Map::explodePrevY(float x, float y, int pow)
{
  int		pos;

  if ((pos = listPos(x, y)) != -1)
    {
      if (pow > 0 && _block_list[pos]->isEmpty())
	explodePrevY(x, y - 300.0f, pow - 1);
      if (!_block_list[pos]->isWall())
	_block_list[pos]->setType(Block::FIRE);
    }
}
