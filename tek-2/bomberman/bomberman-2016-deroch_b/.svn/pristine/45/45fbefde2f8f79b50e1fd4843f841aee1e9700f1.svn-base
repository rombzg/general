/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#ifndef		__BOMBE_HH__
#define		__BOMBE_HH__

#include	<GameClock.hpp>
#include	<Model.hpp>
#include	"AObject.hh"

class		Bombe : public AObject
{
private:
  gdl::Model	_model;

public:
  Bombe();
  Bombe(float, float, float);
  ~Bombe();

public:
  void	initialize();
  void	update(gdl::GameClock const &, gdl::Input &);
  void	draw();
  float	getXPos() const;
  float	getYPos() const;
  float	getZPos() const;
  float	getXRot() const;
  float	getYRot() const;
  float	getZRot() const;
  float	getTimer() const;
  AObject::e_otype	getOType() const;
  void	setXPos(float);
  void	setYPos(float);
  void	setPos(float, float, float);
  void	setRot(float, float, float);
};

#endif
