/**
 *
 */

module xonix.enemy;

import std.stdio;
import std.format;
import std.string;
import raylib;

import xonix.grid;
import xonix.mover;

const int Width = 800;
const int Height = 600;

class Enemy : Mover {

    this(int w, int h, Grid g) {
        super(w, h, g);
        codeChar = 'E';
    }

    override void update() {

        mygrid.set(ypos,xpos,lastStatus);

        xpos = xpos + xvel;
        if (mygrid.get(ypos,xpos) == 'C') {
            xpos = xpos - xvel;
            xvel = -xvel;
        }

        ypos = ypos + yvel;
        if (mygrid.get(ypos,xpos) == 'C') {
            ypos = ypos - yvel;
            yvel = -yvel;
        }

        // IMPLEMENTAR CRITERIO DE REBOTE CONTRA PARED

        lastStatus = mygrid.get(ypos,xpos);
        mygrid.set(ypos,xpos,codeChar);

        super.update();
    }

}