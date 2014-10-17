

// global variables
float frogX, frogY, frogW, frogH, frogInitX, frogInitY;
float leftCar1X, leftCar1Y, leftCar1W, leftCar1H;//car1
float leftCar2X, leftCar2Y, leftCar2W, leftCar2H;//car2
float rightCar1X, rightCar1Y, rightCar1W, rightCar1H;//car3
float rightCar2X, rightCar2Y, rightCar2W, rightCar2H;//car4
float leftCar1XB, leftCar2XB, rightCar1XB, rightCar2XB;//hard car 1,2,3,4
float pondY;

float speed;
int life;
int difficulty=1;

boolean HARD=false;

final int GAME_START = 1;
final int GAME_WIN = 2;
final int GAME_LOSE = 3;
final int GAME_RUN = 4;
final int FROG_DIE = 5;
int gameState;

// Sprites
PImage imgFrog, imgDeadFrog;
PImage imgLeftCar1, imgLeftCar2;
PImage imgRightCar1, imgRightCar2;
PImage imgWinFrog, imgLoseFrog;

void setup(){
  size(640,480);
  textFont(createFont("font/Square_One.ttf", 20));
  // initial state
  gameState = GAME_START;
  
  //speed
  speed = 5;
  
  // the Y position of Pond
  pondY = 32;
  
  // initial position of frog
  frogInitX = 304;
  frogInitY = 448;
  
  frogW = 32;
  frogH = 32;
  
  leftCar1W=leftCar2W=rightCar1W=rightCar2W = 32;  //all cars' width 
  leftCar1H=leftCar2H=rightCar1H=rightCar2H = 32;  //all cars' height
  leftCar1X = leftCar2X =0;                        //position X of leftCar1,2
  rightCar1X = rightCar2X =640-rightCar1H;         //position X of rightCar1,2
  leftCar2XB = leftCar1XB = leftCar1X+320;         //position X of hard car1,2
  rightCar1XB = rightCar2XB =rightCar1X-320;       //position X of hard car3,4

  leftCar1Y = 128;//position Y of leftCar1
  rightCar1Y =192;//position Y of rightCar1
  leftCar2Y  =256;//position Y of leftCar2
  rightCar2Y =320;//position Y of rightCar2
  
  // prepare the images
  imgFrog = loadImage("data/frog.png");
  imgDeadFrog = loadImage("data/deadFrog.png");
  imgLeftCar1 = loadImage("data/LCar1.png");//img of car1
  imgLeftCar2 = loadImage("data/LCar2.png");//img of car2
  imgRightCar1 = loadImage("data/RCar1.png");//img of car3
  imgRightCar2 = loadImage("data/RCar2.png");//img of car4
  imgWinFrog = loadImage("data/win.png");
  imgLoseFrog = loadImage("data/lose.png");
}

