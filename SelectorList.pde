class SelectorList{
  
  //Variables
  private int selectionIndex = 0;
  private int rowCount;
  private float startOfListY, verticalSpacing, startOfListX, optionWidth;
  private float[] optionWidths;
  float fontAscentScalar = 0.35;
  float fontPadding = 0.25;
  
  //Constructor
  SelectorList(int rowCount, float startOfListY, float startOfListX, float optionWidth, float textSize){
    this.rowCount = rowCount;
    this.startOfListY = startOfListY;
    this.verticalSpacing = textSize;
    this.startOfListX = startOfListX;
    this.optionWidth = optionWidth;
    this.fontPadding *= textSize;
    textSize(textSize);
  }
  
  //Alternate Constructor
  SelectorList(String[] options, float startOfListY, float startOfListX, float textSize){
    rowCount = options.length;
    this.startOfListY = startOfListY;
    this.verticalSpacing = textSize;
    this.startOfListX = startOfListX;
    this.fontPadding *= textSize;
    textSize(textSize);
    
    //Array of widths
    optionWidths = new float[rowCount];
    for(int i = 0; i < rowCount; i++){
      optionWidths[i] = textWidth(options[i]);
    }    
  }
  
  //Returns the current selectionIndex
  int getSelectionIndex(){
    return selectionIndex;
  }
  
  //Returns index of option mouse is on or -1 if not on a selection
  int findOptionMouseOn(){
    for(int i = 0; i < rowCount; i++){
      float ypos = startOfListY+(i*verticalSpacing);
        if(mouseY <=  ypos+fontPadding && mouseY >=  ypos-(textAscent()*fontAscentScalar)-fontPadding){
        //uses list of widths if available
        if(optionWidths != null){
          optionWidth = optionWidths[i];
        }
        if(mouseX <= startOfListX+optionWidth && mouseX >= startOfListX){
          return i;
        }    
      }
    }
    return -1;
  }
  
  //Returns true if mouse is on any option
  //Used for mouseClicked and mouseMoved
  boolean isMouseOnAnOption(){
    int ind = findOptionMouseOn();
    if(ind != -1){
      if(!menuOptionSound.isPlaying() && selectionIndex != ind){
        //if new selection play ui sound
        menuOptionSound.play();
      }
      selectionIndex = ind;
      return true; 
    }
    return false;
  }
  
  //Moves up selection by decreasing selectionIndex if it is greater than zero
  void moveUpSelection(){
    if(selectionIndex > 0){
      selectionIndex--;
      //play ui sound
      menuOptionSound.play();
    }
  }
  
  //Moves down selection by increasing selectionIndex if it is less than rowCount-1
  void moveDownSelection(){
    if(selectionIndex < rowCount-1){
      selectionIndex++;
      //play ui sound
      menuOptionSound.play();
    }
  }
  
}
