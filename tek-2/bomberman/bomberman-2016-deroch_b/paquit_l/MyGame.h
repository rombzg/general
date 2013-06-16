/*
** MyGame.h for  in /home/paquit_l/bomberman-2016-deroch_b/paquit_l
** 
** Made by paquit_l
** Login   <paquit_l@epitech.net>
** 
** Started on  mer. juin 05 12:39:48 2013 paquit_l
** Last update mer. juin 05 12:39:48 2013 paquit_l
*/

#ifndef		MYGAME_H_
# define	MYGAME_H_

#include "Game.h"

class MyGame : public gdl::Game
{
  private:
    Camera camera_;
    std::list<AObject*> objects_;

  public:
    void initialize(void);
    void update(void);
    void draw(void);
    void unload(void);
}

#endif		/* !MYGAME_H_*/
