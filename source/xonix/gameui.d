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

const int Width   = 800;
const int Height  = 600;

class GameUIScreen {

    string caption;
    Color textColor;

    this(string text) {
        caption = text;
        textColor = Colors.WHITE;
    }

    void draw() {
        uint w = roundTo!uint(Width*0.3);
        uint h = roundTo!uint(Height*0.5);
        DrawText(toStringz(caption), 200, 400, 60, textColor);   
    }
}

// End gameui.d