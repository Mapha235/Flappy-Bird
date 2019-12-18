class Bird {
  private final PImage[] img;
  private float frame = 0;

  private PVector pos;
  private int diameter;
  private float gravity;
  private float velocity;
  private PVector center;

	private float angle;
	private final float angle_limit;

  // (x,y) form the coordinate of the bird's/circle's center
  Bird(float x, float y) {
    pos = new PVector(x, y);
    diameter = 40;
    gravity = 30 / frameRate;
    velocity = 0;

		angle = -35;
		angle_limit = 90;
    
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

		if(angle >= -35 && angle <= angle_limit)
			angle += velocity / 2;
  }

  public void show() {
    //fill(128, 255, 0);
    //ellipse(0, 0, diameter, diameter);

    imageMode(CENTER);
    image(img[(int)frame], 0, 0, 53, diameter);
  }

  
  public void update(){
		if(this.getY() < height - 190 - this.getRadius()){
    	this.fall();
  	}
    
		pushMatrix();
    translate(pos.x, pos.y);
	  rotate(radians(angle));
    this.show();
    popMatrix();

    this.cycleSprites();
  }

  public void flap() {
    if(pos.y >= 0) {
      pos.y -= 30;
      velocity = 0;
			angle = - 35;
    }
  }

  public void cycleSprites(){
    if(angle > angle_limit/ 2)
      frame = 1;
    else
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

	public float getAngle(){
		return this.angle;
	}

	public void setAngle(float angle){
		this.angle = angle;
	}

  public void death(boolean isDead){
  }

  public void drawCircle(float r){
    
  }
}
