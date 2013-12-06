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
float gamespeed = 2.0;
float walkingspeed = 0.2; 
int skeleton_number = 8;

// Screen setup
float screen_scale = 1.5;
float character_scale = 3.0; // Scaling factor when drawing the characters
int screenwidth = round(640*screen_scale);
int screenheight = round(480*screen_scale);

// Positioning of monsters
int y_start_position;
int y_start_upper = round(80*screen_scale);
int y_start_lower = round(screenheight - 20*character_scale);

// Game setup, runs once on launc
void setup() {
  // Basic screen setup
  size(screenwidth, screenheight);
  background(0,0,0);
  frameRate(30);
  
  castlehealth = 100;
  gameOn = true;

  // Load and resize background image  
  stronghold_bg = loadImage("../../Assets/stronghold_bg.png");
  stronghold_bg.resize(round(stronghold_bg.width*screen_scale),round(stronghold_bg.height*screen_scale));
  
  // Load and resize explosion image
  explosion = loadImage("../../Assets/explosion.png");
  explosion.resize(round(explosion.width*character_scale),round(explosion.height*character_scale));

  
  knight1 = new Knight(100, 100);
  
  println(y_start_upper);
  println(y_start_lower);
  
  // Create array of skeletons (with random speed)
  skeletons = new Skeleton[skeleton_number];
  for (int i = 0; i < skeletons.length; i++) {
    // Set start positions for skeletons
    y_start_position = y_start_upper + i * ( (y_start_lower - y_start_upper) / skeleton_number );   
    // Create skeletons. Parameters. x position, y position, speed, index
    skeletons[i] = new Skeleton(width, y_start_position , random(0.5, 1.5), i);
  }
  
  // Create array list (= array of variable length) of arrows
  arrows = new ArrayList<Arrow>(); 
}


// Contains main game logic
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
