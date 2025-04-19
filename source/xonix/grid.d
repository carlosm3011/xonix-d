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

    void floodFill(int xi, int yi) {
        writeln("%% Flood filling from ", xi, " , ",yi);
        char tmpFillChar = 'X';
        char defFillChar = 'C';
        char replChar    = 'B';

        if ( F == 0) {
            return;
        }

        // si en alguno de los vecinos tengo al enemigo, cancelo el relleno y me voy 
        // me encontre con el enemigo ! dejo de rellenar y me voy 
        if ( get(xi-1, yi-1) == 'E' ||
             get(xi  , yi-1) == 'E' ||
             get(xi+1, yi-1) == 'E' ||
             get(xi-1, yi)   == 'E' || 
             get(xi+1, yi)   == 'E' ||
             get(xi-1, yi+1) == 'E' ||
             get(xi  , yi+1) == 'E' ||
             get(xi+1, yi+1) == 'E') {
            writeln("%% Enemy found! Canceling flood fill at ", xi, " , ",yi);
            gridReplace(tmpFillChar, replChar);
            F = 0;
            // floodFill(-1, -1); // signal that the whole floodfill is unravelling
            return;
        }

        // reemplazo donde estoy parado
        if (get(xi,yi) == replChar) { 
            set(xi, yi, tmpFillChar);
        }

        // si tengo vecinos vacios sigo rellenando
        if (get(xi-1,yi-1) == replChar) {
            floodFill(xi-1, yi-1);
        }

        if (get(xi,yi-1) == replChar) {
            floodFill(xi, yi-1);
        }

        if (get(xi+1,yi-1) == replChar) {
            floodFill(xi+1, yi-1);
        }

        if (get(xi-1,yi+1) == replChar) {
            floodFill(xi-1, yi+1);
        }

        if (get(xi,yi+1) == replChar) {
            floodFill(xi, yi+1);
        }

        if (get(xi+1,yi+1) == replChar) {
            floodFill(xi+1, yi+1);
        }

        if (get(xi-1,yi) == replChar) {
            floodFill(xi-1, yi);
        }

        if (get(xi+1,yi) == replChar) {
            floodFill(xi+1, yi);
        }

        // si ya no tengo para donde seguir, confirmo el relleno y me voy 
        gridReplace(tmpFillChar, defFillChar);
        return;
    }
    // end flood fill

    /* Grid Stats */
    void gridStats() {

    }
    // end grid stats

}

// END CLASS Grid