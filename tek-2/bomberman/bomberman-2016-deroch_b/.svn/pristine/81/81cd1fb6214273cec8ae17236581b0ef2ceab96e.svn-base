#include "conteneurTextures.h"
#include <SDL/SDL.h>

ConteneurTextures::Textures ConteneurTextures::textures;

ConteneurTextures::Texture ConteneurTextures::ajouter(std::string nomFichier)
{
  Texture& texture = this->textures[nomFichier];
  
  if (0 == texture.compteur)
    {
      this->chargerTexture(nomFichier.c_str(), &texture.texture, &texture.largeur, &texture.hauteur);
    }
  texture.compteur++;
  return (texture);
}

void ConteneurTextures::supprimer(std::string nomFichier)
{
  Texture texture = this->textures[nomFichier];
  
  if (0 != texture.compteur)
    {
      texture.compteur--;
    }
  
  if (0 == texture.compteur)
    {
      glDeleteTextures(1, &texture.texture);
      this->textures.erase(nomFichier);
    }
}

ConteneurTextures::Texture ConteneurTextures::texture(std::string nomFichier)
{
  return this->textures[nomFichier];
}

void ConteneurTextures::chargerTexture(const char* nomFichier, GLuint* texture, sint32* largeur, sint32* hauteur)
{
  SDL_Surface *surface;
  GLenum formatTexture;
  GLint  octetsParPixel;
  
  surface = SDL_LoadBMP(nomFichier);
  
  if (NULL != surface)
    {
      if ( 0 != (surface->w & (surface->w - 1)) )
        {
	  printf("Attention : la largeur de %s n'est pas une puissance de 2\n ", nomFichier);
        }

      if ( 0 != (surface->h & (surface->h - 1)) )
        {
	  printf("Attention : la hauteur de %s n'est pas une puissance de 2\n ", nomFichier);
        }

      octetsParPixel = surface->format->BytesPerPixel;

      if (octetsParPixel == 4)
        {
	  if (surface->format->Rmask == 0x000000ff)
            {
	      formatTexture = GL_RGBA;
            }
	  else
            {
                #ifndef GL_BGRA
                #define GL_BGRA 0x80E1
                #endif
	        formatTexture = GL_BGRA;
            }
        }
      else if (octetsParPixel == 3)
        {
	  if (surface->format->Rmask == 0x000000ff)
            {
	      formatTexture = GL_RGB;
            }
	  else
            {
                #ifndef GL_BGR
                    #define GL_BGR 0x80E0
                #endif
                formatTexture = GL_BGR;
            }
	}
        else
	  {
	      printf("Attention : l'image n'est pas en couleur vraie\n");
          }

        glEnable(GL_TEXTURE_2D);

        glGenTextures(1, texture);

        glBindTexture(GL_TEXTURE_2D, *texture);

        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

        #ifndef GL_CLAMP_TO_EDGE
            #define GL_CLAMP_TO_EDGE (0x812F)
        #endif
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);

        gluBuild2DMipmaps(GL_TEXTURE_2D, octetsParPixel, surface->w, surface->h, formatTexture,GL_UNSIGNED_BYTE, surface->pixels);

        *largeur = surface->w;
        *hauteur = surface->h;
    }
    else
    {
        printf("SDL ne peut pas charger l'image %s : %s\n", nomFichier, SDL_GetError());
        *texture = 0;
        *largeur = 1;
        *hauteur = 1;
    }

    if (NULL != surface)
    {
        SDL_FreeSurface(surface);
    }
}
