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
import xonix.player;

const string VERSION="0.2";
const string VERSION_NAME="Mediodia en el Timote";	

const int Width = 800;
const int Height = 600;
const int HeightOffset = 50;

// Estado del juego

Grid mygrid;
Player m1;
Enemy[] enemies;
int Score;

// inicializo el juego
void XonixInitGame() {
	// clases del juego
	mygrid  = new Grid(80, 60);
	m1      = new Player(0, 20, mygrid);
	m1.xvel = 0;
	m1.yvel = 0;

	enemies = [];
	foreach(int n; 2..4) {
		Enemy e = new Enemy(10*n, 15*n, mygrid);
		e.xvel = 1;
		e.yvel = 1;
		enemies = enemies ~ e;
	}

}

void main()
{
	writefln("XONIX4 - a reincarnation of the classic 1981 game.");
	writefln("Version: %s, (%s)", VERSION, VERSION_NAME);

    // call this before using raylib
    validateRaylibBinding();
    InitWindow(Width, Height+HeightOffset, toStringz(format("Xonix4 version %s (%s)", VERSION, VERSION_NAME)));
    SetTargetFPS(30);

	// init game
	Score = 0;
	XonixInitGame();

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

		// show stats
		int laspct = mygrid.pct;
		mygrid.gridStats();
		Score = Score + (mygrid.pct-laspct)*5	;
		DrawText(TextFormat("Painted surface: %02i %% - Score %04i", mygrid.pct, Score), 10, Height, 30, Colors.WHITE);

		if (mygrid.pct >= 75) {
			XonixInitGame();
		}

        EndDrawing();
    }
    CloseWindow();	
}
