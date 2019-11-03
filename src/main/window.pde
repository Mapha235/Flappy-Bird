class Window{
    Button button;
    private PImage backgr_img;

    Window(){
        
    }
    public void show(){        
        button = new Button(width/3, height - height/3, width/3, height/6);
    }
    public void update(){
        if(button.getClicked()){

        }
    }
}

class Button {
    private PVector pos;
    private PVector center;
//    private T center_object;
    private float my_width;
    private float my_height;
    private boolean clicked;

    Button(float x, float y, float width, float height){
        pos = new PVector(x,y);
        center = new PVector(x + width / 2, y + height / 2);                
        
        my_width = width;
        my_height = height;

        clicked = false;
    }

    public void show(){
        fill(255,255,255);
        rect(pos.x, pos.y, my_width, my_height, 50);

        fill(0,204,0);
        triangle(pos.x + my_width / 2.5, pos.y + my_height / 3,
                 pos.x + my_width / 2.5, pos.y + my_height - my_height / 3,
                 pos.x + my_width - my_width / 2.5, pos.y + my_height / 2);    
    }

    public void update(){        
        if(clicked = mouseOver()){
            
        }
    }
    
    public boolean mouseOver(){
        if(mouseX >= pos.x && mouseX <= pos.x + my_height &&
            mouseY >= pos.y && mouseY <= pos.y + my_width){
            return true;
        }
        else 
            return false;
    }

    public boolean getClicked(){
        return clicked;
    }
}