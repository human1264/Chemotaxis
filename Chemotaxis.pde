boolean [] life;
int runX, runY;
int a = 0;
int lasertime = 0;
class Walker{
   int myX, myY;
   boolean alive;
   double modX = -2;
   double modY = -2;
  Walker(){
    myX = width/2;
    myY = height/2;
  }
  Walker(int x, int y, boolean z){ 
    myX = x;
    myY = y;
    alive = z;
  }
  void walk(){
        
    myX = (int)(myX + (Math.random()*5)+modX);
    myY = (int)(myY + (Math.random()*5)+modY);
    
    if(myX > width){
    myX = 0;
    }
    if(myX < 0){
    myX = width;
    }
    if(myY > height){
    myY = 0;
    }
    if(myY < 0){
    myY = height;
    }
  }
  void show(){
  if(alive == true){
  fill((int)(Math.random()*myX)+124,255-(int)(Math.random()*myX), (int)(Math.random()*myY));
  ellipse((int)myX, (int)myY, 10,10);
  }else{
  fill(0,0,0);
  ellipse(0,0, 1,1);
  }
  }
  
  void die(){
  alive = false;
  }
  
  void run(int x, int y){
   double distance = dist(myX,myY,x,y);
   if(distance < 400){
     modX = -2;
     modY = -2;
     for(int i = 0; i < 20; i++){
     
      modX -=  (x-myX)/80.0;
      modY -=  (y-myY)/80.0;
      if(modX > -1.5){
        modX = -1.5;
      }
      if(modY > -1.5){
        modY = -1.5;
      }
      if(modX < -2.5){
        modX = -2.5;
      }
      if(modY < -2.5){
        modY = -2.5;
      }
      
     }
   }
  
    
   
  
  }
}


Walker [] army;
void setup(){
  
  size(500,500);
  
  army = new Walker[500]; 
  life = new boolean[500];
  for(int i = 0; i < army.length; i++){
    life[i] = true;
    army[i] = new Walker(width/2,height/2,life[i]); // second call to new
    
  }
 
}


void draw(){
  
  background(0,0,0);
  if(lasertime > 0){
  strokeWeight(4);
  stroke(255,0,0);
  line(mouseX,mouseY, army[a].myX, army[a].myY);
  ellipse(army[a].myX,army[a].myY,10-lasertime/3,10-lasertime/3);
  stroke(0,0,0);
  strokeWeight(1);
  lasertime--;
  }
  for(int i = 0; i < army.length; i++){
    army[i].walk();
    army[i].show();
  }
 
}

void mouseClicked(){
while(army[a].alive == false){
a = (int)(Math.random()*(army.length));  
}
lasertime = 30;
army[a].die();
for(int i = 0; i < army.length; i++){
army[i].run(army[a].myX, army[a].myY);
}

}


double dist(int x1, int y1, int x2, int y2 ){
int x = (int)sq(x2 - x1);
int y = (int)sq(y2 - y1);
double dist = Math.sqrt(x + y);
return(dist);
}
