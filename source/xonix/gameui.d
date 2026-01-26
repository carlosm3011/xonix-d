/**
 * UI Screens
 *
 * Screens for when game starts, game ends, high score listing is presented
 */

module xonix.gameui;

import std.stdio;
import std.algorithm;
import std.array;
import std.conv;
import std.range;
import std.string;
import std.math;
import std.exception;

import raylib;
import xonix.grid;
import params;

//const int Width   = 800;
//const int Height  = 600;

class GameUIScreen {

    string caption;
    Color textColor;
    Texture2D t;
    Image img;
    int x;
    int y; 

    // static this(string text) {
    this(string text) {
        caption = text;
        this.textColor = Colors.WHITE;
        this.x = 100;
        this.y = 100;
        this.img = LoadImage("img/xonix-ascii.png");
        this.t = LoadTextureFromImage(img);
    }

    void draw() {
        uint w = roundTo!uint(Width*0.3);
        uint h = roundTo!uint(Height*0.5);

        DrawText(toStringz(caption), 30, 600-30, 60, textColor);

        DrawTexture(t, x, y, Colors.WHITE);
    }
}

// End gameui.d