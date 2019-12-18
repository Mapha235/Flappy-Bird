

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

  //flappy.show();
  
  //rect(width/6 - flappy.getRadius() - 5, 290 + (flappy.getRadius() / 2 - 5) , 20, 20);

  stripe.get(0).show();
  stripe.get(1).show();
  stripe.get(0).move(180.0);
  stripe.get(1).move(180.0);

  moving_ground(stripe);

  //println(frameRate);
  
  flappy.update();

  update(flappy, pipes);
  //moving_pipes(pipes); 
}

void update(Bird b, ArrayList<Pipe> ps){
  moving_pipes(ps);

  //handles Key Inputs
  if (keyPressed) {
    if (key == ' ') {
      flappy.flap();
    }
  }

  for (int i = 0; i < ps.size(); i++) {    
    ps.get(i).show();

    if(ps.get(i).getCanMove())
    //move updates the speed after every frame which depends on the current framerate
      ps.get(i).move(180.0);
    
    if(collisionDetection(ps.get(i), b)) {
      //println("Collision detected");      
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

void moving_ground(ArrayList<Stripe> st){
  if(st.get(index).getX() + st.get(index).getWidth() <= 0){
    st.get(index).setX(width + 26);
    
    index = (index + 1) % 2;
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



