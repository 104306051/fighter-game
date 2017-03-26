class GameState
{
  static final int START = 0;
  static final int PLAYING = 1;
  static final int END = 2;
}
class Direction
{
  static final int LEFT = 0;
  static final int RIGHT = 1;
  static final int UP = 2;
  static final int DOWN = 3;
}
class EnemysShowingType
{
  static final int STRAIGHT = 0;
  static final int SLOPE = 1;
  static final int DIAMOND = 2;
}
class FlightType
{
  static final int FIGHTER = 0;
  static final int ENEMY = 1;
}
class Background{
  PImage start1;
  PImage start2;

  PImage bg1;
  PImage bg2;
  
  PImage end1;
  PImage end2;

  int playingBg1x = 0;
  int playingBg2x = -640;

  Background() {
    //since this won't change in the future
    this.bg1 = loadImage("img/bg1.png");
    this.bg2 = loadImage("img/bg2.png");

    this.start1 = loadImage("img/start1.png");
    this.start2 = loadImage("img/start2.png");

    this.end1 = loadImage("img/end1.png");
    this.end2 = loadImage("img/end2.png");
  }

  void draw()
  {
    if (state == GameState.START) {
      image(start2, 0, 0, 640, 480) ;
      //mouse action
    if ( mouseX > 205 && mouseX < 455 && mouseY < 417 && mouseY > 372) {
      image(start1, 0, 0, 640, 480) ;
      if ( mousePressed ) {
        //click
        state = GameState.PLAYING;
      }
    }
    }
    else if (state == GameState.PLAYING) {
      playingBg1x++;
      playingBg2x++;

      if (playingBg1x == 640) {
        playingBg1x = -640;
      }

      if (playingBg2x == 640) {
        playingBg2x = -640;
      }

      image(bg1, playingBg1x, 0);
      image(bg2, playingBg2x, 0);
    }
    else if (state == GameState.END) {
      image(end2, 0, 0, 640, 480);
    //mouse action
    if ( mouseX>208 && mouseX<433 && mouseY>310 && mouseY<345 ) {
      image(end1, 0, 0, 640, 480);
      if ( mousePressed ) {
        //click
        state = GameState.PLAYING;
        //restart
        enemys = new Enemy[enemyCount];
        currentType = EnemysShowingType.STRAIGHT;
        flameMgr = new FlameMgr();
        treasure = new Treasure();
        fighter = new Fighter(20);
      }
    }
    }
  }

}