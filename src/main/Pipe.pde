class Pipe extends ScrollingWorld{
  private PVector pos;
  private float speed;
  private float my_width;
  private float bottom_height;
  private float top_height;
  private int gap;
  private boolean canMove;
  private PImage texture;

  Pipe(float x, float y, int w) {
    pos = new PVector(x, y);

    gap = 200;

    my_width = w;
    bottom_height = height - y - groundPos + 1;
    top_height = height - bottom_height - gap - groundPos;

    texture = loadImage("pipe.png");

    canMove = false;
  }

  @Override
  public void show() {
    //top pipe
    imageMode(CORNER);
    image(texture, pos.x, 0, my_width, top_height);
    
    image(texture, pos.x - 3, top_height - 30, my_width +6, 30);
    stroke(0);
    noFill();
    rect(pos.x - 3, top_height - 30, my_width + 6, 30);

    
    //bottom pipe
    image(texture, pos.x, pos.y, my_width, bottom_height);
    image(texture, pos.x - 3, pos.y, my_width + 6, 30);
    stroke(0);
    noFill();
    rect(pos.x - 3, pos.y, my_width + 6, 30);
  }

  public void update() {
    if(getCanMove()){
      move();
    }
  }

  public void move(float s) {
    if (pos.x + my_width >= 0)
      pos.x -= s / frameRate; 
  }

  public void setX(float xPos){
    pos.x = xPos;
  }

  public void setHeight(float yPos){
    pos.y = yPos;
    bottom_height = height - yPos - groundPos - 1;
    top_height = height - bottom_height - gap - groundPos;
  }
  
  public float getX() {
    return pos.x;
  }
  public float getY() {
    return pos.y;
  }
  public int getGap(){
    return gap;
  }

  public float getBottomHeight() {
    return bottom_height;
  }
  public float getWidth() {
    return my_width;
  }
  public float getTopHeight(){
    return top_height;
  }
  public boolean getCanMove(){
    return canMove;
  }
  public void setCanMove(boolean b){
    canMove = b;
  }
};