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

import params;
import xonix.grid;
import xonix.mover;
import xonix.enemy;
import xonix.player;
import xonix.gameui;

// auto rnd = Random(42);

// Estado del juego

Grid mygrid;
Player m1;
Enemy[] enemies;
int nEnemies = 2;
int Score;
int Level = 1;

// GameScene CurrentGameScene = GameScene.STARTING;

void XonixStartingFrame(GameUIScreen s) {
	s.textColor = Colors.BLUE;
	s.draw();
	if (s.y <300) {
		s.y = s.y + 10;
	} else {
		s.y = 100;
		ClearBackground(Colors.BLACK);
	}

	if (GetKeyPressed() != 0) {
		CurrentGameScene = GameScene.PLAYING;
	}

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

void XonixRebirth() {
	m1 			= new Player(40, 0, mygrid);
	m1.xvel 	= 0;
	m1.yvel		= 0;
	// mygrid.gridReplace('Q', 'B');
	// mygrid.gridReplace('E', 'B');
	mygrid.gridReset();
	Lives = Lives - 1;

	writeln(">> Rebirth with nEnemies = ", nEnemies);
	writeln(">> Rebirth with pct      = ", mygrid.pct);
	enemies = [];
	foreach(int n; 2..(nEnemies+2) ) {
		//auto startx = uniform(3,GWidth-3, rnd);
		//auto starty = uniform(3,GHeight-3, rnd);
		//Enemy e = new Enemy(startx, starty, mygrid);
		Enemy e = new Enemy(-1, -1, mygrid);
		e.xvel = [1, -1].choice(rnd);
		e.yvel = [1, -1].choice(rnd);
		enemies = enemies ~ e;
		writeln(">>Rebirth with enemy at ", e.xpos, ",", e.ypos);
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
		DrawText(TextFormat("Pos: (%03i, %03i) - Covered: %02i %% - Level %02i - Score %05i - Lives %02i", 
			m1.xpos, m1.ypos, mygrid.pct, Level, Score, Lives), 10, Height, 26, Colors.WHITE);

		if (mygrid.pct >= 75) {
			nEnemies++;
			Level++;
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

	// Starting screen
	auto s = new GameUIScreen("Press any key to start");

	// init game
	Score = 0;
	XonixInitGame();

    while (!WindowShouldClose())
    {
        BeginDrawing();

		if (CurrentGameScene == GameScene.STARTING) {
			XonixStartingFrame(s);
		}

		if (CurrentGameScene == GameScene.PLAYING) {
			XonixGameFrame();
		}

		if (CurrentGameScene == GameScene.DYING) {
			writeln(">> PLAYER DIED on ",m1.xpos, ",",m1.ypos," <<\n");
			CurrentGameScene = GameScene.PLAYING;
			XonixRebirth();
		}

        EndDrawing();
    }
    CloseWindow();	
}
