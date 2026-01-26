/**
 *
 */

module xonix.enemy;

import std.stdio;
import std.format;
import std.string;
import std.random;
import raylib;

import xonix.grid;
import xonix.mover;

import params;

// const int Width = 800;
//const int Height = 600;

class Enemy : Mover {

    this(int w, int h, Grid g) {

        auto h1 = 0;
        auto w1 = 0;

        // si le paso -1 -1 entonces elijo una posicion que no este ocupada 

        if ( w == -1 && h == -1 ) {
            while (true) {
                w1 = uniform(3,GWidth-3, rnd);
                h1 = uniform(3,GHeight-3, rnd);
                if ( g.get(w1, h1) == 'B' ) {
                    break;
                } 
            }
        } else {
            w1 = w;
            h1 = h;
        }
        
        super(w1, h1, g);
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
        // IMPLEMENTA EL CHOQUE CON EL JUGADOR
        /**
        if (mygrid.get(xpos, ypos) == 'P' || mygrid.get(xpos, ypos) == 'Q') {
            // el jugador muere
            writeln(">>> JUGADOR MUERE EN ", xpos, " ", ypos);
            Lives = Lives - 1;
            CurrentGameScene = GameScene.DYING;
            return;
        }
        **/

        // IMPLEMENTAR CRITERIO DE REBOTE CONTRA PARED

        lastStatus = mygrid.get(ypos,xpos);
        mygrid.set(ypos,xpos,codeChar);

        super.update();
    }

}