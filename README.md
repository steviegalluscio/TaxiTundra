# TaxiTundra
Isometric 2.5D challenge game with a taxi sliding on ice written in Processing programming langauge.
<p float="left">
 <img src="https://user-images.githubusercontent.com/20542782/233503332-d989fa34-4af2-45b5-9932-73b76b250351.png" width="500"> 
 <img src="https://user-images.githubusercontent.com/20542782/233503400-3ac66a0c-6457-43ba-9928-175b2ab3a9ec.png" width="500">
</p>

## Overview

Taxi Tundra is a speed-based challenge game where you drive a taxi across levels made of blocks of ice and try to arrive at the goal block as fast as possible without sliding off the map. Each level has a record time that you can try to beat or you can create your own new levels in the level editor!

## Game Description
### Objective
Drive the taxi from the starting ice block to the grey goal block as fast as possible without sliding too much and falling off the map. 
### Gameplay

To play Taxi Tundra, open the TaxiTundra.pde file with Processing and click on the run button. You will then be greeted by a blinking “Click to begin” message, click on it and you will see the title screen.

<img src="https://user-images.githubusercontent.com/20542782/233503317-5f33aba4-a686-4861-ac68-65304530fd85.png" width="250">


 On the title screen, you may select an option using the keyboard's UP, DOWN, and ENTER keys, or alternatively by clicking on an option with the mouse. Select the “Level Select” button and you will be brought to the next screen. Alternatively, select the “Create Level” button to create a level. At any point beyond this screen, you may click on the “Return to menu” in the top left or press ESCAPE to return back here. 
 
<img src="https://user-images.githubusercontent.com/20542782/233503332-d989fa34-4af2-45b5-9932-73b76b250351.png" width="250"> 
 

Option 1: On the level select screen, you will be shown a list of the available levels, select the first level called “A Nice Day” if you are a beginner. The options can be selected with the mouse or the UP, DOWN, and enter keys. Each level has a name, a record time, and a difficulty(Easy, Hard, Medium)

<img src="https://user-images.githubusercontent.com/20542782/233503347-1d2532a7-5084-4cad-b586-31a4848fa5ed.png" width="250">

Option 2: On the create screen, you will be shown the default map (a 9x9 isometric grid) with the goal block being the farthest block and the spawn block being the closest. Every block but the goal and spawn is editable. Blocks can be deleted by clicking on them with a left mouse click, and blocks can be added by right-clicking at a spot. The maps can be saved by clicking the save button and inputting a name and difficulty.

<img src="https://user-images.githubusercontent.com/20542782/233503372-3293be82-f0e4-46e7-9ddb-40b2f89de327.png" width="250">


If a level is selected on the level select screen, you will see the level shown with the taxi at the spawn point. You will notice a timer starts in the top right once you begin moving the car. The goal is to get to the safe platform (the grey block) as quickly as possible. If you fall you will be given the option to retry. If you succeed then you will be shown your time, the record time, if you broke the record, and the option to retry or return to level select.  The challenge is that once the car begins to drive It will continue to slide in that direction and there are hazards such as holes in the ice and falling off the sides of the ice. You must be cautious to not get sliding too fast or you might fall.

TIP: try to fight the slide by driving in the opposite direction of the sliding for a bit

<img src="https://user-images.githubusercontent.com/20542782/233503400-3ac66a0c-6457-43ba-9928-175b2ab3a9ec.png" width="250">

### Controls
At any point past the Main Menu, the escape key will return you to the main menu. Pressing the escape key on the main menu will quit the game. On any menu, the up/down arrow keys and the enter key can be used to navigate. For the level editor, a left mouse click deletes a block and a right click adds a block. For gameplay the UP, DOWN, LEFT, and RIGHT keys are used to drive the taxi. Bear in mind the game is from a 2.5D perspective and the controls are too respectively (i.e. UP goes top the farthest “right” side of the map). 

## Assets Used
* Images
  - TaxiTundra\assets\carYellow\carYellow_00[xx].png
    - source: https://devilsworkshop.itch.io/low-poly-2d-car-sprites-free
  - TaxiTundra\assets\tiles\abstractTile_10_small.png
    - source: https://kenney.nl/assets/isometric-blocks
  - TaxiTundra\assets\tiles\voxelTile_07_small_fix.png
    - source: https://kenney.nl/assets/isometric-blocks
* Sound files
  - TaxiTundra\assets\audio\Ludum-Dare-38-Track-Two.wav
    - source:  https://soundcloud.com/abstraction/ludum-dare-38-track-one-game-loop-free-download-1?in=abstraction/sets/ludum-dare-challenge
  - TaxiTundra\assets\audio\Ludum-Dare-38-Track-Four.wav
    - source:  https://soundcloud.com/abstraction/ludum-dare-38-track-two-game-loop-free-download?in=abstraction/sets/ludum-dare-challenge
  - TaxiTundra\assets\audio\ui.wav
    - source: https://freesound.org/people/MATRIXXX_/sounds/657948/
  - TaxiTundra\assets\audio\fupicat__congrats.wav
    - source: https://freesound.org/people/Fupicat/sounds/607207/
  - TaxiTundra\assets\audio\cabled_mess__lose_funny_retro_video-games.wav
    - source: https://freesound.org/people/cabled_mess/sounds/371451/
  - TaxiTundra\assets\audio\tires_squal_loop.wav
    - source: https://opengameart.org/content/car-tire-squeal-skid-loop
* Fonts
  - TaxiTundra\assets\fonts\Dongle-Bold.ttf
    - source: https://fonts.google.com/specimen/Dongle


