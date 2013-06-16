/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#ifndef		__CAMERA_HH__
#define		__CAMERA_HH__

#include	<GL/gl.h>
#include	<GL/glu.h>
#include	<GameClock.hpp>
#include	<Input.hpp>
#include	"Vector3f.hh"

class		Camera
{
private:
  Vector3f	_position;
  Vector3f	_rotation;
  Vector3f	_barycentre;

public:
  Camera();

public:
  void		initialize();
  void		update(gdl::GameClock const &, gdl::Input &);
  void		setBarycentre(float, float, float);
};

#endif
