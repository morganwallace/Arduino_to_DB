/* Stronghold Game
 * 
 * Defend the castle from the enemies!
 * Use the 'A' button on your keyboard to shoot them.
 * The game is over when the castle is too damaged.
*/

PImage stronghold_bg;
PImage explosion;

Knight knight1;
Skeleton[] skeletons;
ArrayList<Arrow> arrows;
int arrownumber = 1;

float castleborder = 190;  // X coordinate of the wall of the castle
float castlehealth;        // Health of the castle
boolean gameOn;            // If false, game is over
float gamespeed = 1.0;
float walkingspeed = 0.2;
float monster_scale = 2.0; // Scaling factor when drawing the monsters 
int skeleton_number = 8;

void setup() {
  size(640, 480);
  background(0,0,0);
  frameRate(30);
  
  castlehealth = 100;
  gameOn = true;
  
  stronghold_bg = loadImage("../../Assets/stronghold_bg.png");
  explosion = loadImage("../../Assets/explosion.png");
  
  knight1 = new Knight(100, 100);
  
  // Create array of skeletons (with random speed)
  skeletons = new Skeleton[skeleton_number];
  for (int i = 0; i < skeletons.length; i++) {
    // Create skeletons. Parameters. x position, y position, speed, index
    skeletons[i] = new Skeleton(width, (i+1)*50+20, random(0.5, 1.5), i);
  }
  
  // Create array list (= array of variable length) of arrows
  arrows = new ArrayList<Arrow>(); 
}

void draw() {
  if(gameOn) {
    image(stronghold_bg, 0, 0);
    
    drawHealthBar(10, 10, castlehealth);
  
    knight1.display();  
       
    for (int i = 0; i < skeletons.length; i++) {
      skeletons[i].display();
      skeletons[i].move();
    }
    
    for (int i = arrows.size()-1; i >= 0; i--) {
      Arrow arrow = arrows.get(i);
      arrow.display();
      arrow.move();
      
      if(arrow.finished()) {
        arrows.remove(i);
      }
      
    }
    
    // Look for key presses
    if(keyPressed) {
      // Shoot arrow from player 1 if key 'A' is pressed
      if (key == 'a' || key == 'A') {
        knight1.shoot();
      }
    }
  
  }
  else{
    gameOver();
  }
}

// Draws the health bar
void drawHealthBar (int posx, int posy, float health) {
  fill(0,230,0,200);
  noStroke();
  rect(posx, posy, posx+health, posy+10);
}

// Called when game is over
void gameOver() { 
  // Draw background
  image(stronghold_bg, 0, 0);

  // Draw transparent black box over it
  fill(0, 0, 0, 200);
  noStroke();
  rect(0, 0, width, height);
}