void draw(){
  switch (gameState){
    case GAME_START:
        background(10,110,16);
        text("Press Enter to Start", width/5, height/2.5);
        //speed up mode
          if(HARD==true){
          difficulty=2;
          text("Press Tab to turn HARD Mode off ", width/30, height/2);
          }    
          else if(HARD==false){
          difficulty=1;
          text("Press Tab to turn HARD Mode on ", width/20, height/2);
          }  
        break;

    case FROG_DIE:
        delay(1000);
        frogX=frogInitX;
        frogY=frogInitY;
        gameState = GAME_RUN;
        break;
        
    case GAME_RUN:
        background(10,110,16);
        fill(255);
        text("Press Enter to restart", width/5.5, height/2.5);

        // draw Pond
        fill(4,13,78);
        rect(0,32,640,32);

        // show frog live
        for(int i=0;i<life;i++){
            image(imgFrog,64+i*48 ,32);
         }
        
        // draw frog
        image(imgFrog, frogX, frogY);
         
         //car1 move
         leftCar1X += speed*3.2*difficulty;
         if (leftCar1X > width){
             leftCar1X = 0;
         }
         image(imgLeftCar1, leftCar1X, leftCar1Y);
         
         //car2 move
         leftCar2X += speed*2.2*difficulty;
         if (leftCar2X > width){
             leftCar2X = 0;
         }
         image(imgLeftCar2, leftCar2X, leftCar2Y);
         
         //car3 move
         rightCar1X -= speed*2.4*difficulty;
         if (rightCar1X < 0){
         rightCar1X = width;        
         }
         image(imgRightCar1, rightCar1X, rightCar1Y);
         
         //car4 move
          rightCar2X -= speed*2*difficulty;
          if (rightCar2X < 0){
             rightCar2X = width;
           }
         image(imgRightCar2, rightCar2X, rightCar2Y);
         
         //hard mode on
         if(difficulty==2){
              //Hard car1 move
             leftCar1XB += speed*3.2*difficulty;
             if (leftCar1XB > width){
                 leftCar1XB = 0;
              }
             image(imgLeftCar1, leftCar1XB, leftCar1Y);
       
             //Hard car2 move
             leftCar2XB += speed*2.2*difficulty;
             if (leftCar2XB > width){
                 leftCar2XB = 0;
             }
             image(imgLeftCar2, leftCar2XB, leftCar2Y);
             
             
             //Hard car3 move
             rightCar1XB -= speed*2.4*difficulty;
             if (rightCar1XB < 0){
             rightCar1XB = width;        
             }
             image(imgRightCar1, rightCar1XB, rightCar1Y);
             
             //Hard car4 move
              rightCar2XB -= speed*2*difficulty;
              if (rightCar2XB < 0){
                 rightCar2XB = width;
               }
             image(imgRightCar2, rightCar2XB, rightCar2Y);
         }
         
         //car hit set
         float frogCX1 = frogX+frogW/2;
         float frogCY1 = frogY+frogH/2;
         float frogCX2 = frogX-frogW/2;
         float frogCY2 = frogY-frogH/2;
         
         // car1 hit condition
         if((frogCX1 >= leftCar1X && leftCar1X >= frogCX2)
         && (frogCY1 >= leftCar1Y && leftCar1Y >=frogCY2)){
         image(imgDeadFrog, frogX, frogY);
         life--;
         gameState = FROG_DIE;
         }
         
         // car2 hit condition
         if((frogCX1 >= leftCar2X && leftCar2X >= frogCX2)
         && (frogCY1 >= leftCar2Y && leftCar2Y >=frogCY2)){
         image(imgDeadFrog, frogX, frogY);
         life--;
         gameState = FROG_DIE;
         }
         
         // car3 hit condition
         if((frogCX1 >= rightCar1X && rightCar1X >= frogCX2)
         && (frogCY1 >= rightCar1Y && rightCar1Y >= frogCY2)){   
         image(imgDeadFrog, frogX, frogY);
         life--;
         gameState = FROG_DIE;
         }

         // car4 hit condition
         if((frogCX1 >= rightCar2X && rightCar2X >= frogCX2)
         && (frogCY1 >= rightCar2Y && rightCar2Y >= frogCY2)){
         image(imgDeadFrog, frogX, frogY);
         life--;
         gameState = FROG_DIE;
         }
       
         //Hard mode on hit condition 
         if (difficulty==2){
           
           // hard car1 hit condition
           if((frogCX1 >= leftCar1XB && leftCar1XB >= frogCX2)
           && (frogCY1 >= leftCar1Y && leftCar1Y >=frogCY2)){
           image(imgDeadFrog, frogX, frogY);
           life--;
           gameState = FROG_DIE;
           }
             
             // hard car2 hit condition
             if((frogCX1 >= leftCar2XB && leftCar2XB >= frogCX2)
             && (frogCY1 >= leftCar2Y && leftCar2Y >=frogCY2)){
             image(imgDeadFrog, frogX, frogY);
             life--;
             gameState = FROG_DIE;
             }
             
             // hard car3 hit condition
             if((frogCX1 >= rightCar1XB && rightCar1XB >= frogCX2)
             && (frogCY1 >= rightCar1Y && rightCar1Y >= frogCY2)){   
             image(imgDeadFrog, frogX, frogY);
             life--;
             gameState = FROG_DIE;
             }
    
             // hard car4 hit condition
             if((frogCX1 >= rightCar2XB && rightCar2XB >= frogCX2)
             && (frogCY1 >= rightCar2Y && rightCar2Y >= frogCY2)){
             image(imgDeadFrog, frogX, frogY);
             life--;
             gameState = FROG_DIE;
             }
         }
         
         //win
         if(frogY<=pondY){
         gameState = GAME_WIN;
         }
         
         //lose
         if(life==0){
         gameState = GAME_LOSE;
         }
         
        break; 
         
    case GAME_WIN:
        background(0);
        image(imgWinFrog,207,164);
        fill(255);
        text("You Win !!",240,height/4);
        text("Press Enter to restart", width/6, height/1.2);
        //hard mode
          if(HARD==true){
          difficulty=2;
          text("Press Tab to turn HARD Mode off ", width/30, height/1.1);
          }    
          else if(HARD==false){
          difficulty=1;
          text("Press Tab to turn HARD Mode on ", width/20, height/1.1);
          }  
        break;
        
    case GAME_LOSE:
        background(0);
        image(imgLoseFrog,189,160);
        fill(255);
        text("You Lose",240,height/4); 
        text("Press Enter to continue", width/6, height/1.3);
        //hard mode
          if(HARD==true){
          difficulty=2;
          text("Press Tab to turn HARD Mode off ", width/30, height/1.1);
          }    
          else if(HARD==false){
          difficulty=1;
          text("Press Tab to turn HARD Mode on ", width/20, height/1.1);
          }  
        break;
      }
}
void keyPressed() {
            //hard mode
            if(key==TAB && gameState != GAME_RUN){
            HARD=!HARD;
            }
         

        if  (key == CODED && gameState == GAME_RUN) {
           switch(keyCode){ 
               case UP:       //frog go up
               frogY-=32;
               if (frogY<0){
                 frogY=0;
               }
                 break;
               
               case DOWN:      //frog go down
               frogY+=32;
               if (frogY>height-frogH){
                 frogY=height-frogH;
               }
                 break;
               case RIGHT:    //frog go right
               frogX+=32;
               if (frogX>width-frogW){
                 frogX=width-frogW;
               }
                 break;
               case LEFT:     //frog go left
               frogX-=32;
               if (frogX<0){
                 frogX=0;
               }
                 break;
             }
       }

    if(key==ENTER /*still needs something*/){   
      gameState = GAME_RUN;
      life=3;
      frogX = frogInitX;
      frogY = frogInitY;
      }
}
