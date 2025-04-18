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

}