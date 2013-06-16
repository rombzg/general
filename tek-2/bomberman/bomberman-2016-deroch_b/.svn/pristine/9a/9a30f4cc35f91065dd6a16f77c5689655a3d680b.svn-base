/*
** MyGame.cpp for  in /home/paquit_l/bomberman-2016-deroch_b/paquit_l
** 
** Made by paquit_l
** Login   <paquit_l@epitech.net>
** 
** Started on  mer. juin 05 12:45:47 2013 paquit_l
** Last update mer. juin 05 12:45:47 2013 paquit_l
*/

#include "MyGame.h"

void MyGame::initialize(void)
{
  window_.create();
  camera_.initialize();

  std::list<AObject*>::iteractor itb = this->objects_.begin();
  for(; itb != this->objects_end(); ++itb)
    (*itb)->initialize();
}

void MyGame::update(void)
{
  std::list<AObject*>::iteractor itb = this->objects_.begin();

  for (; itb != this->objects_.end(); itb)
    (*itb)->update(GameClock_, input_);
}

void MyGame::draw(void)
{
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glClearColor(0.74f, 0.84f, 95.0f, 1.0f);
  glClearDepth(1.0f);
  std::list<AObject*>::iterator itb = this->objects_.begin();
  for (; itb != this->objects_.end(); ++itb)
    (*itb)->draw();
  this->window_.display();
}

void MyGame::unload(void)
{

}
