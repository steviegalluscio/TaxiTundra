class MenuScene extends Scene{
  
  //Variables
  String title = "TAXI TUNDRA";
  String[] menuOptions = 
  {
    "Level Select",
    "Create Level",
    "Quit"
  };
  float titleTextSize = 96;
  float optionTextSize = 32;
  float titleWidth;
  PImage taxiLogo;
  int taxiLogoAnimationFrame = 0;
  SelectorList selectorList;
  
  //Constructor
  MenuScene(){
    textSize(titleTextSize);
    titleWidth = textWidth(title)*0.75;
    selectorList = new SelectorList(menuOptions, (height/2)+32, ((width-titleWidth)/2)+10, optionTextSize);
  }
  
  void selectOption(){
    if(selectorList.getSelectionIndex() == 0){
      goToLevelSelect(); //level select
    } else if(selectorList.getSelectionIndex() == 1){
      goToLevelEditor(); //create level
    } else if(selectorList.getSelectionIndex() == 2){
      exit();
    }    
  }
  
  void draw(){
    //clear canvas
    background(0);
    
    //draw title text
    textAlign(CENTER);
    textSize(titleTextSize);
    fill(0,200,200);
    //make a stroke behind title by drawing behind left-right and up down
    for (int x = -3; x < 4; x++) {
      text(title, (width/2)+x, (height/2));
      text(title, (width/2), (height/2)+x);
    }
    fill(255);
    //draw title text infront of stroke
    text(title, width/2, height/2);
    textSize(optionTextSize);
    
    //display logo spinning
    imageMode(CENTER);
    taxiLogo = loadImage("assets\\carYellow\\carYellow_"+ String.format("%04d", taxiLogoAnimationFrame) +".png");
    //update logo animation frame number
    if(frameCount%10 == 0){ taxiLogoAnimationFrame = taxiLogoAnimationFrame < 11 ? taxiLogoAnimationFrame + 1 : 0; }
    image(taxiLogo,width/2,(height/2)-textAscent()*5);
    
    //display options
    textAlign(LEFT);   
    for(int i = 0; i < menuOptions.length; i++){
      String optionText;
      if(i == selectorList.getSelectionIndex()){
        optionText = "▶ ";
      } else {
        optionText = "";
      }
      optionText += menuOptions[i];
      text(optionText, ((width-titleWidth)/2)+10, (height/2)+(32*(i+1)));
    }  
  }
  
  void keyPressed(){
    if(key ==  CODED){
      if(keyCode == UP && !upPressed){
        upPressed = true;
        selectorList.moveUpSelection(); 
      } else if (keyCode == DOWN && !downPressed){
        downPressed = true;
        selectorList.moveDownSelection(); 
      } 
    } else if((key == ENTER || key == RETURN) && !enterPressed){
      enterPressed = true;
      selectOption();
    }
  }
  
  void mouseMoved(){
    if(selectorList.isMouseOnAnOption()){
      cursor(HAND);
    } else {
      cursor(ARROW);
    }  
  }
  
  void mouseClicked(){
    if(selectorList.isMouseOnAnOption()){ 
      selectOption();
      cursor(ARROW);
    }
  }
  
}
