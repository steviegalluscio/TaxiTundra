class ToMenuButton{
  boolean showToMenuButton;
  String btnText = "← Return To Menu";
  float optionWidth;
  float x = 10, y = 20;
  
  //Constructor
  ToMenuButton(){
    showToMenuButton = true;
    textSize(32);
    optionWidth = textWidth(btnText)*0.75;
  }
  
  //Displays a "return to menu" button in the top left if showToMenuButton is true
  void display(){
    if(showToMenuButton){
      textSize(32);
      fill(255);
      text(btnText, x, y);
    }
  }
  
  
  //returns true if mouse is on the button
  boolean isOnButton(){
      if(mouseY <=  y+0.25 && mouseY >=  0){
        if(mouseX <= x+optionWidth && mouseX >= x){
          return true;
        }    
      }
      return false;
  }
}
