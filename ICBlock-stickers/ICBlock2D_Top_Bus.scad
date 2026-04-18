//*******************
// ICBlock2D Bus Top
//
//  Created 2026.04.1 
//  arkadiusz.Hahn@gmail.com
// 
//*********************

$fn=100;
//$fa=1;
//$fs=0.2;

width=26;
segment=26.67;
length=8*segment;



// Led grid and separators
ledRowOffsetX = 6.35;
ledOffsetY= 2.54;
led2LedDistance = 5.08;

buttonBigHoleRadius=3.15; // for 6mm diameter button caps
buttonHoleRadius=1.90;    // 3D printed button caps
ledHoleRadius=1.55;

module Surface2D(obj) {
  square([length,width],center=true);
}    

Surface2D();

