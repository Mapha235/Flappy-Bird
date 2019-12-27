import java.util.Map;
import java.util.Collections;
import org.javatuples.Pair;

//indices used for movingPipes function
int next = 0;
int mostLeft = 0;

//index used for moving_ground function
int index = 0;

float global_speed = 180.0;
float actual_speed = global_speed / frameRate;
boolean gameOver = false;
static int score = 0;
final float groundHeight = 190;


Bird flappy;

Pipe pipe;
ArrayList<Pipe> pipes;
ArrayList<Stripe> stripe;
Button button;
PImage bg;

void setup() {
  smooth(8);
  size(640, 980);
  frameRate(60);

  flappy = new Bird(width / 6, height/2 - groundHeight);  

  pipes = new ArrayList<Pipe>();
  pipes.add(new Pipe(width / 1.25, random(200 + 40, height - 40 - groundHeight), width / 10));
  pipes.add(new Pipe(width + 3, random(200 + 40, height - 40 - groundHeight), width/10));
  pipes.add(new Pipe(width + 3, random(200 + 40, height - 40 - groundHeight), width/10));

  stripe = new ArrayList<Stripe>();
  stripe.add(new Stripe(0, 794));
  stripe.add(new Stripe(width + 30, 794));

  pipes.get(0).setCanMove(true);


  bg = loadImage("background-night.png"); 
}

void draw() {
  
  background(bg);  

  for(int i = 0; i < 2; ++i) {
    stripe.get(i).update();
    stripe.get(i).move(global_speed);
  }

  if(flappy.getY() < height - groundHeight && flappy.getY() >= 0)
    flappy.update(); 
  
  updatePipes(pipes); 

  incrementScore(pipes.get(mostLeft), flappy);

  if(!gameOver && collisionDetection(pipes.get(mostLeft), flappy)) {
    global_speed = 0; 
    gameOver = true;
  }
}

void keyPressed(){
  if(!gameOver){ // disables all key inputs once game over occurs
    if(key == ' ')
      flappy.flap();
  }
}

void updatePipes(ArrayList<Pipe> ps){
  movingPipes(ps);

  for (int i = 0; i < ps.size(); i++) {    
    ps.get(i).show();

    if(ps.get(i).getCanMove())
      ps.get(i).move(global_speed);
  } 

}

void movingPipes(ArrayList<Pipe> ps){
  if(ps.get(mostLeft).getX() + ps.get(mostLeft).getWidth() <= 0){
    ps.get(mostLeft).setCanMove(false);
    ps.get(mostLeft).setX(width + 3);
    ps.get(mostLeft).setHeight(random(200 + 40, height - 40 - groundHeight));
    mostLeft = (mostLeft + 1) % 3;       
  }
  //  Pair<Float, PVector> closest_edge = closestEdge(ps.get(mostLeft), flappy);
  //  line(flappy.getX(), flappy.getY(), closest_edge.getValue1().x, closest_edge.getValue1().y);

  if(ps.get(next).getX() < width/2 + 5 && ps.get(next).getX() > width/2 - 5){
    next = (next + 1) % 3;
    ps.get(next).setCanMove(true);
  }
}

boolean collisionDetection(Pipe p, Bird b){
  PVector center_of_bird = new PVector(b.getX(), b.getY());
  float closest_edge = closestEdge(p, b);
 
  if(b.getX() + b.getRadius() >= p.getX() && b.getX() - b.getRadius() <= p.getX() + p.getWidth()){
    if(closest_edge <= b.getRadius() ||
      b.getY() - b.getRadius() <= p.getY() - p.getGap()||
      b.getY() + b.getRadius() >= p.getY())
      return true;
      
  }
  else if(b.getY() + b.getRadius() >= height - groundHeight ||
          b.getY() - b.getRadius() <= 0)
    return true;
          
  return false;
}

/* 
* This function determines the closest Edge of the closest incoming pipe and calculates the distance between
* the edge and the center of the bird.
* The distance is mainly used for collision detection.
* @return distance from the bird's center to the closest edge of the closest pipe
* @param p the closest pipe
* @param b the player/bird
*/
Float closestEdge(Pipe p, Bird b){  
  ArrayList<Float> distances = new ArrayList<Float>();

  if(b.getX() <= p.getX()){
    // top-left-edge of the bottom pipe
    distances.add(dist(b.getX(), b.getY(), p.getX(), p.getY()));

    // bottom-left-edge of the upper pipe
    distances.add(dist(b.getX(), b.getY(), p.getX(), p.getY() - p.getGap()));
  }
  else{
    // top-right-edge of the bottom pipe
    distances.add(dist(b.getX(), b.getY(), p.getX() + p.getWidth(), p.getY()));

    // bottom-right-edge of the upper pipe
    distances.add(dist(b.getX(), b.getY(), p.getX() + p.getWidth(), p.getY() - p.getGap()));
  }
  return Collections.min(distances);
}

/*
* This function displays the score counter 
* and counts the number of pipes the bird has successfully crossed 
* which occurs whenever the bird enters (once!) a certain area depending on the game's speed & framerate.
* @param p closest pipe object
* @param b the player/bird
*/
void incrementScore(Pipe p, Bird b){
  textSize(40);
  textAlign(CENTER);
  text("" + score, width / 2, height / 9);

  if(p.getX() + p.getWidth() <= b.getX() + b.getRadius() + (actual_speed / 2)  && 
    p.getX() + p.getWidth() >= b.getX() + b.getRadius() - (actual_speed / 2) &&
    !gameOver)
    score++;
}