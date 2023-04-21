import processing.sound.*;
Scene[] screens;
int currentScreenIndex, currentMapID;
Table table;
PFont font;
float optionTextSize;
SoundFile carSound;
SoundFile menuBgSound;
SoundFile menuOptionSound;
SoundFile gameplayBgSound;
SoundFile winSound;
SoundFile lossSound;


void setup(){ 
  size(800,600);
  //size(1280,720); //suported as well
  //fullScreen(); //suported as well
  optionTextSize = 32;
  currentScreenIndex = 0;
  currentMapID = 0;
  table = loadTable("data\\data.csv", "header");
  screens = new Scene[]{
    new RequestFocusScene(),
    new MenuScene(),
    new MapSelectorScene(),
    new MapEditorScene(),
    new GameScene()
  };
  font = createFont("data\\assets\\fonts\\Dongle-Bold.ttf", 32);
  textFont(font);
  carSound = new SoundFile(this, "data\\assets\\audio\\tires_squal_loop.wav");
  menuOptionSound = new SoundFile(this, "data\\assets\\audio\\ui.wav");
  gameplayBgSound = new SoundFile(this, "data\\assets\\audio\\Ludum-Dare-38-Track-Four.wav");
  winSound = new SoundFile(this, "data\\assets\\audio\\fupicat__congrats.wav");
  lossSound = new SoundFile(this, "data\\assets\\audio\\cabled_mess__lose_funny_retro_video-game.wav");
  menuBgSound = new SoundFile(this, "data\\assets\\audio\\Ludum-Dare-38-Track-Two.wav");
  menuBgSound.loop();
}

void draw(){
  screens[currentScreenIndex].draw();
  /*
  //frame rate for testing
  if (frameCount % 60 == 0) {
    println(frameRate);
  }
  */
}

void keyPressed(){
  screens[currentScreenIndex].keyPressed();
}

void keyReleased(){
  screens[currentScreenIndex].keyReleased();
}

void mouseMoved(){
  screens[currentScreenIndex].mouseMoved();
}

void mouseClicked(){
  screens[currentScreenIndex].mouseClicked();
}

void updateTableFile(){
  saveTable(table, "data\\data.csv");
}

void goToMainMenu(){
  currentScreenIndex = 1;
  cursor(ARROW);
}

void goToLevelSelect(){
  currentScreenIndex = 2;
  cursor(ARROW);
}

void goToLevelEditor(){
  currentScreenIndex = 3;
  cursor(ARROW);
}

void goToGameScene(){
  currentScreenIndex = 4; 
  cursor(ARROW);
}
