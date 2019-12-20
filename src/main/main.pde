

/*TODO:

  - fix collisionDetection (Area of Bird)

  - fix low frameRate(10) moving pipes

  - make start menu

  - make a MovingWorld class
 */

import processing.sound.*;

//indices used for moving_pipes function
int next = 0;
int mostLeft = 0;

//index used for moving_ground function
int index = 0;

Bird flappy;
Pipe pipe;
ArrayList<Pipe> pipes;
SoundFile soundfile;
Button button;
PImage bg;
static int score;
static float groundPos;
ArrayList<Stripe> stripe;

float global_speed = 180.0;
boolean isDead = false;


void setup() {
  size(640, 980);
  frameRate(60);

  groundPos = 190;

  
  pipes = new ArrayList<Pipe>();
  pipes.add(new Pipe(width / 1.25, random(200 + 40, height - 40 - groundPos), width / 10));
  pipes.add(new Pipe(width + 3, random(200 + 40, height - 40 - groundPos), width/10));
  pipes.add(new Pipe(width + 3, random(200 + 40, height - 40 - groundPos), width/10));

  stripe = new ArrayList<Stripe>();
  stripe.add(new Stripe(0, 794));
  stripe.add(new Stripe(width + 30, 794));


  pipes.get(0).setCanMove(true);

  flappy = new Bird(width/6, height/2 - groundPos);  
  bg = loadImage("background-night.png"); 
}

void draw() {
  background(bg);   

  //if(!isDead){
    stripe.get(0).update();
    stripe.get(0).move(global_speed);
    stripe.get(1).update();
    stripe.get(1).move(global_speed);

    //println(frameRate);

    if(flappy.getY() < height - groundPos - flappy.getRadius() && flappy.getY() >= 0)
      flappy.update(); 

    update(flappy, pipes);
  //}
}

void keyPressed(){
  if(key == ' ')
    flappy.flap();
}

void update(Bird b, ArrayList<Pipe> ps){
  moving_pipes(ps);

  for (int i = 0; i < ps.size(); i++) {    
    ps.get(i).show();

    if(ps.get(i).getCanMove())
    //move updates the speed after every frame which depends on the current framerate
      ps.get(i).move(global_speed);
    
    if(isDead = collisionDetection(ps.get(i), b)) {
      //println("Collision detected");  
      isDead = true;    
      for(int j = 0; j < ps.size(); j++)
        ps.get(j).setCanMove(false);
    }
  } 

}

void moving_pipes(ArrayList<Pipe> ps){
  //
  if(ps.get(mostLeft).getX() + ps.get(mostLeft).getWidth() <= 0){
    ps.get(mostLeft).setCanMove(false);
    ps.get(mostLeft).setX(width + 3);
    ps.get(mostLeft).setHeight(random(200 + 40, height - 40 - groundPos));
    mostLeft = (mostLeft + 1) % 3;       
  }

  if(ps.get(next).getX() < width/2 + 5 && ps.get(next).getX() > width/2 - 5){
    next = (next + 1) % 3;
    ps.get(next).setCanMove(true);
  }
}

boolean collisionDetection(Pipe p, Bird b) {

  if ((b.getY() + b.getRadius()) >= p.getY() ||              //condition for collision with bottom pipe => constraint on y-axis
      (b.getY() - b.getRadius()) <= (p.getY() - p.getGap())) //condition for collision with top pipe    => constraint on y-axis
  {
    if (b.getX() + b.getRadius() >= p.getX() && //constraint on x-axis
        b.getX() <= (p.getX() + p.getWidth()))
      return true;
  } 
  return false;
}



