/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#ifndef		__BOMBERMAN_HH__
#define		__BOMBERMAN_HH__

#include	<Model.hpp>
#include	"AObject.hh"
#include	"Map.hh"
#include	"MyGame.hh"

class		Bomberman : public AObject
{
public:
  enum		e_move
    {
      NO,
      UP,
      DOWN,
      LEFT,
      RIGHT
    };

private:
  Vector3f	_nextpos;
  e_move	_moving;
  float		_moveend;
  float		_movetmp;
  gdl::Model	_model;
  Map *		_map;
  MyGame *	_mygame;
  bool		_inLife;
  int		_playerNum;
  gdl::Keys::Key	_up;
  gdl::Keys::Key	_down;
  gdl::Keys::Key	_right;
  gdl::Keys::Key	_left;
  gdl::Keys::Key	_putbomb;

public:
  Bomberman();
  Bomberman(float, float, float);
  ~Bomberman();

public:
  void		initialize();
  void		update(gdl::GameClock const &, gdl::Input &);
  void		draw();
  float		getXPos() const;
  float		getYPos() const;
  float		getZPos() const;
  float		getXRot() const;
  float		getYRot() const;
  float		getZRot() const;
  float		getTimer() const;
  AObject::e_otype	getOType() const;
  void		setPos(float, float, float);
  void		setRot(float, float, float);
  void		setMap(Map *);
  void		setMyGame(MyGame *);
  void		setPlayerNum(int);
};

#endif
