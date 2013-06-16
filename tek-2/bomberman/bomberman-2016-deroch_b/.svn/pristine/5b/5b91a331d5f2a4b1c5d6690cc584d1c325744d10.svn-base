/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#ifndef			__BLOCK_HH__
#define			__BLOCK_HH__

#include		"AObject.hh"

class			Block : public AObject
{
public:
  enum			e_btype
    {
      EMPTY,
      WALL,
      BLOCK,
      FIRE
    };

private:
  bool			_onFire;
  e_btype		_btype;

public:
  Block(int x, int y);

public:
  void			initialize();
  void			update(gdl::GameClock const &, gdl::Input &);
  void			draw();
  float			getXPos() const;
  float			getYPos() const;
  float			getZPos() const;
  float			getXRot() const;
  float			getYRot() const;
  float			getZRot() const;
  float			getTimer() const;
  AObject::e_otype	getOType() const;
  void			setPos(float, float, float);
  void			setRot(float, float, float);
  void			setType(e_btype);
  void			setTimer(float);
  bool			isEmpty() const;
  bool			isWall() const;
  bool			isBlock() const;
  bool			isOnFire() const;
};

#endif
