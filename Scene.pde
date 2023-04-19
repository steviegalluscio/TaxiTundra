abstract class Scene{
  boolean upPressed = false;
  boolean downPressed = false;
  boolean leftPressed = false;
  boolean rightPressed = false;
  boolean spacePressed = false;
  boolean enterPressed = false;
  abstract void draw();
  abstract void mouseMoved();
  abstract void mouseClicked();
  abstract void keyPressed();
  
  void keyReleased(){
    if (key == CODED) {
      if (keyCode == UP) {
        upPressed = false;
      }
      else if (keyCode == DOWN) {
        downPressed = false;
      }
      else if (keyCode == LEFT) {
        leftPressed = false;
      }
      else if (keyCode == RIGHT) {
        rightPressed = false;
      } 
    } else if(key == ENTER || key == RETURN){
      enterPressed = false;
    }
  }
}
