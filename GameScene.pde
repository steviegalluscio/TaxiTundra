class GameScene extends Scene{
  
  //Variables
  int localMapID;
  IsometricGrid map;
  Car car;
  int cari, carj;
  SecondsTimer timer;
  ToMenuButton toMenuButton = new ToMenuButton();
  boolean play; //play is the gamestate, true when car is on grid, false when car falls/gameover or wins 
  boolean WinLossSoundplayed;
  boolean firstKeyPressed;
  String oldRecordStr;
  SelectorList selectorList;
  
  //Constructor
  GameScene(){    
    init();
  }
  
  //Method to initialize game
  void init(){
    localMapID = currentMapID;
    map = new IsometricGrid(table.getRow(localMapID).getString("gstr"));
    //place car on start block
    car = new Car(map.isoToY(8,8)-30);
    cari = 8;
    carj = 8;
    timer = new SecondsTimer(width-200,50);
    play = true;
    WinLossSoundplayed = false;
    firstKeyPressed = true;
    oldRecordStr = table.getRow(localMapID).getString("Record Time");
    selectorList = new SelectorList(2, height/2+optionTextSize, width/2-32, 50, optionTextSize);
  }
  
  void selectOption(){
    if(selectorList.getSelectionIndex() == 0){
      //Try again, reset
      init();
      cursor(ARROW);      
    } else if(selectorList.getSelectionIndex() == 1){
      //Reset
      init();
      //Return to level select
      currentScreenIndex = 2;
      //loop menu sound
      menuBgSound.loop();
      cursor(ARROW);
    } 
  }
  
  void draw(){
    //check if GameScene must be reinitialized
    if(currentMapID != localMapID){ 
      println("reinit");
      init(); 
    }
    
    //Clear canvas
    background(100);
    
    //Display timer
    fill(255);
    timer.display();
    
    //Display return to main menu button
    toMenuButton.display();
    
    //check if car needs to fall behind map eg. fall off upper half
    if(!play && (cari < 0 || carj < 0)){
      car.fall();
    }
    
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
                tint(240,240);
                image(map.ice,  drawX,  drawY);
                noTint();
              }
            } else {
              //check if car needs to fall in a hole
              if(play == false && cari == i && carj == j){ 
                //falling animation
                car.fall();
              }
            }
        }
    }
    
    //check if car needs to in front the map
    if(!play && (cari > 8 || carj > 8)){
      car.fall();
    }             
      
    //If car has not fallen
    if(play){     
      //Check for movements
      if(upPressed){
        car.moveUp();
      }
      if(downPressed){
        car.moveDown();
      }
      if(leftPressed){
        car.moveLeft();
      }
      if(rightPressed){
        car.moveRight();
      }
      
      if(!firstKeyPressed && !carSound.isPlaying()){
        carSound.play();
      } 
      
      //Display Car
      car.display();
      
      //Get car position on grid
      IntDict ij = map.xyToIso(car.getX(), car.getY());
      cari = ij.get("i");
      carj = ij.get("j");
      
      //Check if car won(i.e. reached 0,0) or needs to fall(i.e. is in hole or off size of grid)
      if((cari == 0 && carj == 0) || map.isHole(cari,carj) || cari < 0 || carj < 0 || cari >= 9 || carj >= 9){
        play = false;
        timer.stopTimer();
        gameplayBgSound.stop();
        carSound.stop();
      } 
    } else if(cari == 0 && carj == 0){ //WIN
      //freeze car
      car.freeze();
      //Play win sound
      if(!WinLossSoundplayed){
        winSound.play();
        WinLossSoundplayed = true;
      }
      //Display win modal
      displayModal(true);
    } else { //LOSS by some type of fall
      //Play loss sound
      if(!WinLossSoundplayed){
        lossSound.play();
        WinLossSoundplayed = true;
      }
      //Display loss modal
      displayModal(false);
    }
    
  }
  
  void displayModal(boolean isWin){
    //Display modal box
    float margins = 210;
    fill(255,100);
    stroke(0);
    strokeWeight(4);
    rectMode(CORNERS);
    rect(margins+20,margins,width-margins-20,height-margins); 
    noStroke();
    
    //Display modal win/loss text
    fill(0);
    textSize(optionTextSize);
    textAlign(CENTER);
    textLeading(20);
    String gameOverText;
    if(isWin){
      float runTime = timer.timeElapsed(); 
      float recordTime = oldRecordStr.charAt(0) == '-' ? 99999.0 : float(oldRecordStr);
      if(runTime < recordTime){
        //New Record 
        gameOverText = "Congratulations! New Record!\n Your Time: "+runTime+"\n Previous Record Time: "+oldRecordStr;
        //Save new record
        table.getRow(localMapID).setString("Record Time", str(runTime));
        //Save table file
        updateTableFile();
      } else {
        gameOverText = "Nice Job!\n Your Time: "+runTime+"\n Record Time: "+oldRecordStr;  
      }
    } else {
      gameOverText = "Oops! You fell :(";
    }
    gameOverText += "\n Try Again?";
    text(gameOverText, width/2,height/2-60);
    int selectionIndex = selectorList.getSelectionIndex();
    String yesText = selectionIndex == 0 ? "▶ Yes" : "Yes";
    String noText = selectionIndex == 1 ? "▶ No" : "No";
    textAlign(BASELINE);
    text(yesText, width/2-32,height/2+optionTextSize);
    text(noText, width/2-32,height/2+optionTextSize*2);
  }
  
  void keyPressed() {
    if (key == CODED) {
      if(firstKeyPressed && (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT)){
        menuBgSound.stop();
        gameplayBgSound.loop();
        firstKeyPressed = false;
        timer.startTimer();
      }
      if (keyCode == UP) {
        if(!play){ selectorList.moveUpSelection(); }
        upPressed = true;
        downPressed = false;
        leftPressed = false;
        rightPressed = false;
      }
      else if (keyCode == DOWN) {
        if(!play){ selectorList.moveDownSelection(); }
        upPressed = false;
        downPressed = true;
        leftPressed = false;
        rightPressed = false;
      }
      else if (keyCode == LEFT) {
        upPressed = false;
        downPressed = false;
        leftPressed = true;
        rightPressed = false;
      }
      else if (keyCode == RIGHT) {
        upPressed = false;
        downPressed = false;
        leftPressed = false;
        rightPressed = true;
      } 
    } else if(!play && (key == ENTER || key == RETURN) && !enterPressed){
        enterPressed = true;
        selectOption();
    }
  }
  
  void mouseMoved(){
    if(!play && selectorList.isMouseOnAnOption()){ 
      cursor(HAND);
    } else if(toMenuButton.isOnButton()){ 
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }
  
  void mouseClicked(){
    if(!play && selectorList.isMouseOnAnOption()){ 
      selectOption();
      cursor(ARROW);
    }
    
    if(toMenuButton.isOnButton()){ 
      currentScreenIndex = 1;
      init();
      if(gameplayBgSound.isPlaying()){ gameplayBgSound.stop(); }
      if(!carSound.isPlaying()){ carSound.stop(); }
      if(!menuBgSound.isPlaying()){ menuBgSound.loop(); }
      cursor(ARROW);
    }
  }
  
  
}
