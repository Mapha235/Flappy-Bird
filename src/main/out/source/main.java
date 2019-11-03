import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {



/*TODO: adjust framerate to match speed
 fix collisionDetection (Area of Bird)
 collision with top pipe
 upper pipe is sometimes too small such that it is barely visible on the screen
 
 change the way (especially when) index is updated
 */



int index = 0;
int prev = 0;
Bird flappy;
Pipe pipe;
ArrayList<Pipe> pipes;
SoundFile soundfile;

public void setup() {
  
  frameRate(30);


  pipes = new ArrayList<Pipe>();
  pipes.add(0, new Pipe(width, (int)random(height/4 + 40, height - 40), 180, width/10));

  flappy = new Bird(width/6, height/2);
}

public void draw() {
  backgroundPos(0, 204, 204);


  flappy.show();
  for (int i = 0; i < index+1; i++) {
    pipes.get(i).show();
    pipes.get(i).update();  
    if (collisionDetection(pipes.get(i), flappy) == true) {
      println("Collision detected");
    }
  }

  flappy.update();
  moving_pipes(pipes);

  if (keyPressed) {
    if (key == ' ') {
      flappy.flap();
    }// the following Inputs are used for testing only
    else if (key == 'd') {
      flappy.moveRight();
    } else if (key == 'a') {
      flappy.moveLeft();
    } else if (key == 'w') {
      flappy.moveUp();
    } else if (key == 's') {
      flappy.moveDown();
    }
  }
}

public void moving_pipes(ArrayList<Pipe> ps) {

  if (ps.get(prev).getX() + ps.get(prev).getWidth() <= 0) {
    ps.remove(prev);
    prev = (prev + 1) % ps.size();
  }      

  if (ps.get(index).getX() <= width/2 + 5 && ps.get(index).getX() >= width/2 - 5) {
    println(ps.get(index).getX());

    index = (index + 1) % ps.size();
    ps.add(index, new Pipe(width, (int)random(width/4 + 40, height - 40), 180.0f, width/10));
    //for debugging
    println(ps.size());
    println(index);
    println(prev);
  }
}

public void take2(ArrayList<Pipe> ps) {
}

public Pipe mostLeftPipe(ArrayList<Pipe> ps) {

  return ps.get(0);
}

public boolean collisionDetection(Pipe p, Bird b) 
{
  if ((b.getY() + b.getRadius()) >= p.getY()) {
    if (b.getX() + b.getRadius() >= p.getX() && b.getX() <= (p.getX() + p.getWidth()))
      return true;
  } 
  return false;
}
class Bird {
  private PVector pos;
  private int diameter;
  private float gravity;
  private float velocity;
  private PImage[] img;
  float frame = 0;


  Bird(int x, int y) {
    pos = new PVector(x, y);
    diameter = 40;
    gravity = 0.5f;
    velocity = 0;
    img = new PImage[3];
    //set animation sprite
    for (int i = 0; i < 3; i++) {
      img[i] = loadImage("bird" + i + ".png");
    }
  }

  public void flap() {
    pos.y -= 30;
    velocity = 0;
    
  }

  public void moveRight() {
    pos.x++;
  }
  public void moveLeft() {
    pos.x--;
  }
  public void moveUp() {
    pos.y--;
  }
  public void moveDown() {
    pos.y++;
  }

  public int getRadius() {
    return (diameter/2);
  }
  public float getX() {
    return pos.x;
  }
  public float getY() {
    return pos.y;
  }
  public void show() {
    fill(128, 255, 0);
    ellipse(pos.x, pos.y, diameter, diameter);
    image(img[(int)frame], pos.x-27, pos.y-getRadius(), 53, diameter);
  }

  public void update() {
    if (pos.y < height) { 
      velocity += gravity;
      pos.y += velocity;
    }
    frame = (frame + 9 / frameRate) % img.length;
  }
  
  public void printFrame(){
    println(frame);
  }
}
class Pipe {
  private PVector pos;
  private float speed;
  private int pipe_width;
  private int pipe_height;

  Pipe(int x, int y, float s, int w) {
    pos = new PVector(x, y);
    speed = s / frameRate;
  
    pipe_width = w;
    pipe_height = height - y;
  }

  public void show() {
    //top pipe
    fill(255, 0, 14);
    rect(pos.x, 0, pipe_width, height - height/4 - pipe_height);
    
    //bottom pipe
    fill(42, 234, 14);
    rect(pos.x, pos.y, pipe_width, pipe_height);
  }

  public void update() {
    move();
  }

  public void move() {
    if (pos.x >= 0 - pipe_width)
      pos.x -= speed;
  }
  
  public float getX() {
    return pos.x;
  }
  public float getY() {
    return pos.y;
  }

  public int getHeight() {
    return pipe_height;
  }
  public int getWidth() {
    return pipe_width;
  }
};
  public void settings() {  size(600, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
