int state = GameState.START;
int currentType = EnemysShowingType.STRAIGHT;
int enemyCount = 8;
Enemy[] enemys = new Enemy[enemyCount];
Fighter fighter;
Background bg;
FlameMgr flameMgr;
Treasure treasure;
HPBar hpBar;

int bulletCount = 5;
Bullet[] bullets = new Bullet[bulletCount];

boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;

int time;
int wait = 4000;



void setup () {
  size(640, 480);
  flameMgr = new FlameMgr();
  bg = new Background();
  treasure = new Treasure();
  hpBar = new HPBar();
  fighter = new Fighter(20);
}

void draw()
{
  if (state == GameState.START) {
    bg.draw();  
  }
  else if (state == GameState.PLAYING) {
    bg.draw();
    treasure.draw();
    flameMgr.draw();
    fighter.draw();

    //enemys
    if(millis() - time >= wait){
      addEnemy(currentType++);
      currentType = currentType%3;
    }    

    for (int i = 0; i < enemyCount; ++i) {
      if (enemys[i]!= null) {
        enemys[i].move();
        enemys[i].draw();
        if (enemys[i].isCollideWithFighter()) {
          fighter.hpValueChange(-20);
          flameMgr.addFlame(enemys[i].x, enemys[i].y);
          enemys[i]=null;
        }
        for(int j = 0;j<5;j++){
          if (bullets[j] != null && enemys[i] != null) {
            if (enemys[i].isCollideWithBullet(bullets[j])) {
              flameMgr.addFlame(enemys[i].x, enemys[i].y);
              bullets[j] = null;
              enemys[i] = null;
              }
            }
          }
       
      }
    }
     hpBar.updateWithFighterHP(fighter.hp);
     //bullets
    for(int i = 0;i<bulletCount;i++){
      if(bullets[i] != null){
        bullets[i].move();
        bullets[i].draw();
      }
    }
    
  }
  else if (state == GameState.END) {
    bg.draw();
  }
}
boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh)
{
  // Collision x-axis?
    boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
    // Collision y-axis?
    boolean collisionY = (ay + ah >= by) && (by + bh >= ay);
    return collisionX && collisionY;
}

void keyPressed(){
  switch(keyCode){
    case UP : isMovingUp = true ;break ;
    case DOWN : isMovingDown = true ; break ;
    case LEFT : isMovingLeft = true ; break ;
    case RIGHT : isMovingRight = true ; break ;
    default :break ;
  }
}
void keyReleased(){
  switch(keyCode){
  case UP : isMovingUp = false ;break ;
    case DOWN : isMovingDown = false ; break ;
    case LEFT : isMovingLeft = false ; break ;
    case RIGHT : isMovingRight = false ; break ;
    default :break ;
  }
  if (key == ' ') {
    if (state == GameState.PLAYING) {
    fighter.shoot();
  }
  }
 
}