/*
** AObject.h for  in /home/paquit_l/bomberman-2016-deroch_b/paquit_l
** 
** Made by paquit_l
** Login   <paquit_l@epitech.net>
** 
** Started on  mer. juin 05 12:32:23 2013 paquit_l
** Last update mer. juin 05 12:32:23 2013 paquit_l
*/

#ifndef		AOBJECT_H_
# define	AOBJECT_H_

#define "lib.h"

class AObject
{
  AObject(void) : position_(0.0f, 0.0f, 0.0f), rotation_(0.0f, 0.0f, 0.0f)
  {
  }
  virtual void initialize(void) = 0;
  virtual void update(gdl::GameClock const &, gdl::Input &) = 0;
  virtual void draw(void) = 0;
  protected:
  Vector3f position_;
  Vector3f rotation_;
}

#endif		/* !AOBJECT_H_*/
