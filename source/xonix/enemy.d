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

        if (xpos == 1 || xpos >= mygrid.w-2) {
            xvel = -xvel;
        }

        if (ypos == 1 || ypos >= mygrid.h-2) {
            yvel = -yvel;
        }

        super.update();
    }

}