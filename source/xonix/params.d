/**
 * Global parameters
 * 2026-01-24
 * carlos@xt6labs.io
 */

import std.random;

const string VERSION="0.4b1";
const string VERSION_NAME="En la terraza";	

const int Width   = 960;
const int Height  = 600;
const int GWidth  = 96;
const int GHeight = 60;
const int HeightOffset = 50;
enum GameScene {STARTING, PLAYING, DYING, NEWLEVEL, GAMEOVER};

auto rnd = Random(42);

GameScene CurrentGameScene = GameScene.STARTING;
const int MaxLives = 10;
int       Lives    = MaxLives;