class SecondsTimer{
  
  //Varibles
  int startTime;
  float storedTimeElapsed;
  boolean run;
  float x, y;
  
  //Constructor, takes x and y cooridnate for display
  SecondsTimer(float x, float y){
    this.x = x;
    this.y = y;
    run = false;
  }
  
  //Starts the timer
  void startTimer(){
    startTime = millis();
    run = true;
  }
  
  //Stops the timer
  void stopTimer(){
    startTime = millis();
    run = false;
  }
  
  //Returns the current time elapsed when running or the previous time elapsed when stopped
  float timeElapsed(){   
    if(run){
      storedTimeElapsed = (millis() - startTime) / 1000.0;    
    }
    return storedTimeElapsed;
  }
  
  //Displays the timer
  void display(){
    textSize(64);
    if(run){
      text(timeElapsed(), x, y+48);
    } else {
      text(storedTimeElapsed, x, y+48);
    }
  }
}
