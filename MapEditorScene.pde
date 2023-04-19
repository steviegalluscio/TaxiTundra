class MapEditorScene extends Scene{
  
  //Variables
  IsometricGrid map;
  ToMenuButton toMenuButton = new ToMenuButton();
  SelectorList selectorList = new SelectorList(2, height-100+24, 70, 150, optionTextSize);
  SelectorList enterOrCancel = new SelectorList(2, height/2+optionTextSize, 70, width/2-40, optionTextSize);
  SelectorList difficultyList = new SelectorList(4, height/2, 70, width/2-40, optionTextSize);
  boolean showLevelNameInput;
  boolean showDifficultyInput;
  boolean showSucessfullySaved;
  int sucessfullySavedModalDisplayOpacity;
  String userInput;
  
  //Constructor
  MapEditorScene(){    
    init();
  }
  
  //Method to initialize map editor
  void init(){
    map = new IsometricGrid("000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    showLevelNameInput = false;
    showDifficultyInput = false;
    showSucessfullySaved = false;
    sucessfullySavedModalDisplayOpacity = 255;
    userInput = "";
  }
  
  //This method is called to select the active option 
  //as defined by the selector lists and booleans for what is currently shown
  void selectOption(){    
    if(!showLevelNameInput && !showDifficultyInput && selectorList.getSelectionIndex() == 0){
      //Save Level selected
      //Show level name input
      showLevelNameInput = true;
      cursor(ARROW);
    } else if(!showLevelNameInput && selectorList.getSelectionIndex() == 1){
      //Reset Editor
      init();
    } else if(showLevelNameInput && enterOrCancel.getSelectionIndex() == 0){
      //Enter level name
      //Hide level name input and show difficulty input
      showLevelNameInput = false;
      showDifficultyInput = true;
      cursor(ARROW);
    } else if(showLevelNameInput && enterOrCancel.getSelectionIndex() == 1){
      //Cancel level name
      //Hide level name input
      showLevelNameInput = false;
      cursor(ARROW);
    } else if(showDifficultyInput && difficultyList.getSelectionIndex() < 3){
      //Difficulty selected
      int selectedDifficulty = difficultyList.getSelectionIndex();
      //Hide difficulty input
      showDifficultyInput = false;
      //Save Level
      TableRow newRow = table.addRow();
      newRow.setString("Level Name", userInput);
      newRow.setString("Record Time", "-");
      String difficultyStr = "Easy"; 
      if(selectedDifficulty == 1){
        difficultyStr = "Medium";
      } else if(selectedDifficulty == 2){
        difficultyStr = "Hard";
      }
      newRow.setString("Difficulty", difficultyStr);
      newRow.setString("gstr", map.getGstr());
      updateTableFile();
      showSucessfullySaved = true;
      cursor(ARROW);    
    } else if (showDifficultyInput && difficultyList.getSelectionIndex() == 3){
      //Cancel difficulty select
      showDifficultyInput = false;
      cursor(ARROW); 
    }
  }
  
  void draw(){
    //Clear canvas
    background(100);
    
    //Display return to main menu button
    toMenuButton.display();
    
    //Calculated the selected tile
    IntDict ij = map.xyToIso(mouseX, mouseY);
    int selectedi = ij.get("i");
    int selectedj = ij.get("j");    

    //Display map
    for (int diag = 0; diag < 2 * 9 - 1; diag++) {
      int k = (diag < 9) ? 0 : diag - 9 + 1;
        for (int i =  diag - k; i >= k; i--) {
          int j = (diag - i);
          float drawX = map.isoToX(i,j);
          float drawY = map.isoToY(i,j);
          if(map.grid[i][j] == 0){  
            if(i==0 && j==0){
              image(map.goal,  drawX,  drawY);
            } else{
              //tint(240,240);
              image(map.ice,  drawX,  drawY);
              noTint();
            }
          } else {
            //hole
          }
          //highlight block the mouse is over if the modal isnt showing
          if((!showLevelNameInput && !showDifficultyInput) && i == selectedi && j == selectedj){
            tint(128,128);
            image(map.ice,  drawX,  drawY);
            noTint();
            //stops the start and goal bloacks from being modified
            if(mousePressed && !(selectedi == 0 && selectedj == 0) && !(selectedi == 8 && selectedj == 8)){
              if(mouseButton == LEFT){
                map.grid[i][j] = 1;
              } else if(mouseButton == RIGHT){
                map.grid[i][j] = 0;
              }
            }
          }
      }
    }
    
    //Display options box
    fill(0);
    stroke(150);
    strokeWeight(4);
    rectMode(CORNERS);
    rect(60, height-100, 240, height-30); 
    noStroke();
    
    //Display options
    fill(255);
    textSize(optionTextSize); 
    int selectedIndex = selectorList.getSelectionIndex();
    String saveText = selectedIndex == 0 ? "▶ Save Level" : "Save Level";
    String resetText = selectedIndex == 1 ? "▶ Reset Editor" : "Reset Editor";
    text(saveText, 70, height-100+24); 
    text(resetText, 70, height - 100+24+optionTextSize);
    
    if(showLevelNameInput){ 
      displayLevelNameInputModal(); 
    } else if(showDifficultyInput){
      displayDifficultyInputModal();
    } else if(showSucessfullySaved){
      displaySucessfullySavedModal(sucessfullySavedModalDisplayOpacity);
      sucessfullySavedModalDisplayOpacity -= 4;
      if(sucessfullySavedModalDisplayOpacity < 0){
        showSucessfullySaved = false;
        sucessfullySavedModalDisplayOpacity = 255;
      }
    }  
  }
  
  void displayLevelNameInputModal(){
    //Display modal box
    float margins = 240;
    fill(255);
    stroke(150);
    strokeWeight(4);
    rectMode(CORNERS);
    rect(margins,margins,width-margins,height-margins+20); 
    //noStroke();
    fill(0);
    textSize(optionTextSize);
    textAlign(CENTER);
    text("Enter level name below:", width/2 ,height/2-32);
    text(userInput, width/2, height/2);
    //stroke(0);
    strokeWeight(1);
    line(margins+20,height/2+2,width-margins-20,height/2+2);
    noStroke();
    
    
    int selectedIndex = enterOrCancel.getSelectionIndex();
    String enterText = selectedIndex == 0 ? "▶ ENTER" : "ENTER";
    String cancelText = selectedIndex == 1 ? "▶ CANCEL" : "CANCEL";
    textAlign(BASELINE);
    text(enterText, width/2-40,height/2+optionTextSize);
    text(cancelText, width/2-40,height/2+optionTextSize*2);
    textAlign(LEFT);
  }
  
  void displayDifficultyInputModal(){
    //Display modal box
    float margins = 240;
    fill(255);
    stroke(150);
    strokeWeight(4);
    rectMode(CORNERS);
    rect(margins,margins,width-margins,height-margins+60); 
    noStroke();
    fill(0);
    textSize(optionTextSize);
    textAlign(CENTER);
    text("Select a difficulty for the level:", width/2 ,height/2-32); 
    int selectedIndex = difficultyList.getSelectionIndex();
    String easyText = selectedIndex == 0 ? "▶ Easy" : "Easy";
    String mediumText = selectedIndex == 1 ? "▶ Medium" : "Medium";
    String hardText = selectedIndex == 2 ? "▶ Hard" : "Hard";
    String cancelText = selectedIndex == 3 ? "▶ CANCEL" : "CANCEL";
    textAlign(BASELINE);
    text(easyText, width/2-40,height/2);
    text(mediumText, width/2-40,height/2+optionTextSize);
    text(hardText, width/2-40,height/2+optionTextSize*2);
    text(cancelText, width/2-40,height/2+optionTextSize*3);
    textAlign(LEFT);
  }
  
  void displaySucessfullySavedModal(float opacity){
    //Display modal box
    float margins = 260;
    fill(255, opacity);
    stroke(150, opacity);
    strokeWeight(4);
    rectMode(CORNERS);
    rect(margins,margins,width-margins,height-margins); 
    noStroke();
    fill(0, opacity);
    textSize(optionTextSize);
    textAlign(CENTER);
    text("Level Saved Sucessfully!", width/2 ,height/2);
    textAlign(LEFT);
  }
  
  void keyPressed(){
    if(key ==  CODED){
      if(keyCode == UP && !upPressed){
        upPressed = true;
        if(showLevelNameInput){
          enterOrCancel.moveUpSelection();
        } else if(showDifficultyInput){
          difficultyList.moveUpSelection();
        } else {
          selectorList.moveUpSelection();
        } 
      } else if (keyCode == DOWN && !downPressed){
        downPressed = true;
        if(showLevelNameInput){
          enterOrCancel.moveDownSelection();
        } else if(showDifficultyInput){
          difficultyList.moveDownSelection();
        } else {
          selectorList.moveDownSelection();
        } 
      } 
    } else if((key == ENTER || key == RETURN) && !enterPressed){
      enterPressed = true;
      selectOption();
    }
    
    //Handles level name text input
    if(showLevelNameInput){
      if(Character.isLetter(key) || key == ' '){ //if input is a letter or space
        userInput += key;
      } else if(key == BACKSPACE){ //if input is back space
        int len = userInput.length();
        //remove last char of input if possible
        if(len > 0){
          userInput = userInput.substring(0, len-1);
        }
        println("backspace");
      } else {
        println("notchar:"+key);
      }
    }
  }
  
  void mouseMoved(){
    if((!showLevelNameInput || !showDifficultyInput) && selectorList.isMouseOnAnOption()){ 
      cursor(HAND);
    } else if(showLevelNameInput && enterOrCancel.isMouseOnAnOption()){
      cursor(HAND);
    } else if(showDifficultyInput && difficultyList.isMouseOnAnOption()){
      cursor(HAND);
    } else if(toMenuButton.isOnButton()){ 
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }
  
  void mouseClicked(){
    if((!showLevelNameInput || !showDifficultyInput) && selectorList.isMouseOnAnOption()){ 
      selectOption();
      cursor(ARROW);
    } else if(showLevelNameInput && enterOrCancel.isMouseOnAnOption()){
      selectOption();
      cursor(ARROW);
    } else if(showDifficultyInput && difficultyList.isMouseOnAnOption()){
      selectOption();
      cursor(ARROW);
    }
    
    if(toMenuButton.isOnButton()){ 
      currentScreenIndex = 1;
      init();
      cursor(ARROW);
    }
  }
  
}
