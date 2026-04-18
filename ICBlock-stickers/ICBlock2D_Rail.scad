//*******************
// ICBlock2D Track Cut
//
//  Created 2025.12.13 
//  arkadiusz.Hahn@gmail.com
// 
//  Ver  2026.01.04  
//*********************

$fn=50;
//$fa=1;
//$fs=0.2;


length=48; //46;
width=28; //26;



// Led grid and separators
ledRowOffsetX = 6.35;
ledOffsetY= 2.54;
led2LedDistance = 5.08;
semaphoreWidth=5.6;



buttonBigHoleRadius=3.15;
buttonHoleRadius=1.80;
ledHoleRadius=1.5;
ledSemHoleRadius=1.3;

module Surface2D() {
   difference() { 
     square([width,length],center=true);
     circle(r=buttonBigHoleRadius);
     //circle(r=buttonHoleRadius);
     for (d=[1:2:5]) {   // 1,3,5
       translate([ledRowOffsetX,d*ledOffsetY,0])  circle(r=ledHoleRadius);
       translate([ledRowOffsetX,-d*ledOffsetY,0])  circle(r=ledHoleRadius);
       translate([-ledRowOffsetX,d*ledOffsetY,0])  circle(r=ledHoleRadius);
       translate([-ledRowOffsetX,-d*ledOffsetY,0])  circle(r=ledHoleRadius);
     }    
     translate([0,5*ledOffsetY,0])  circle(r=ledHoleRadius);
     translate([0,-5*ledOffsetY,0])  circle(r=ledHoleRadius); 
   }    
}    




module Semaphore(nLights)
{
  semaphoreHeight =   nLights*led2LedDistance;
   
  difference() {  
     color("black") { 
        //translate([0,(nLights-1)*ledOffsetY,0]) {  //2:!1; 3:2, 4:3 
          hull() {
            translate([0,(2*(nLights-1))*ledOffsetY,0])  circle(semaphoreWidth/2);  
            circle(semaphoreWidth/2); 
          }    
     }    
     for (d=[0:nLights-1]) {
       translate([0,d*2*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
     }
  }
   color("black") {
   translate([0,-4,0]) 
     square([1.5,3],center=true);  
     translate([0,-5,0]) {  
      square([semaphoreWidth,1.5],center=true);    
     }    
   }    
}    

trackWidth = 6;

module StrightTrack(button=true) {
    difference() {
      color("black") {
        square([trackWidth, length], center=true) ;
      }
      if(button) {
        circle(buttonBigHoleRadius); 
      }    
      translate([0,5*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
      translate([0,-5*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
    }
}    

module CrossingTrack() {
    color("black") {
        square([trackWidth, length], center=true) ;
        //a=[[trackWidth/2,-trackWidth/2],[trackWidth/2,trackWidth/2],
        //[width/2,trackWidth/2],[width/2,-trackWidth/2]];
        a=[[0,-trackWidth/2+5*ledOffsetY+0.5],
            [0,trackWidth/2+5*ledOffsetY+1.5],
        [width/2,trackWidth/2+0.5],[width/2,-trackWidth/2-0.5]];
        polygon(a);
        b=[[0,-trackWidth/2-5*ledOffsetY-1.5],
            [0,trackWidth/2-5*ledOffsetY-0.5],
        [width/2,trackWidth/2+0.5],[width/2,-trackWidth/2-0.5]];
        polygon(b);
    }
}
module CrossingHoles() {
      circle(buttonBigHoleRadius); 
      translate([0,5*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
      translate([ledRowOffsetX,3*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
      translate([ledRowOffsetX,-3*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
      translate([0,-5*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
}

module Crossing() {
    
    difference() {
    CrossingTrack();
    CrossingHoles();
  }  
}    

module TurnoutRightTrack() {
    color("black") {
        square([trackWidth, length], center=true);
        
        b=[[trackWidth/2,4],[trackWidth/2,trackWidth*1.2+4.5],
            [width/2-trackWidth/2,length/2],
            [width/2,length/2],
            [width/2,-trackWidth/2+length/2]];
        //polygon(b);
        
        
        //rotate([0,0,atan((length/2+1)/(width/2+1))])
        rotate([0,0,58.5])
        translate([width/2+1,1.2,0])        
        square([width-2, trackWidth],center=true);
        
    }
}
module TurnoutRightHoles() {
     circle(buttonBigHoleRadius); 
      translate([0,5*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
      translate([ledRowOffsetX,5*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
      translate([0,-5*ledOffsetY,0])  
         circle(r=ledSemHoleRadius);
}
module TurnoutRight() {
  difference() {
    TurnoutRightTrack();
    TurnoutRightHoles();
  }   
}

module TurnoutLeft() {
  mirror([1,0,0]){
    TurnoutRight();
  }    
}



%Surface2D();
//StrightTrack(button=false);
StrightTrack(button=true);
//TurnoutRight();
//TurnoutLeft();
//Crossing();

/*
translate([ledRowOffsetX,-3*ledOffsetY,0]) {
  Semaphore(5);
  translate([ledRowOffsetX+1,0,0]) {  
    Semaphore(4);
  }    
  translate([2*(ledRowOffsetX+1),0,0]) {  
    Semaphore(3);
  }    
  translate([3*(ledRowOffsetX+1),0,0]) {  
    Semaphore(2);
  }    
}
*/