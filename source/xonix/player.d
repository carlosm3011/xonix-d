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

import params;

//const int Width = 800;
//const int Height = 600;

class Player : Mover {

    // char codeChar1;
    char estado;
    // candidate for filling
    int xfillcand;
    int yfillcand;
    string tfillcand;

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
                codeChar = 'Q';
                estado = 'Q';
                xfillcand = -1;
                yfillcand = -1;
                tfillcand = "NONE";
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
                xfillcand = -1;
                yfillcand = -1;
                tfillcand = "NONE";
            }

            lastStatus = mygrid.grid[ypos][xpos];
            mygrid.grid[ypos][xpos] = codeChar;

            return;
        }

        // en este estado es cuando voy tratando de pintar
        // nuevas regiones
        if (estado == 'Q') {
            codeChar = 'Q';

            // chequear si identificamos un punto candidato en el camino
            // es decir uno que tenga blank N y S o W y E

            // chequeo si W y E estan libres
            if ( mygrid.get(xpos-1, ypos) == 'B' && mygrid.get(xpos+1, ypos) == 'B') {
                // W y E libres, actualizo candidato
                xfillcand = xpos;
                yfillcand = ypos;
                tfillcand = "WE";
            }

            // chequeo si N y S estan libres
            if ( mygrid.get(xpos, ypos-1) == 'B' && mygrid.get(xpos, ypos+1) == 'B') {
                // W y E libres, actualizo candidato
                xfillcand = xpos;
                yfillcand = ypos;
                tfillcand = "NS";
            }

            xpos = xpos + xvel;
            ypos = ypos + yvel;

            if (mygrid.grid[ypos][xpos] == 'C') {
                estado = 'P';
                xvel = 0;
                yvel = 0;
                mygrid.gridReplace('Q', 'C');

                // // hay que llamar al flood fill !!
                // 1. 
                if (tfillcand == "WE") {
                    mygrid.F = 1;
                    mygrid.floodFill2(xfillcand-1, yfillcand);
                    mygrid.gridReplace('X', 'C');

                    mygrid.F = 1;
                    mygrid.floodFill2(xfillcand+1, yfillcand);
                    mygrid.gridReplace('X', 'C');
                } else if (tfillcand == "NS") {
                    mygrid.F = 1;
                    mygrid.floodFill2(xfillcand, yfillcand-1);
                    mygrid.gridReplace('X', 'C');

                    mygrid.F = 1;
                    mygrid.floodFill2(xfillcand, yfillcand+1);
                    mygrid.gridReplace('X', 'C');
                }

            } else {
            }

            lastStatus = mygrid.grid[ypos][xpos];
            mygrid.grid[ypos][xpos] = codeChar;
            return;
        }

    }

}