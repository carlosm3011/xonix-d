/**
 *
 *
 */
 
import std.stdio;
import std.format;
import std.conv : to;
import std.string;
import raylib;

import xonix.grid;
import xonix.mover;
import xonix.enemy;

const string VERSION="0.1";
const string VERSION_NAME="One Night in Bangkok";	

const int Width = 800;
const int Height = 600;

void main()
{
	writefln("XONIX4 - a reincarnation of the classic 1981 game.");
	writefln("Version: %s, (%s)", VERSION, VERSION_NAME);

    // call this before using raylib
    validateRaylibBinding();
    InitWindow(Width, Height, toStringz(format("Xonix4 version %s (%s)", VERSION, VERSION_NAME)));
    SetTargetFPS(60);

	// clases del juego
	Grid mygrid = new Grid(80, 60);
	Mover m1    = new Mover(20, 20, mygrid);
	m1.xvel = 0;
	m1.yvel = 0;

	Enemy[] enemies;
	foreach(int n; 2..4) {
		Enemy e = new Enemy(10*n, 15*n, mygrid);
		e.xvel = 1;
		e.yvel = 1;
		enemies = enemies ~ e;
	}

    while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        DrawText("Hello, World!", 400, 300, 28, Colors.BLACK);
		int key;
		while ( (key = GetKeyPressed()) != 0 ) {
			if (key ==  KeyboardKey.KEY_DOWN) {
				m1.yvel = 1;
				m1.xvel = 0;
			}
			if (key ==  KeyboardKey.KEY_UP) {
				m1.yvel = -1;
				m1.xvel = 0;
			}
			if (key ==  KeyboardKey.KEY_LEFT) {
				m1.xvel = -1;
				m1.yvel = 0;
			}
			if (key ==  KeyboardKey.KEY_RIGHT) {
				m1.xvel = 1;
				m1.yvel = 0;
			}

		}
		m1.update();

		// Update enemies
		foreach(Enemy e; enemies ) {
			e.update();
		}

		mygrid.draw();
        EndDrawing();
    }
    CloseWindow();	
}
