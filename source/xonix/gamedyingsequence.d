/**
 * Dying sequence
 */

module xonix.gamedyingsequence;

import std.stdio;
import xonix.params;
import xonix.gamesequence;

class GameDyingSequence {

    int frame;
    GameSequence myGame;

    this(GameSequence mg) {
        frame = 0;        
        writeln("PLAYER DYING SEQUENCE");
        myGame = mg;
    }

    void draw() {
        frame++;
        if (frame>=5) {
            CurrentGameScene = GameScene.PLAYING;
            frame = 0;
            myGame.XonixRebirth();
        }
    }
}