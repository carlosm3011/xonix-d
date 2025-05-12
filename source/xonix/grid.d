/**
 *
 *
 */
 
module xonix.grid;

import std.stdio;
import std.format;
import std.string;
import raylib;
import xonix.textures;

const int Width = 800;
const int Height = 600;

class Grid {

    char[][] grid;
    int w;
    int h;
    int stepw;
    int steph;

    // grid stats
    int blanks;
    int cyans;
    int total;
    int pct;

    // this class wide variable is the variable that 
    // controls when we are cancelling a fill
    int F;

    GameTextures gt;

    this(int ww, int wh) {
        w = ww;
        h = wh;
        stepw = cast(int) (Width / w);
        steph = cast(int) (Height / h);
        gt = new GameTextures(stepw, steph);


        for(int j=0; j<h; j++) {
            char[] row;
            for(int i=0; i<w; i++) {
                row = row ~ 'B';
            }
            grid = grid ~ row;
        }

        /* relleno los bordes laterales */
        for(int j=0; j<h; j++) {
            grid[j][0] = 'C';
            grid[j][w-1] = 'C';
        }

        /* relleno los bordes superior e inferior */
        for(int i=0; i<w; i++) {
            grid[0][i] = 'C';
            grid[h-1][i] = 'C';
        }

        /* hago un feature en el medio */
        for(int j=0; j < h/2 ; j++) {
            grid[j][15] = 'C';
            grid[j][34] = 'C';
            grid[j][35] = 'C';
        }        
    }

    /* devuelve el valor de la celda (x,y) de forma segura */
    char get(int x, int y) {
        char rerror = 'X';

        if ( x<0 || x>w-1 ) {
            return rerror;
        }

        if (y<0 || y>h-1) {
            return rerror;
        }

        return grid[y][x];
    }
    // end get

    void set(int x, int y, char c) {
        if ( x<0 || x>w-1 ) {
            return;
        }

        if (y<0 || y>h-1) {
            return;
        }

        grid[y][x] = c;
        return;
    }
    // end set

    void draw() {
        for(int j=0; j<h; j++) {
            for(int i=0; i<w; i++) {
                // DrawText("B", stepw*i, steph*j, stepw, Colors.BLACK);
                if (grid[j][i] == 'B') {
                    DrawTexture(gt.get('B'), i*stepw, j*steph, Colors.WHITE);
                } else if (grid[j][i] == 'C') {
                    DrawTexture(gt.get('C'), i*stepw, j*steph, Colors.WHITE);
                } else if (grid[j][i] == 'P') {
                    DrawTexture(gt.get('P'), i*stepw, j*steph, Colors.WHITE);
                } else if (grid[j][i] == 'E') {
                    DrawTexture(gt.get('E'), i*stepw, j*steph, Colors.WHITE);
                } else if (grid[j][i] == 'Q') {
                    DrawTexture(gt.get('Q'), i*stepw, j*steph, Colors.WHITE);
                }
            }
        }
    }
    // end draw

    /* Reemplazar un code por otro en toda la grilla */
    void gridReplace(char org_c, char new_c) {
        for( int j=0; j<h; j++) {
            for( int i=0; i<w; i++) {
                if (grid[j][i] == org_c) {
                    grid[j][i] = new_c;
                }
            }
        }
    }
    // end gridReplace

    void floodFill2(int xi, int yi) {
        writeln("%% Floodfilling2 from ", xi, " , ",yi);
        char tmpFillChar = 'X';
        char defFillChar = 'C';
        char replChar    = 'B';


        // casos base = fuera de la pantalla
        if (xi<0 || xi>w) {
            return;
        }

        if (yi<0 || yi>h) {
            return;
        }

        // casos base = vengo saliendo de la recursion
        if (F == 0) {
            return;
        }

        // casos base = ya esta pintado con el color definitivo
        if (get(xi,yi) == defFillChar || get(xi, yi) == tmpFillChar ) {
            return;
        }

        // casos base = ya me encontre con el enemigo !
        if (get(xi, yi) == 'E') {
            F = 0;
            writeln("%% Enemy found! Canceling flood fill at ", xi, " , ",yi);
            gridReplace(tmpFillChar, replChar);
            return;
        }

        set(xi, yi, tmpFillChar);

        floodFill2(xi, yi-1); // north
        floodFill2(xi, yi+1); // south
        floodFill2(xi-1, yi); // west
        floodFill2(xi+1, yi); // east

    } // end floodfill2

    /* Grid Stats */
    void gridStats() {
        blanks = 0;
        cyans  = 0;
        total  = 0;
        for (int j=0; j<h; j++ ) {
            for (int i=0; i<w; i++) {
                total++;
                if (grid[j][i] == 'B') {
                    blanks++;
                } else if (grid[j][i] == 'C') {
                    cyans++;
                }
            }
        }

        pct = (cyans*100/total);

    }
    // end grid stats

}

// END CLASS Grid