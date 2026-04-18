//*******************
// ICBlock2D Base Case Top
//
//  Created 2025.12.13 
//  arkadiusz.Hahn@gmail.com
// 
//  Ver 2.5  2026.04.10   
//  thruogh holes
//*********************

$fn=100;
//$fa=1;
//$fs=0.2;

length=46;
width=26;



// Led grid and separators
ledRowOffsetX = 6.35;
ledOffsetY= 2.54;
led2LedDistance = 5.08;

buttonBigHoleRadius=3.15; // for 6mm diameter button caps
buttonHoleRadius=1.90;    // 3D printed button caps
ledHoleRadius=1.55;

module Surface2D(obj) {
   difference() { 
     square([width,length],center=true);
     //if(obj[0]) circle(r=buttonBigHoleRadius); //BTN
     
       
     if(obj[0]) circle(r=buttonHoleRadius);  //BTN
       
     if(obj[1]) translate([0,5*ledOffsetY,0])  circle(r=ledHoleRadius);  //L
     if(obj[2]) translate([0,-5*ledOffsetY,0])  circle(r=ledHoleRadius); //R 
  
     if(obj[3]) translate([ledRowOffsetX,5*ledOffsetY,0])  circle(r=ledHoleRadius);   //SR1,UL
     if(obj[4]) translate([ledRowOffsetX,3*ledOffsetY,0])  circle(r=ledHoleRadius);   //SR2
     if(obj[5]) translate([ledRowOffsetX,1*ledOffsetY,0])  circle(r=ledHoleRadius);   //SR3 
     if(obj[6]) translate([ledRowOffsetX,-1*ledOffsetY,0])  circle(r=ledHoleRadius);  //SR4
     if(obj[7]) translate([ledRowOffsetX,-3*ledOffsetY,0])  circle(r=ledHoleRadius);  //SR5
     if(obj[8]) translate([-ledRowOffsetX,5*ledOffsetY,0])  circle(r=ledHoleRadius);  //BL
     if(obj[9]) translate([ledRowOffsetX,-5*ledOffsetY,0])  circle(r=ledHoleRadius);  //UR
     if(obj[10]) translate([-ledRowOffsetX,-5*ledOffsetY,0])  circle(r=ledHoleRadius);  //BR
       
     
     if(obj[11]) translate([-ledRowOffsetX,-5*ledOffsetY,0])  circle(r=ledHoleRadius);  //SL1  
     if(obj[12])translate([-ledRowOffsetX,-3*ledOffsetY,0])  circle(r=ledHoleRadius);  //SL2  
     if(obj[13])translate([-ledRowOffsetX,-1*ledOffsetY,0])  circle(r=ledHoleRadius);  //SL3 
     if(obj[14])translate([-ledRowOffsetX,1*ledOffsetY,0])  circle(r=ledHoleRadius);   //SL4  
     if(obj[15])translate([-ledRowOffsetX,3*ledOffsetY,0])  circle(r=ledHoleRadius);   //SL5  
      
       
     for (d=[1:2:5]) {   // 1,3,5
       //translate([ledRowOffsetX,d*ledOffsetY,0])  circle(r=ledHoleRadius); //SR1,2,3
       //translate([ledRowOffsetX,-d*ledOffsetY,0])  circle(r=ledHoleRadius); //SR4,5,6
       //translate([-ledRowOffsetX,-d*ledOffsetY,0])  circle(r=ledHoleRadius); SL1,2,3
       //translate([-ledRowOffsetX,d*ledOffsetY,0])  circle(r=ledHoleRadius); //SL4,5,6
     }    
     
   }    
}    


module SH5() {Surface2D([1,1,1,1,1,1,1,1]);}   // SH5 - Signal Head 5
module SH4() {Surface2D([1,1,1,1,1,1,1,0]);}   // SH4 - Signal Head 4
module SH3() {Surface2D([1,1,1,1,1,1,0,0]);}   // SH3 - Signal Head 4 
module SS() {Surface2D([1,1,1,0,1,1,0,0]);}   // SS - Shount Semafore
module Track() {Surface2D([0,1,1,0,0,0,0,0]);}   // Track
module TrnR() {Surface2D([1,1,1,1,0,0,0,0,0]);}   // Turnout R
module TrnL() {Surface2D([1,1,1,0,0,0,0,0,1]);}   // Turnout L
module WeinertBTN() {Surface2D([1,1,1,0,1,0,0,1]);}     // Weinert with BTN
module Weinert(){Surface2D([0,1,1,0,1,0,0,1]);}     // Weinert
module Anglik(){Surface2D([1,1,1,1,0,0,0,0,0,0,1]);} // Anglik
module Empty(){Surface2D([0,0,0,0,0,0,0,0,0,0,0]);} // Empty
module AnglikL(){Surface2D([1,1,1,0,0,0,0,0,1,1,0]);} // AnglikL
module TrnOdd(){Surface2D([1,1,1,0,0,1,0,0,0,0,0]);} // RrnOdd
module SurfacePrint(index) {

  if (index==1) SH5();
  if (index==2) SH4();
  if (index==3) SH3();
  if (index==4) SS();    
  if (index==5) Track();
  if (index==6) TrnR();
  if (index==7) TrnL();    
  if (index==8) WeinertBTN();
  if (index==9) Weinert();    
  if (index==10) Anglik();
  if (index==11) Empty();
  if (index==12) AnglikL();
  if (index==13) TrnOdd();
}     


SurfacePrint(13);

