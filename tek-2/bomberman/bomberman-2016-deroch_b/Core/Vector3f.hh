/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#ifndef		__VECTOR3F_H__
#define		__VECTOR3F_H__

class		Vector3f
{
public:
  float		x;
  float		y;
  float		z;

public:
  Vector3f();
  Vector3f(float x, float y, float z);

public:
  bool		operator==(Vector3f const &);
  bool		operator!=(Vector3f const &);
};

#endif
