/**
 * XONIX4 / Mi primer desarrollo serio en D.
 *
 */
 
import std.stdio;
import std.format;
import std.random;
import std.conv : to;
import std.string;
import raylib;

import xonix.params;
import xonix.grid;
import xonix.mover;
import xonix.enemy;
import xonix.player;
import xonix.gameui;

import xonix.gamesequence;

// auto rnd = Random(42);

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

	// Create Game
	GameSequence myGame = new GameSequence();
	myGame.XonixInitGame();


	// Starting screen
	GameUIScreen s = new GameUIScreen("Press any key to start");

	// init game
	// Score = 0;

    while (!WindowShouldClose())
    {
        BeginDrawing();

		if (CurrentGameScene == GameScene.STARTING) {
			XonixStartingFrame(s);
		}

		if (CurrentGameScene == GameScene.PLAYING) {
			myGame.XonixGameFrame();
		}

		if (CurrentGameScene == GameScene.DYING) {
			writeln(">> PLAYER DIED on ",myGame.m1.xpos, ",",myGame.m1.ypos," <<\n");
			CurrentGameScene = GameScene.PLAYING;
			myGame.XonixRebirth();
		}

        EndDrawing();
    }
    CloseWindow();	
}
