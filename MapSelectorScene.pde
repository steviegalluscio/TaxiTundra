class MapSelectorScene extends Scene{
  
  //Variables
  float margins;
  SelectorList selectorList;
  ToMenuButton toMenuButton;
  int localRowCount;
  
  //Constructor
  MapSelectorScene(){
    margins = 100;
    toMenuButton = new ToMenuButton();
    init();
  }
  
  //Initialize scene
  void init(){
    localRowCount = table.getRowCount();
    selectorList = new SelectorList(table.getRowCount(), margins+26, margins+10, width-margins*2-10, optionTextSize);
  }
  
  
  void selectOption(){    
    currentMapID = selectorList.getSelectionIndex();
    goToGameScene();  
  }
  
  void draw(){
    //check if MapSelectorScene must be reinitialized
    if(table.getRowCount() != localRowCount){ 
      //println("reinit");
      init(); 
    }
    
    //clear canvas
    background(0);
    
    //Display return to main menu button
    toMenuButton.display();
    
    //Display table box
    fill(255);
    stroke(150);
    strokeWeight(4);
    rectMode(CORNERS);
    rect(margins,margins,width-margins,height-margins); 
    noStroke();
    
    //Display column labels
    fill(255);
    textSize(32); 
    text("Level Name", margins, margins-10); 
    text("Record Time", margins+width/3, margins-10);
    float lastColWidth = textWidth("Difficulty");
    text("Difficulty", width-margins-lastColWidth, margins-10);
    float fontAscentScalar = 0.35;
    //Display rows
    textSize(optionTextSize);
    fill(0);
    float rowY = 26;
    int index = 0;
    for (TableRow row : table.rows()) {
      String name = row.getString("Level Name");
      String recordTime = row.getString("Record Time");
      String difficulty = row.getString("Difficulty");
      if(index == selectorList.getSelectionIndex()){
        //Prepend with arrow
        name = "▶ "+name;
        //Highlight row
        fill(0,200,200,100);
        rectMode(CORNERS);
        //rect(margins+10, margins+rowY-optionTextSize/2-textDescent(), width-margins-10, margins+rowY+optionTextSize/2-textDescent());
        //rect(margins+10, margins+rowY-textDescent(), width-margins-10, margins+rowY+5);
        //note - (textAscent()*fontScalar)-8 will give top, -8 will give bottom
        //note 8 is .25 fotn
        rect(margins+10, margins+rowY-(textAscent()*fontAscentScalar)-8, width-margins-10, margins+rowY+8);
        fill(0);
      }
      text(name, margins+10, margins+rowY); 
      text(recordTime, margins+width/3+10, margins+rowY);
      text(difficulty, width-margins-lastColWidth, margins+rowY);
      rowY += optionTextSize;
      index++;
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
    } else if (key == ESC){
      //supress exit
      key = 0;
      //go to main menu
      goToMainMenu();
    }
  }
  
  void mouseMoved(){
    if(selectorList.isMouseOnAnOption() || toMenuButton.isOnButton()){
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
    
    if(toMenuButton.isOnButton()){ 
      goToMainMenu();
    }
  }
}
