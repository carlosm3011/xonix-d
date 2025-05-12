/**
 *
 *
 */
 
import std.stdio;
import std.format;
import std.random;
import std.conv : to;
import std.string;
import raylib;

import xonix.grid;
import xonix.mover;
import xonix.enemy;
import xonix.player;

const string VERSION="0.3";
const string VERSION_NAME="Duro de la Espalda";	

const int Width   = 800;
const int Height  = 600;
const int GWidth  = 80;
const int GHeight = 60;
const int HeightOffset = 50;

auto rnd = Random(43);

// Estado del juego

Grid mygrid;
Player m1;
Enemy[] enemies;
int nEnemies = 2;
int Score;

enum GameScene {STARTING, PLAYING, DYING, NEWLEVEL, GAMEOVER};

GameScene CurrentGameScene = GameScene.PLAYING;

/** starting **/
void XonixStartingScene() {
	// SceneStart = GetTime();
}

// inicializo el juego
void XonixInitGame() {
	// clases del juego
	mygrid  = new Grid(GWidth, GHeight);
	m1      = new Player(40, 0, mygrid);
	m1.xvel = 0;
	m1.yvel = 0;

	enemies = [];
	foreach(int n; 2..(nEnemies+2) ) {
		auto startx = uniform(3,GWidth-3, rnd);
		auto starty = uniform(3,GHeight-3, rnd);
		// Enemy e = new Enemy(10*n, 15*n, mygrid);
		Enemy e = new Enemy(startx, starty, mygrid);
		e.xvel = [1, -1].choice(rnd);
		e.yvel = [1, -1].choice(rnd);
		enemies = enemies ~ e;
	}

}

// 1 frame cycle of the Xonix Game
void XonixGameFrame() {
        ClearBackground(Colors.BLACK);
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
			nEnemies++;
			XonixInitGame();
		}
}

/**
 * MAIN FUNCTION
 */
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

		if (CurrentGameScene == GameScene.PLAYING) {
			XonixGameFrame();
		}

        EndDrawing();
    }
    CloseWindow();	
}
