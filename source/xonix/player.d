/**
 * Player character
 */

module xonix.player;

import std.stdio;
import std.format;
import std.string;
import raylib;
import xonix.grid;
import xonix.mover;

const int Width = 800;
const int Height = 600;

class Player : Mover {

    // char codeChar1;
    char estado;

    this(int w, int h, Grid g) {
        super(w, h, g);
        codeChar  = 'P';
        estado    = 'P';
    }

    override void update() {
        // mygrid.grid[ypos][xpos] = lastStatus;

        if (estado == 'P') {
            codeChar = 'P';
            mygrid.grid[ypos][xpos] = lastStatus;

            int last_xpos = xpos;
            xpos = xpos + xvel;
            if (xpos <= 0 ) {
                xvel = 0;
                //yvel = 0;
                xpos = 0;
            }

            if (xpos >= mygrid.w-1) {
                xvel = 0;
                //yvel = 0;
                xpos = mygrid.w-1;
            }

            if (mygrid.grid[ypos][xpos] == 'C') {
                // xpos = last_xpos;
            } else {
                estado = 'Q';
            }

            int last_ypos = ypos;
            ypos = ypos + yvel;
            if (ypos <= 0)  {
                // xvel = 0;
                yvel = 0;
                ypos = 0;
            }

            if ( ypos >= mygrid.h-1) {
                // xvel = 0;
                yvel = 0;
                ypos = mygrid.h-1;
            }

            if (mygrid.grid[ypos][xpos] == 'C') {
                // ypos = last_ypos;
            } else {
                estado = 'Q';
                codeChar = 'Q';
            }

            lastStatus = mygrid.grid[ypos][xpos];
            mygrid.grid[ypos][xpos] = codeChar;

            return;
        }

        if (estado == 'Q') {
            codeChar = 'Q';

            xpos = xpos + xvel;
            ypos = ypos + yvel;
            if (mygrid.grid[ypos][xpos] == 'C') {
                estado = 'P';
                xvel = 0;
                yvel = 0;
                mygrid.gridReplace('Q', 'C');

                // hay que llamar al flood fill !!
                int xvec = 0;
                int yvec = 0;
                // 1. buscar un vecino que este en "B"
                if (mygrid.get(xpos+1,ypos+1) == 'B') {
                    xvec = xpos + 1;
                    yvec = ypos + 1;
                } else if (mygrid.get(xpos+1,ypos) == 'B')  {
                    xvec = xpos + 1;
                    yvec = ypos;
                } else if (mygrid.get(xpos,ypos-1) == 'B') {
                    xvec = xpos;
                    yvec = ypos-1;
                } else if (mygrid.get(xpos,ypos+1) == 'B') {
                    xvec = xpos;
                    yvec = ypos+1;
                } else if (mygrid.get(xpos-1,ypos-1) == 'B') {
                    xvec = xpos - 1;
                    yvec = ypos - 1;
                } else if (mygrid.get(xpos-1,ypos) == 'B') {
                    xvec = xpos - 1;
                    yvec = ypos;
                } else if (mygrid.get(xpos-1,ypos-1) == 'B') {
                    xvec = xpos - 1;
                    yvec = ypos - 1;
                } else if (mygrid.get(xpos,ypos-1) == 'B') {
                    xvec = xpos;
                    yvec = ypos - 1;
                } 

                // 2. invocar el flood fill con ese vecino
                mygrid.F = 1;
                mygrid.floodFill(xvec, yvec);
            } else {
            }

            lastStatus = mygrid.grid[ypos][xpos];
            mygrid.grid[ypos][xpos] = codeChar;
            return;
        }

    }

}