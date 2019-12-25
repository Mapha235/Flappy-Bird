import java.util.Map;
import java.util.Collections;
import org.javatuples.Pair;

//indices used for moving_pipes function
int next = 0;
int mostLeft = 0;

//index used for moving_ground function
int index = 0;

float global_speed = 180.0;
float actual_speed = global_speed / frameRate;
static int score = 0;
final float groundPos = 190;


Bird flappy;
float birdX = width / 6;

Pipe pipe;
ArrayList<Pipe> pipes;
ArrayList<Stripe> stripe;
Button button;
PImage bg;
PVector edge = new PVector(0,0);


void setup() {
  smooth(8);
  size(640, 980);
  frameRate(60);

  flappy = new Bird(width / 6, height/2 - groundPos);  

  pipes = new ArrayList<Pipe>();
  pipes.add(new Pipe(width / 1.25, random(200 + 40, height - 40 - groundPos), width / 10));
  pipes.add(new Pipe(width + 3, random(200 + 40, height - 40 - groundPos), width/10));
  pipes.add(new Pipe(width + 3, random(200 + 40, height - 40 - groundPos), width/10));

  stripe = new ArrayList<Stripe>();
  stripe.add(new Stripe(0, 794));
  stripe.add(new Stripe(width + 30, 794));

  pipes.get(0).setCanMove(true);

  bg = loadImage("background-night.png"); 
}

void draw() {
  background(bg);   

  stripe.get(0).update();
  stripe.get(0).move(global_speed);
  stripe.get(1).update();
  stripe.get(1).move(global_speed);

  //println(frameRate);

  if(flappy.getY() < height - groundPos - flappy.getRadius() && flappy.getY() >= 0)
    flappy.update(); 

  update(flappy, pipes);  
  
  incrementScore(pipes, flappy);
}

void keyPressed(){
  if(global_speed > 0){ // disables all key inputs once game over occurs
    if(key == ' ')
      flappy.flap();
  }
}

void update(Bird b, ArrayList<Pipe> ps){
  moving_pipes(ps);

  for (int i = 0; i < ps.size(); i++) {    
    ps.get(i).show();

    if(ps.get(i).getCanMove())
      ps.get(i).move(global_speed);
  } 

}

void moving_pipes(ArrayList<Pipe> ps){
  if(ps.get(mostLeft).getX() + ps.get(mostLeft).getWidth() <= 0){
    ps.get(mostLeft).setCanMove(false);
    ps.get(mostLeft).setX(width + 3);
    ps.get(mostLeft).setHeight(random(200 + 40, height - 40 - groundPos));
    mostLeft = (mostLeft + 1) % 3;       
  }
  Pair<Float, PVector> closest_edge = closestEdge(ps.get(mostLeft), flappy);
  line(flappy.getX(), flappy.getY(), closest_edge.getValue1().x, closest_edge.getValue1().y);

  if(ps.get(next).getX() < width/2 + 5 && ps.get(next).getX() > width/2 - 5){
    next = (next + 1) % 3;
    ps.get(next).setCanMove(true);
  }
  if(collisionDetection(ps.get(mostLeft), flappy)) 
    global_speed = 0;
}

boolean collisionDetection(Pipe p, Bird b){
  PVector center_of_bird = new PVector(b.getX(), b.getY());
  Pair<Float, PVector> closest_edge = closestEdge(p, b);

  if(b.getX() + b.getRadius() >= p.getX() && b.getX() - b.getRadius() <= p.getX() + p.getWidth()){
    if(closest_edge.getValue0() <= b.getRadius())
      return true;
    else if(b.getY() - b.getRadius() <= p.getY() - p.getGap())
      return true;
    else if(b.getY() + b.getRadius() >= p.getY())
      return true;
  }
  else if(b.getY() + b.getRadius() >= height - groundPos)
    return true;
  else if(b.getY() - b.getRadius() <= 0)
    return true;
     
  return false;
}

/*
* @return 
*/
 Pair<Float, PVector> closestEdge(Pipe p, Bird b){
  Map<Float, PVector> closest_edge = new HashMap<Float, PVector>();  
  ArrayList<Float> distances = new ArrayList<Float>();

  if(b.getX() <= p.getX()){
    // top-left-edge of the bottom pipe
    closest_edge.put(dist(b.getX(), b.getY(), p.getX(), p.getY()), new PVector(p.getX(), p.getY()));
    distances.add(dist(b.getX(), b.getY(), p.getX(), p.getY()));

    // bottom-left-edge of the upper pipe
    closest_edge.put(dist(b.getX(), b.getY(), p.getX(), p.getY() - p.getGap()), new PVector(p.getX(), p.getY() - p.getGap()));
    distances.add(dist(b.getX(), b.getY(), p.getX(), p.getY() - p.getGap()));
  }
  else{
    // top-right-edge of the bottom pipe
    closest_edge.put(dist(b.getX(), b.getY(), p.getX() + p.getWidth(), p.getY()), new PVector(p.getX() + p.getWidth(), p.getY()));
    distances.add(dist(b.getX(), b.getY(), p.getX() + p.getWidth(), p.getY()));

    // bottom-right-edge of the upper pipe
    closest_edge.put(dist(b.getX(), b.getY(), p.getX() + p.getWidth(), p.getY() - p.getGap()), new PVector(p.getX() + p.getWidth(), p.getY() - p.getGap()));
    distances.add(dist(b.getX(), b.getY(), p.getX() + p.getWidth(), p.getY() - p.getGap()));
  }

  //Pair<Float, PVector> closest = new Pair<Float, PVector>(Collections.min(distances) ,closest_edge.get(Collections.min(distances)));
  return (new Pair<Float, PVector>(Collections.min(distances) ,closest_edge.get(Collections.min(distances))));
}

void incrementScore(ArrayList<Pipe> ps, Bird b){
  int size = 40;
  textSize(size);
  textAlign(CENTER);
  text("" + score, width / 2, height / 9);

  if(ps.get(mostLeft).getX() + ps.get(mostLeft).getWidth() <= b.getX() + b.getRadius() + (actual_speed / 2)  && 
    ps.get(mostLeft).getX() + ps.get(mostLeft).getWidth() >= b.getX() + b.getRadius() - (actual_speed / 2))
    score++;
}



