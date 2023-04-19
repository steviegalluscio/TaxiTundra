class Car{
  
  //Variables
  PImage carSprite;
  float carX, carY;
  float carSpeed = 2.5;
  float carSpeedIso = carSpeed*tan(radians(30));
  float dt, vx, vy;
  float maxv;
  
  //Constructor
  Car(float intialY){
    carSprite = loadImage("assets\\carYellow\\carYellow_0005.png");
    carX = width/2;
    carY = intialY;
    vx = 0;
    vy = 0;
    maxv = 45;   
  }
  
  //returns car x position
  float getX(){
    return carX;
  }
  
  //returns car y position
  float getY(){
    return carY;
  }
  
  //displays car and plays car sound
  void display(){
    imageMode(CENTER);
    carSprite.resize(100, 0);
    image(carSprite, carX, carY);
    
    float dt = 1.0/frameRate;
    carX += vx * dt;
    carY += vy * dt;
    
    //Sound WIP
    float a = 45 - abs(vx);
    float b = 45 - abs(vx);  
    carSound.amp( min(map(a, 0, 45, 0.01, 0.5), map(b, 0, 45, 0.01, 0.5)));
  }
  
  void moveUp(){
    if(vy > -maxv && vx < maxv){ 
      vy -= carSpeedIso;
      vx += carSpeed;
    }
    carSprite = loadImage("assets\\carYellow\\carYellow_0005.png");
  }
  
  void moveDown(){
    if(vx > -maxv && vy < maxv){
      vy += carSpeedIso;
      vx -= carSpeed;
    }
    carSprite = loadImage("assets\\carYellow\\carYellow_0011.png");
  }
  
  void moveLeft(){
    if(vy > -maxv && vx > -maxv){
      vx-= carSpeed;
      vy-= carSpeedIso;
    }
    carSprite = loadImage("assets\\carYellow\\carYellow_0007.png");
  }
  
  void moveRight(){   
    if(vy < maxv && vx < maxv){
      vx+= carSpeed;
      vy+= carSpeedIso;
    }
    carSprite = loadImage("assets\\carYellow\\carYellow_0001.png");
  }
  
  //Stops car from moving and displays in place, used for win
  void freeze(){
      vx = 0;
      vy = 0;
      this.display();
  }
  
  //Displays car as falling downwards
  void fall(){
      vx = 0;
      vy = 180;
      this.display();
  }
}
