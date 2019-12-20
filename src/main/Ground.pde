class Stripe implements ScrollingWorld{
    private PVector pos;
    private PImage img;

    Stripe(float x, float y){
        pos = new PVector(x,y);
        img = loadImage("stripe.png");
    }

    @Override
    public void show(){
        image(img, pos.x, pos.y, width + 30, 44);
        //image(img, pos.x, pos.y, width + 30, 186);
    }

    @Override
    public void move(float s){
        pos.x -= s / frameRate;
    }

    @Override
    public Stripe getBorder(){
        return this;
    }

    @Override
    public void update(){
        this.show();
        //this.move(180.0);
        if(this.getX() + this.getWidth() <= 0)
            this.setX(width + 26);
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