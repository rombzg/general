#include "menu.h"
#include "conteneurTextures.h"
#include <GL/gl.h>
#include <GL/glu.h>
#include <SDL/SDL.h>
#include "configuration.h"

Menu::Menu(std::string imageFond)
{
    this->imageFond = imageFond;
    this->conteneurTextures.ajouter(this->imageFond);
}

Menu::~Menu()
{
    this->conteneurTextures.supprimer(this->imageFond);
}

void Menu::dessiner(void)
{
    glLoadIdentity();
    glMatrixMode(GL_PROJECTION);

    gluOrtho2D(0.0, (GLdouble)LARGEUR_FENETRE, 0.0, (GLdouble)HAUTEUR_FENETRE);

    glDisable(GL_DEPTH_TEST);

    glClear(GL_COLOR_BUFFER_BIT);

    this->dessinerFond();

    this->dessinerBoutons();

    glFlush();
    SDL_GL_SwapBuffers();

}

void Menu::dessinerFond(void)
{
    glBindTexture(GL_TEXTURE_2D, this->conteneurTextures.texture(this->imageFond).texture);

    glBegin(GL_QUADS);
        glTexCoord2d(0, 0); glVertex2f(0, HAUTEUR_FENETRE);
        glTexCoord2d(0, 1); glVertex2f(0, 0);
        glTexCoord2d(1, 1); glVertex2f(LARGEUR_FENETRE, 0);
        glTexCoord2d(1, 0); glVertex2f(LARGEUR_FENETRE, HAUTEUR_FENETRE);
    glEnd();
}

void Menu::dessinerBoutons(void)
{

}
