/**
 *
 *
 */
 
module xonix.grid;

import std.stdio;
import std.format;
import std.string;
import raylib;

const int Width = 800;
const int Height = 600;


class Grid {

    char[][] grid;
    int w;
    int h;
    int stepw;
    int steph;

    Image imgcyan;
    Image imgblack;
    Texture2D sqcyan;
    Texture2D sqblack;
    Texture2D sprite;

    this(int ww, int wh) {
        w = ww;
        h = wh;
        stepw = cast(int) (Width / w);
        steph = cast(int) (Height / h);

        for(int j=0; j<h; j++) {
            char[] row;
            for(int i=0; i<w; i++) {
                row = row ~ 'B';
            }
            grid = grid ~ row;
        }

        for(int j=0; j<h; j++) {
            grid[j][0] = 'C';
            grid[j][w-1] = 'C';
        }

        for(int i=0; i<w; i++) {
            grid[0][i] = 'C';
            grid[h-1][i] = 'C';
        }

        // generate images for cyan and black squares
        imgcyan = GenImageColor(stepw, steph, Colors.SKYBLUE);
        sqcyan = LoadTextureFromImage(imgcyan); 

        imgblack = GenImageColor(stepw, steph, Colors.BLACK);
        sqblack = LoadTextureFromImage(imgblack); 

        Image imgred = GenImageColor(stepw, steph, Colors.RED);
        sprite = LoadTextureFromImage(imgred); 

    }

    void draw() {
        for(int j=0; j<h; j++) {
            for(int i=0; i<w; i++) {
                // DrawText("B", stepw*i, steph*j, stepw, Colors.BLACK);
                if (grid[j][i] == 'B') {
                    DrawTexture(sqblack, i*stepw, j*steph, Colors.WHITE);
                } else if (grid[j][i] == 'C') {
                    DrawTexture(sqcyan, i*stepw, j*steph, Colors.WHITE);
                } else if (grid[j][i] == 'M') {
                    DrawTexture(sprite, i*stepw, j*steph, Colors.WHITE);
                }
            }
        }
    }

}