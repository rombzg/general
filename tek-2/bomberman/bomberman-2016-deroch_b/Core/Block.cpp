/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#include	"Block.hh"

Block::Block(int x, int y) : AObject((float)x * 300.0f, (float)y * 300.0f, 0.0f)
{

}

void		Block::initialize()
{
  _onFire = false;
  _otype = AObject::BLOCK;
  _timer = 0.0f;
}

void		Block::update(gdl::GameClock const & gameClock, __attribute__((__unused__))gdl::Input & input)
{
  if (_btype == Block::FIRE)
    {
      if (_timer == 0.0f)
	_timer = gameClock.getTotalGameTime() + 2.0f;
      else if (_timer < gameClock.getTotalGameTime())
	{
	  _timer = 0.0f;
	  setType(Block::EMPTY);
	}
    }
}

void		Block::draw()
{
  glPushMatrix();
  glTranslatef(_position.x, _position.y, _position.z);
  glRotatef(_rotation.x, 1, 0, 0);
  glRotatef(_rotation.y, 0, 1, 0);
  glRotatef(_rotation.z, 0, 0, 1);
  _texture.bind();
  glBegin(GL_QUADS);

  glTexCoord2f(0.0f, 0.0f);
  glVertex3f(150.0f, 150.0f, -150.0f);
  glTexCoord2f(0.0f, 1.0f);
  glVertex3f(150.0f, -150.0f, -150.0f);
  glTexCoord2f(1.0f, 1.0f);
  glVertex3f(-150.0f, -150.0f, -150.0f);
  glTexCoord2f(1.0f, 0.0f);
  glVertex3f(-150.0f, 150.0f, -150.0f);

  if (_btype == Block::BLOCK || _btype == Block::WALL || _btype == Block::FIRE)
    {
      glTexCoord2f(0.0f, 0.0f);
      glVertex3f(-150.0f, 150.0f, 150.0f);
      glTexCoord2f(0.0f, 1.0f);
      glVertex3f(-150.0f, -150.0f, 150.0f);
      glTexCoord2f(1.0f, 1.0f);
      glVertex3f(150.0f, -150.0f, 150.0f);
      glTexCoord2f(1.0f, 0.0f);
      glVertex3f(150.0f, 150.0f, 150.0f);

      glTexCoord2f(0.0f, 0.0f);
      glVertex3f(-150.0f, 150.0f, -150.0f);
      glTexCoord2f(0.0f, 1.0f);
      glVertex3f(-150.0f, -150.0f, -150.0f);
      glTexCoord2f(1.0f, 1.0f);
      glVertex3f(-150.0f, -150.0f, 150.0f);
      glTexCoord2f(1.0f, 0.0f);
      glVertex3f(-150.0f, 150.0f, 150.0f);

      glTexCoord2f(0.0f, 0.0f);
      glVertex3f(150.0f, 150.0f, 150.0f);
      glTexCoord2f(0.0f, 1.0f);
      glVertex3f(150.0f, -150.0f, 150.0f);
      glTexCoord2f(1.0f, 1.0f);
      glVertex3f(150.0f, -150.0f, -150.0f);
      glTexCoord2f(1.0f, 0.0f);
      glVertex3f(150.0f, 150.0f, -150.0f);

      glTexCoord2f(0.0f, 0.0f);
      glVertex3f(150.0f, 150.0f, 150.0f);
      glTexCoord2f(0.0f, 1.0f);
      glVertex3f(-150.0f, 150.0f, 150.0f);
      glTexCoord2f(1.0f, 1.0f);
      glVertex3f(-150.0f, 150.0f, -150.0f);
      glTexCoord2f(1.0f, 0.0f);
      glVertex3f(150.0f, 150.0f, -150.0f);

      glTexCoord2f(0.0f, 0.0f);
      glVertex3f(150.0f, -150.0f, 150.0f);
      glTexCoord2f(0.0f, 1.0f);
      glVertex3f(-150.0f, -150.0f, 150.0f);
      glTexCoord2f(1.0f, 1.0f);
      glVertex3f(-150.0f, -150.0f, -150.0f);
      glTexCoord2f(1.0f, 0.0f);
      glVertex3f(150.0f, -150.0f, -150.0f);
    }

  glEnd();
  glPopMatrix();
}

float	 	Block::getXPos() const
{
  return (_position.x);
}

float	 	Block::getYPos() const
{
  return (_position.y);
}

float	 	Block::getZPos() const
{
  return (_position.z);
}

float	 	Block::getXRot() const
{
  return (_rotation.x);
}

float	 	Block::getYRot() const
{
  return (_rotation.y);
}

float	 	Block::getZRot() const
{
  return (_rotation.z);
}

float		Block::getTimer() const
{
  return (_timer);
}

AObject::e_otype	Block::getOType() const
{
  return (_otype);
}

void		Block::setPos(float x, float y, float z)
{
  _position.x = x;
  _position.y = y;
  _position.z = z;
}

void		Block::setRot(float x, float y, float z)
{
  _rotation.x = x;
  _rotation.y = y;
  _rotation.z = z;
}

void		Block::setType(e_btype t)
{
  _btype = t;
  if (t == Block::BLOCK)
    _texture = gdl::Image::load("assets/textures/block.png");
  else if (t == Block::WALL)
    _texture = gdl::Image::load("assets/textures/wall.png");
  else if (t == Block::EMPTY)
    _texture = gdl::Image::load("assets/textures/floor.png");
  else
    _texture = gdl::Image::load("assets/textures/fire.png");
}

void		Block::setTimer(float t)
{
  _timer = t;
}

bool		Block::isEmpty() const
{
  return (_btype == Block::EMPTY ? true : false);
}

bool		Block::isWall() const
{
  return (_btype == Block::WALL ? true : false);
}

bool		Block::isBlock() const
{
  return (_btype == Block::BLOCK ? true : false);
}

bool		Block::isOnFire() const
{
  return (_btype == Block::FIRE ? true : false);
}
