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

import xonix.gamesequence;
import xonix.gamestartscreen;
import xonix.gamedyingsequence;

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
	GameStartScreen myStartScreen = new GameStartScreen();

	// Game dyingsequence
	GameDyingSequence myDyingSequence = new GameDyingSequence(myGame);


    while (!WindowShouldClose())
    {
        BeginDrawing();

		if (CurrentGameScene == GameScene.STARTING) {
			myStartScreen.StartScreenFrame();
		}

		if (CurrentGameScene == GameScene.PLAYING) {
			myGame.XonixGameFrame();
		}

		if (CurrentGameScene == GameScene.DYING) {
			writeln(">> PLAYER DIED on ",myGame.m1.xpos, ",",myGame.m1.ypos," <<\n");
			// CurrentGameScene = GameScene.PLAYING;
			// myGame.XonixRebirth();
			myDyingSequence.draw();
		}

        EndDrawing();
    }
    CloseWindow();	
}
