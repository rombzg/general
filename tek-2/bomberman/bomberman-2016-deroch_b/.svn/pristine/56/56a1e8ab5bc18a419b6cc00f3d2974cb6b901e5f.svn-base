/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#include	<unistd.h>
#include	"Bombe.hh"
#include	"Bomberman.hh"
#include	"MyGame.hh"

void		MyGame::initialize()
{
  window_.create();
  _camera.initialize();
  _map.initialize(_xs, _ys);
  Bomberman	*b = new Bomberman();
  b->setPlayerNum(1);
  b->setMap(&_map);
  b->setMyGame(this);
  _objects.push_front(b);
  Bomberman	*b2 = new Bomberman(300.0f * (_xs - 1), 300.0f * (_ys - 1), 0.0f);
  b2->setPlayerNum(2);
  b2->setMap(&_map);
  b2->setMyGame(this);
  _objects.push_front(b2);
  std::list<AObject*>::iterator	itb = this->_objects.begin();
  for (; itb != this->_objects.end(); ++itb)
    (*itb)->initialize();
}

void		MyGame::update()
{
  float		n;
  float		x;
  float		y;
  float		z;

  n = 0.0f;
  x = 0.0f;
  y = 0.0f;
  z = 0.0f;
  std::list<AObject*>::iterator	itb = _objects.begin();
  for (; itb != _objects.end(); ++itb)
    {
      (*itb)->update(gameClock_, input_);
      if ((*itb)->getOType() == AObject::BOMBE)
      	{
      	  if ((*itb)->getTimer() < gameClock_.getTotalGameTime())
      	    {
	      _map.explodePos((*itb)->getXPos(), (*itb)->getYPos(), 2);
      	      _objects.erase(itb);
	      itb = _objects.begin();
      	    }
      	}
      n += 1.0;
      x += (*itb)->getXPos();
      y += (*itb)->getYPos();
      z += (*itb)->getZPos();
    }
  if (n != 0.0f)
    {
      x /= n;
      y /= n;
      z /= n;
    }
  _camera.setBarycentre(x, y, z);
  _camera.update(gameClock_, input_);
  _map.update(gameClock_, input_);
}

void		MyGame::draw()
{
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glClearColor(0.74f, 0.84f, 95.0f, 1.0f);
  glClearDepth(1.0f);

  std::list<AObject*>::iterator	itb = this->_objects.begin();
  for (; itb != this->_objects.end(); ++itb)
    (*itb)->draw(); 

  _map.draw();

  this->window_.display();
}

void		MyGame::unload()
{

}

void		MyGame::addBombe(float x, float y)
{
  Bombe		*b = new Bombe(x, y, 0.0f);
  b->initialize();
  _objects.push_back(b);
}

void		MyGame::setXS(int xs)
{
  _xs = xs;
}

void		MyGame::setYS(int ys)
{
  _ys = ys;
}
