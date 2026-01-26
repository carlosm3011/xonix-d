/**
 *
 */

module xonix.mover;

import std.stdio;
import std.format;
import std.string;
import raylib;
import xonix.grid;

// const int Width = 800;
// const int Height = 600;

class Mover {

    int xpos;
    int ypos;
    int yvel;
    int xvel;
    Grid mygrid;
    char lastStatus;
    char codeChar;

    this(int p_xpos, int p_ypos, Grid g) {
        xpos = p_xpos;
        ypos = p_ypos;
        xvel = 0;
        yvel = 0;
        mygrid = g;
        lastStatus = mygrid.grid[ypos][xpos];
        codeChar = 'M';
    }

    void update() {
        
    }

}
