class ToMenuButton{
  boolean showToMenuButton;
  String btnText = "← Return To Menu";
  String btnKey = "[esc]";
  float textWidth;
  float keyWidth;
  float x = 10, y = 20;
  
  //Constructor
  ToMenuButton(){
    showToMenuButton = true;
    textSize(16);
    keyWidth = textWidth(btnKey)*0.75;
    textSize(32);
    textWidth = textWidth(btnText)*0.75;
  }
  
  //Displays a "return to menu" button in the top left if showToMenuButton is true
  void display(){
    if(showToMenuButton){
      textSize(32);
      fill(255);
      text(btnText, x, y);
      textSize(16);
      text("[esc]", textWidth+x, y);
    }
  }
  
  
  //returns true if mouse is on the button
  boolean isOnButton(){
      if(mouseY <=  y+0.25 && mouseY >=  0){
        if(mouseX <= x+textWidth+keyWidth && mouseX >= x){
          return true;
        }    
      }
      return false;
  }
}
