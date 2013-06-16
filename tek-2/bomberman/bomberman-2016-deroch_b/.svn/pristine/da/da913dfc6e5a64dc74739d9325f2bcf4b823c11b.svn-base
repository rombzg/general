/*
** main.cpp for Bomberman in /home/benj/Projets/tek2/cpp/bomberman
** 
** Made by benjamin deroche
** Login   <deroch_b@epitech.net>
** 
** Started on  Mon Feb 11 12:38:07 2013 benjamin deroche
** Last update Sun Feb 23 19:25:42 2013 benjamin deroche
*/

#include	<iostream>
#include	"Bomberman.hh"

Bomberman::Bomberman()
{

}

Bomberman::Bomberman(float x, float y, float z) : AObject(x, y, z)
{

}

Bomberman::~Bomberman()
{
  // delete &this->model_;
}

void		Bomberman::initialize()
{
  _model = gdl::Model::load("assets/models/marvin.fbx");
  _model.cut_animation(_model, "Take 001", 40, 80, "Run");
  _nextpos.x = _position.x;
  _nextpos.y = _position.y;
  _nextpos.z = _position.z;
  _rotation.x = 90.0f;
  _otype = AObject::BOMBERMAN;
  // _model.set_anim_speed("Take 001", 1000.0f);
  _moving = NO;
  _inLife = true;
  // _moving = false;
}



void		Bomberman::update(gdl::GameClock const & gameClock, gdl::Input & input)
{
  float		dist;

  if (_map->isOnFirePos(_position.x, _position.y))
    {
      _inLife = false;
      _rotation.x = 0;
      _rotation.y = 0;
      _rotation.z = 90;
    }
  if (_inLife)
    {
      _model.update(gameClock);
      if (_nextpos != _position)
	{
	  if (_moveend < gameClock.getTotalGameTime())
	    {
	      _position.x = _nextpos.x;
	      _position.y = _nextpos.y;
	      _moving = NO;
	      _model.stop_animation("Run");
	      _model.play("Take 001");
	      _model.stop_animation("Take 001");
	    }
	  else
	    {
	      dist = gameClock.getTotalGameTime() - _movetmp;
	      _movetmp += dist;
	      dist *= 250.0f;
	      if ((int)_nextpos.x > (int)_position.x)
		_position.x += dist;
	      else if ((int)_nextpos.x < (int)_position.x)
		_position.x -= dist;
	      else if ((int)_nextpos.y > (int)_position.y)
		_position.y += dist;
	      else if ((int)_nextpos.y < (int)_position.y)
		_position.y -= dist;
	    }
	}
      else
	{
	  if (input.isKeyDown(_putbomb))
	    _mygame->addBombe(_position.x, _position.y);
	  if (input.isKeyDown(_right) && _map->isEmptyPos(_position.x + 300, _position.y))
	    {
	      _nextpos.x = _position.x + 300;
	      _rotation.y = 90.0f;
	    }
	  else if (input.isKeyDown(_left) && _map->isEmptyPos(_position.x - 300, _position.y))
	    {
	      _nextpos.x = _position.x - 300;
	      _rotation.y = 270.0f;
	    }
	  else if (input.isKeyDown(_up) && _map->isEmptyPos(_position.x, _position.y + 300))
	    {
	      _nextpos.y = _position.y + 300;
	      _rotation.y = 180.0f;
	    }
	  else if (input.isKeyDown(_down) && _map->isEmptyPos(_position.x, _position.y - 300))
	    {
	      _nextpos.y = _position.y - 300;
	      _rotation.y = 0.0f;
	    }
	  if (_nextpos != _position)
	    {
	      _model.play("Run");
	      _movetmp = gameClock.getTotalGameTime();
	      _moveend = _movetmp + 1.2f;
	    }
	}
    }
}

void		Bomberman::draw()
{
  glPushMatrix();
  glTranslatef(_position.x, _position.y, _position.z);
  glRotatef(_rotation.x, 1, 0, 0);
  glRotatef(_rotation.y, 0, 1, 0);
  glRotatef(_rotation.z, 0, 0, 1);
  _model.draw();
  glPopMatrix();
}

float	 	Bomberman::getXPos() const
{
  return (_position.x);
}

float	 	Bomberman::getYPos() const
{
  return (_position.y);
}

float	 	Bomberman::getZPos() const
{
  return (_position.z);
}

float	 	Bomberman::getXRot() const
{
  return (_rotation.x);
}

float	 	Bomberman::getYRot() const
{
  return (_rotation.y);
}

float	 	Bomberman::getZRot() const
{
  return (_rotation.z);
}

float		Bomberman::getTimer() const
{
  return (_timer);
}

AObject::e_otype	Bomberman::getOType() const
{
  return (_otype);
}

void		Bomberman::setPos(float x, float y, float z)
{
  _position.x = x;
  _position.y = y;
  _position.z = z;
}

void		Bomberman::setRot(float x, float y, float z)
{
  _rotation.x = x;
  _rotation.y = y;
  _rotation.z = z;
}

void		Bomberman::setMap(Map * map)
{
  _map = map;
}

void		Bomberman::setMyGame(MyGame * mygame)
{
  _mygame = mygame;
}

void		Bomberman::setPlayerNum(int num)
{

	    
  _playerNum = num;
  if (num == 1)
    {
      _up = gdl::Keys::Up;
      _down = gdl::Keys::Down;
      _right = gdl::Keys::Right;
      _left = gdl::Keys::Left;
      _putbomb = gdl::Keys::Numpad0;
      std::cout << "Player 1 controls : ^ < v > Numpad0" << std::endl;
    }
  else if (num == 2)
    {
      _up = gdl::Keys::Z;
      _down = gdl::Keys::S;
      _right = gdl::Keys::D;
      _left = gdl::Keys::Q;
      _putbomb = gdl::Keys::Space;
      std::cout << "Player 2 controls : Z Q S D Space" << std::endl;
    }
}
