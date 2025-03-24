/**
 *
 */

module xonix.mover;

import std.stdio;
import std.format;
import std.string;
import raylib;
import xonix.grid;

const int Width = 800;
const int Height = 600;

class Mover {

    int xpos;
    int ypos;
    int yvel;
    int xvel;
    Grid mygrid;
    char lastStatus;

    this(int p_xpos, int p_ypos, Grid g) {
        xpos = p_xpos;
        ypos = p_ypos;
        xvel = 0;
        yvel = 0;
        mygrid = g;
        lastStatus = mygrid.grid[ypos][xpos];
    }

    void update() {
        mygrid.grid[ypos][xpos] = lastStatus;

        xpos = xpos + xvel;
        if (xpos <= 0 ) {
            xvel = 0;
            yvel = 0;
            xpos = 0;
        }

        if (xpos >= mygrid.w-1) {
            xvel = 0;
            yvel = 0;
            xpos = mygrid.w-1;
        }        

        ypos = ypos + yvel;
        if (ypos <= 0)  {
            xvel = 0;
            yvel = 0;
            ypos = 0;
        }

        if ( ypos >= mygrid.h-1) {
            xvel = 0;
            yvel = 0;
            ypos = mygrid.h-1;
        }

        lastStatus = mygrid.grid[ypos][xpos];
        mygrid.grid[ypos][xpos] = 'M';
    }

}
