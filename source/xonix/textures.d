/**
 *
 */

module xonix.textures;

import std.stdio;
import std.format;
import std.string;
import raylib;

import xonix.grid;
import xonix.mover;
import xonix.enemy;

const int Width = 800;
const int Height = 600;

class GameTextures {

    Texture2D[char] gt;

    this(int stepw, int steph) {
        // generate images for cyan and black squares
        Image img;

        /* textura de los cuadrados que ya estan pintados */
        img = GenImageColor(stepw, steph, Colors.SKYBLUE);
        gt['C'] = LoadTextureFromImage(img); 

        /* textura de los cuadrados blank - los que no estan pintados */
        img = GenImageColor(stepw, steph, Colors.BLACK);
        gt['B'] = LoadTextureFromImage(img); 

        /* textura del jugador */
        img = GenImageColor(stepw, steph, Colors.RED);
        gt['P'] = LoadTextureFromImage(img); 

        /* textura del jugador cuando va pintando */
        img = GenImageColor(stepw, steph, Colors.PURPLE);
        gt['Q'] = LoadTextureFromImage(img); 

        /* textura de los enemigos */
        img = GenImageColor(stepw, steph, Colors.GREEN);
        gt['E'] = LoadTextureFromImage(img); 
    }

    Texture2D get(char code) {
        return gt[code];
    }

}