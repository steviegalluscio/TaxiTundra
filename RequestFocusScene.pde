class RequestFocusScene extends Scene{
  float alpha = 0;
  
  void draw(){
    background(0);
    textAlign(CENTER);
    textSize(96);
    alpha+=0.1;
    fill(255,(sin(alpha)*100)+155); //pulse opacity
    text("Click to begin", width/2, height/2);
  }
  
  void mouseClicked(){
    //move to menu
    goToMainMenu();
  }
  
  void keyPressed(){}
  void mouseMoved(){}
}
