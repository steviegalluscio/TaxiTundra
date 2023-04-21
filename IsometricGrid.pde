class IsometricGrid{
  //Variables
  PImage ice, goal;
  int[][] grid;  
  float tileWidth = 82; //one less pixel than 83 similar to tileWidth*tan(radians(30));
  float tileHeight = 48;
  float xOffset = width/2;
  float yOffset = 100;
  
  //Constructor
  IsometricGrid(String gstr){
    //println("gstr"+gstr);
    ice = loadImage("assets\\tiles\\voxelTile_07_small_fix.png");
    goal = loadImage("assets\\tiles\\abstractTile_10_small.png");
    imageMode(CENTER);
    grid = new int[9][9];
    for(int i = 0; i < 81; i++){
      int row = i % 9;
      int col = i / 9;
      //char from gstr to int
      grid[row][col] = gstr.charAt(i) - '0';
    }
  }
  
  //Returns the x coordinate of the center of an isometric row:i and column: j
  float isoToX(float i, float j){
    return xOffset+(tileWidth*(i-j))/2;    
  }
  
  //Returns the y coordinate of the center of an isometric row:i and column: j
  float isoToY(float i, float j){
    return yOffset+(tileHeight*(i+j))/2;   
  }
  
  //Returns a int dict with i and j as the row column indcies where the x,y cordinates are
  //Note: i and/or j can be outside 9x9 map bounds by design
  IntDict xyToIso(float x, float y){
    float ipre = ((x-xOffset)/tileWidth)+((y-yOffset)/tileHeight);
    int i = floor(ipre)+1;
    int j = floor((2*(y-yOffset)/tileHeight) - ipre)+1; 
    IntDict res = new IntDict();
    res.set("i", i);
    res.set("j", j);
    return res;
  }
  
  //Returns true only if col:i and row:j are a hole in the grid
  boolean isHole(int i, int j){
    if(i >= 0 && i < grid.length && j >= 0 && j < grid.length && grid[i][j] == 1){
      return true;
    }
    return false;
  }
  
  //returns 81 char gstr (grid String) that represents the current grid
  String getGstr(){
    String gstr = "";
    for(int i = 0; i < 81; i++){
      int row = i % 9;
      int col = i / 9;
      gstr += str(grid[row][col]);
    }
    return gstr;
  }
}
