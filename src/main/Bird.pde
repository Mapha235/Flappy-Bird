class Bird {
  private PVector pos;
  private int diameter;
  private float gravity;
  private float velocity;
  private PImage[] img;
  private PVector center;
  float frame = 0;

  // (x,y) form the coordinate of the bird's/circle's center
  Bird(float x, float y) {
    pos = new PVector(x, y);
    diameter = 40;
    gravity = 30 / frameRate;
    velocity = 0;
    
    center = new PVector(x,y);

    img = new PImage[3];
    //set animation sprite
    for (int i = 0; i < 3; i++) {
      img[i] = loadImage("bird" + i + ".png");
    }
  }

  public void fall(){
    velocity += gravity;
    pos.y += velocity;
  }

  public void show() {
    //fill(128, 255, 0);
    //ellipse(pos.x, pos.y, diameter, diameter);
    image(img[(int)frame], pos.x - 27, pos.y - getRadius(), 53, diameter);
  }

  public void flap() {
    if(pos.y >= 0) {
      pos.y -= 30;
      velocity = 0;
    }    
    /*if(pos.y >= 0){
      for(int i = 0; i <= 30; i++){
        pos.y -= 1;
        velocity = 0;
      }
    }*/
  }

  public void cycleSprites(){
    frame = (frame + 9 / frameRate) % img.length;
  }

  public int getRadius() {
    return (diameter / 2);
  }
  public float getX() {
    return pos.x;
  }
  public float getY() {
    return pos.y;
  }

  public PVector getCenter(){
    return center;
  }

  public void death(boolean isDead){
    if(isDead)

      fall();
  }

  public void drawCircle(float r){
    
  }

  //public PVector border(){
  //  PVector pv;
  //  return pv;
  //}
}
