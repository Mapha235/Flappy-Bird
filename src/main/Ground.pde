class Stripe extends ScrollingWorld{
    private PVector pos;
    private PImage img;
    private boolean canMove;

    Stripe(float x, float y){
        pos = new PVector(x,y);
        img = loadImage("stripe.png");
        canMove = true;
    }

    @Override
    public void show(){
        image(img, pos.x, pos.y, width + 30, 44);
        //image(img, pos.x, pos.y, width + 30, 186);
    }

    public void move(float s){
        if(canMove)
            pos.x -= s / frameRate;
    }

    public boolean getCanMove(){
        return canMove;
    }

    public void setCanMove(boolean cm){
        canMove = cm;
    }

    public float getX(){
        return pos.x;
    }
    public void setX(float xPos){
        pos.x = xPos;
    }

    public float getWidth(){
        return width + 30;
    }
}