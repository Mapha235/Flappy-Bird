class Stripe{
    private PVector pos;
    private PImage img;

    Stripe(float x, float y){
        pos = new PVector(x,y);
        img = loadImage("stripe.png");
    }

    public void show(){
        image(img, pos.x, pos.y, width + 30, 44);
        //image(img, pos.x, pos.y, width + 30, 186);
    }
    
    public void move(float s){
        pos.x -= s / frameRate;
    }

    public void update(){
        this.show();
        //this.move(180.0);
        if(this.getX() + this.getWidth() <= 0)
            this.setX(width + 26);
    }

    public float getWidth(){
        return width + 30;
    }

    public float getX(){
        return pos.x;
    }
    public void setX(float xPos){
        pos.x = xPos;
    }
    public float getY(){
        return pos.y;
    }
    public void setY(float yPos){
        pos.y = yPos;
    }
}