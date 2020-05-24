color idle = color(255,102,0);


//class
class myVertSlider{
 
  //class vars
  int sliderPosX, sliderPosY;
  int sliderHeight;
  int sliderWidth = 16;
  int sliderRaw;
  int sliderVal;
  int sliderMin, sliderMax;
  int sliderGrabbed;
  
  //initialize
  myVertSlider(int posX, int posY, int tall, int min, int max, int input){
    sliderPosX = posX;
    sliderPosY = posY;
    sliderHeight = tall;
    sliderVal = input;
    sliderMin = min;
    sliderMax = max;
  }
  int update(){
    sliderRaw = int(map(sliderVal, sliderMin, sliderMax, sliderHeight, 0));
    
    if(mousePressed){
      if(mouseX >= sliderPosX && mouseX <= sliderPosX + sliderWidth && mouseY >= sliderPosY && mouseY <= sliderPosY + sliderHeight){
        sliderRaw = mouseY - sliderPosY;
        sliderVal = int(map(sliderHeight - sliderRaw, 0 , sliderHeight, sliderMin, sliderMax));
      }
    }
    return sliderVal;
  }
  void display(boolean showMenu){
    if (showMenu == true){
    //stroke(idle);
    //strokeWeight(1);
    //main line
    line(sliderPosX + sliderWidth/2, sliderPosY, sliderPosX + sliderWidth/2, sliderPosY + sliderHeight);
    //horizontal indicators
    line(sliderPosX + sliderWidth/2, sliderPosY, sliderPosX, sliderPosY);  //top
    line(sliderPosX + sliderWidth/2, sliderPosY + sliderHeight, sliderPosX, sliderPosY + sliderHeight);
    line(sliderPosX + sliderWidth/2, sliderPosY + sliderHeight/2, sliderPosX, sliderPosY + sliderHeight/2);
    drawTriangle(int(sliderPosX + sliderWidth/2), sliderRaw + sliderPosY, 10);
    // text indicator
    fill(idle);
    text(sliderVal, sliderPosX-2, sliderPosY-2);
    text("Press 'm' to toggle\nPress 'r' to randomize",30, 250);
    } 
  }
  
  public void setSliderVal(int sliderVal){
  this.sliderVal = sliderVal;
}
  
}


void drawTriangle(int triX, int triY, int triSize){
  int triangleSize = triSize;
  //stroke(idle);
  //strokeWeight(1);
  noFill();
  triangle(triX, triY, triX + triangleSize, triY - triangleSize/2, triX + triangleSize, triY + triangleSize/2);
}
