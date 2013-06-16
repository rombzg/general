/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#include	<iostream>
#include	"Bombe.hh"

Bombe::Bombe()
{

}

Bombe::Bombe(float x, float y, float z) : AObject(x, y, z)
{
  
}

Bombe::~Bombe()
{
  // delete &_model;
}

void		Bombe::initialize()
{
  _model = gdl::Model::load("assets/models/bomb.fbx");
  _rotation.x = 90.0f;
  _otype = AObject::BOMBE;
  _timer = 0.0f;
}

void		Bombe::update(gdl::GameClock const & gameClock, __attribute__((__unused__))gdl::Input & input)
{
  if (_timer == 0.0f)
    _timer = gameClock.getTotalGameTime() + 5.0f;
}

void		Bombe::draw()
{
  glPushMatrix();
  glTranslatef(_position.x, _position.y, _position.z);
  glRotatef(_rotation.x, 1, 0, 0);
  glRotatef(_rotation.y, 0, 1, 0);
  glRotatef(_rotation.z, 0, 0, 1);
  _model.draw();
  glPopMatrix();
}

float	 	Bombe::getXPos() const
{
  return (_position.x);
}

float	 	Bombe::getYPos() const
{
  return (_position.y);
}

float	 	Bombe::getZPos() const
{
  return (_position.z);
}

float	 	Bombe::getXRot() const
{
  return (_rotation.x);
}

float	 	Bombe::getYRot() const
{
  return (_rotation.y);
}

float	 	Bombe::getZRot() const
{
  return (_rotation.z);
}

float		Bombe::getTimer() const
{
  return (_timer);
}

AObject::e_otype	Bombe::getOType() const
{
  return (_otype);
}

void		Bombe::setXPos(float x)
{
  _position.x = x;
}

void		Bombe::setYPos(float y)
{
  _position.y = y;
}

void		Bombe::setPos(float x, float y, float z)
{
  _position.x = x;
  _position.y = y;
  _position.z = z;
}

void		Bombe::setRot(float x, float y, float z)
{
  _rotation.x = x;
  _rotation.y = y;
  _rotation.z = z;
}
