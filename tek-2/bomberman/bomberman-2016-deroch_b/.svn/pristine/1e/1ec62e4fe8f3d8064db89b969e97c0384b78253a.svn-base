/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#ifndef			__AOBJECT_HH__
#define			__AOBJECT_HH__

#include		<GL/gl.h>
#include		<GL/glu.h>
#include		<Image.hpp>
#include		<GameClock.hpp>
#include		<Input.hpp>
#include		"Vector3f.hh"

class			AObject
{
public:
  enum			e_otype
    {
      BLOCK,
      BOMBE,
      BOMBERMAN
    };

protected:
  Vector3f		_position;
  Vector3f		_rotation;
  gdl::Image		_texture;
  float			_timer;
  e_otype		_otype;

public:
  AObject() : _position(0.0f, 0.0f, 0.0f), _rotation(0.0f, 0.0f, 0.0f), _timer(0.0f) {}
  AObject(float x, float y, float z) : _position(x, y, z), _rotation(0.0f, 0.0f, 0.0f) {}

public:
  virtual void		initialize() = 0;
  virtual void		update(gdl::GameClock const &, gdl::Input &) = 0;
  virtual void		draw() = 0;
  virtual float		getXPos() const = 0;
  virtual float		getYPos() const = 0;
  virtual float		getZPos() const = 0;
  virtual float		getXRot() const = 0;
  virtual float		getYRot() const = 0;
  virtual float		getZRot() const = 0;
  virtual float		getTimer() const = 0;
  virtual e_otype	getOType() const = 0;
  virtual void		setPos(float, float, float) = 0;
  virtual void		setRot(float, float, float) = 0;
};

#endif
