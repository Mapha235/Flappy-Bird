class Bird {
  private final PImage[] img;
  private float frame = 0;

  private PVector pos;
  private int diameter;
  private float gravity;
  private float velocity;
	private final float flap_limit;

	private float angle;
	private final float angle_limit;


  Bird(float x, float y) {
    pos = new PVector(x, y);

    diameter = 40;
    gravity = 30 / frameRate;
    flap_limit = (-1) * (gravity * 11);
    velocity = 0;

		angle = (-1) * 30;
		angle_limit = 90;
    
    img = new PImage[3];
    //set animation sprite
    for (int i = 0; i < 3; i++) {
      img[i] = loadImage("bird" + i + ".png");
    }
  }

  public void fall(){
    velocity += gravity;
    pos.y += velocity;
    
    if(angle >= -35 && angle <= angle_limit && velocity >= 5)
			angle += velocity / 2;   
    
  }

  public void show() {
    //fill(128, 255, 0);
    //ellipse(0, 0, diameter, diameter);
    imageMode(CENTER);
    image(img[(int)frame], 0, 0, (1.325 * diameter), diameter);
  }

  public void flap() {
    velocity = 0;
    gravity *= (-1);
		angle = (-1) * 30;
  }
  
  public void update(){
    this.fall();      

    if(velocity < flap_limit)
      gravity *= (-1);
    
		pushMatrix();
    translate(pos.x, pos.y);
	  rotate(radians(angle));
    this.show();
    popMatrix();

    this.cycleSprites();
  }

  public void cycleSprites(){
    if(angle > angle_limit / 2)
      frame = 1;
    else
      frame = (frame + 9 / frameRate) % img.length;
  }

  public int getRadius() {
    return (diameter / 2);
  }
  /*
  * @return center-point X-Coordinate of the bird */
  public float getX() {
    return pos.x;
  }
  /*
  * @return center-point Y-Coordinate of the bird */
  public float getY() {
    return pos.y;
  }

  /*
  * @return center-point of the bird */
  public PVector getCenter(){
    return pos;
  }

  public void setVelocity(float v){
    this.velocity = v;
  }

	public float getAngle(){
		return this.angle;
	}

	public void setAngle(float angle){
		this.angle = angle;
	}

  public void drawCircle(float r){
    
  }
}