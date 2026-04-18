//*******************
// ICBlock Base Case
//
//  Created 2025.12.13 
//  arkadiusz.Hahn@gmail.com
// 
//  Ver 2.5  2025.12.16   
//  thruogh holes
//*********************

$fn=100;
//$fa=1;
//$fs=0.2;

length=46;
width=26;
margin=0.8; // for array

surfaceHeight=1;  
frameHight=10;
frameThickness=2;


pcbDistance=5;
gridWidth=0.6;
gridCenterWidth=7.2;

// Mocking PCB
pcbWidth=19.9;
pcbLength=40;
pcbThickness=1.2;

// Led grid and separators
ledRowOffsetX = 6.35;
ledOffsetY= 2.54;
led2LedDistance = 5.08;


// Gaps in center on fronts and sides
sideGapLength=14;
frontGapLength=17;
gapHeight = pcbDistance;

// Locks for pcb
pcbLockSHeight = pcbDistance+1.8;
pcbLockFHeight = pcbDistance+1.2;
pcbLockLength = 4;
pcbLockThickness = 0.9;
pcbLockXOffset=3;
pcbLockYOffset=12;


buttonHoleRadius=1.75;
holeDepth=3*surfaceHeight;
ledHoleRadius=1.5;

// Mountung Holes
moutingRadius=1;
mountigXOffset=2;   
mountigYOffset=10;    // from front
mountigZOffset=moutingRadius; 


module Surface() 
{
   difference() { 
     translate([0,0,-surfaceHeight/2]) {
       cube([width,length,surfaceHeight],center=true);
     }    
     // button hole
     cylinder(h=holeDepth,r=buttonHoleRadius,center=true);
     // led holes
     for (d=[1:2:5]) {   // 1,3,5
       translate([ledRowOffsetX,d*ledOffsetY,0])  cylinder(h=holeDepth,r=ledHoleRadius,center=true);
       translate([ledRowOffsetX,-d*ledOffsetY,0])  cylinder(h=holeDepth,r=ledHoleRadius,center=true);
       translate([-ledRowOffsetX,d*ledOffsetY,0])  cylinder(h=holeDepth,r=ledHoleRadius,center=true);
       translate([-ledRowOffsetX,-d*ledOffsetY,0])  cylinder(h=holeDepth,r=ledHoleRadius,center=true);
     }    
     translate([0,5*ledOffsetY,0])  cylinder(h=holeDepth,r=ledHoleRadius,center=true);
     translate([0,-5*ledOffsetY,0])  cylinder(h=holeDepth,r=ledHoleRadius,center=true);
   }
}

    

module Frame() 
{
   // gaps
   thicknessS =  frameThickness+2*pcbLockThickness;
   thickness =  frameThickness;
     
   translate([0,(length-thickness)/2,gapHeight/2])
     cube ([frontGapLength,thickness,gapHeight],center=true);
   translate([0,-(length-thickness)/2,gapHeight/2])
     cube ([frontGapLength,thickness,gapHeight],center=true);
    
   
   for (m = [-1:2:1]){  
     translate([m*(width-thicknessS)/2,0,gapHeight/2]) {
       cube ([thicknessS,sideGapLength,gapHeight],center=true);  
     }  
     translate([0,m*(length-thickness)/2,gapHeight/2]) {
       cube ([frontGapLength,thickness,gapHeight],center=true);
     }    
     
     for (n = [-1:2:1]){  
       // Side Corners 
       translate([m*(width-thickness)/2,n*((length-sideGapLength)/4+sideGapLength/2),frameHight/2]) {
         cube ([thickness,(length-sideGapLength)/2,frameHight],center=true);  
       }    
       // Front Corners  9.75    
       translate([m*((width+frontGapLength)/4-thickness/2),n*(length-thickness)/2,frameHight/2]) {
        cube ([(width-frontGapLength)/2-thickness,thickness,frameHight],center=true);  
       }    
     }
   }
}    


module PcbLockers() {
  // mirror
  for (m = [-1:2:1]){  
    for (n = [-1:2:1]){  
      translate([0,m*((length-pcbLockThickness)/2-frameThickness),0]) 
      {  
        translate([n*(pcbLockLength/2+pcbLockXOffset),0,pcbLockFHeight/2])
          cube([pcbLockLength,pcbLockThickness,pcbLockFHeight],center=true);
      }
      translate([m*((width-pcbLockThickness)/2-frameThickness),0,0]) {
        translate([0,n*(pcbLockLength/2+pcbLockYOffset),pcbLockSHeight/2]) {
          cube([pcbLockThickness,pcbLockLength,pcbLockSHeight],center=true);
        }    
      }
    }    
  }
      
}

module Grid() {
   
   for (m=[-1:2:1]) { 
     translate([m*(gridCenterWidth+gridWidth)/2,0,pcbDistance/2]) {
       cube([gridWidth,6*led2LedDistance,pcbDistance],center=true);
     }
     
     // front rib
     translate([0,m*(3*led2LedDistance+gridWidth/2),pcbDistance/2])
       cube([width-2*frameThickness,gridWidth,pcbDistance],center=true);
     // middle ribs
     translate([0,m*2*led2LedDistance,pcbDistance/2])
       cube([width-2*frameThickness,gridWidth,pcbDistance],center=true);     
     translate([0,m*led2LedDistance,pcbDistance/2]){
       difference() 
       {
         cube([width-2*frameThickness,gridWidth,pcbDistance],center=true);
         cube([gridCenterWidth+0.2,gridWidth+0.2,pcbDistance+0.2],center=true);
       }    
     }
   }    
   
   // central rib
   translate([0,0,pcbDistance/2]){
       difference() 
       {
         cube([width-2*frameThickness,gridWidth,pcbDistance],center=true);
         cube([gridCenterWidth+0.2,gridWidth+0.2,pcbDistance+0.2],center=true);
       }    
   } 
}    



module MountingHoles(){
    translate([-width/2+1,(length/2-mountigYOffset),frameHight-mountigZOffset-moutingRadius]) {
          rotate([90,0,90]) {
            cylinder(h=(2*frameThickness),r=moutingRadius,center=true);
          }
    }
    translate([width/2-1,-(length/2-mountigYOffset),frameHight-mountigZOffset-moutingRadius]) {
          rotate([90,0,90]) {
            cylinder(h=(2*frameThickness),r=moutingRadius,center=true);
          }
    }
     translate([(width/2-mountigXOffset),length/2-0.5,frameHight-mountigZOffset-moutingRadius]) {
          rotate([0,90,90]) {
             cylinder(h=2*frameThickness,r=moutingRadius,center=true);
          }  
      } 
      translate([-(width/2-mountigXOffset),-length/2+0.5,frameHight-mountigZOffset-moutingRadius]) {
          rotate([0,90,90]) {
             cylinder(h=2*frameThickness,r=moutingRadius,center=true);
          }  
      } 
    
}
    

module MountingPins() {
    
      translate([width/2,(length/2-mountigYOffset),frameHight-mountigZOffset-moutingRadius]) {
          rotate([90,0,90]) {
            cylinder(h=(1.5*frameThickness),r1=moutingRadius,r2=moutingRadius-0.2,center=true);
          }
      } 
      translate([-width/2,-(length/2-mountigYOffset),frameHight-mountigZOffset-moutingRadius]) {
          rotate([90,0,90]) {
            cylinder(h=(1.5*frameThickness),r2=moutingRadius,r1=moutingRadius-0.2,center=true);
          }
      }        
      translate([(width/2-mountigXOffset),-length/2,frameHight-mountigZOffset-moutingRadius]) {
          rotate([0,90,90]) {
             cylinder(h=1.5*frameThickness,r2=moutingRadius,r1=moutingRadius-0.2,center=true);
          }  
      } 
      translate([-(width/2-mountigXOffset),length/2,frameHight-mountigZOffset-moutingRadius]) {
          rotate([0,90,90]) {
             cylinder(h=1.5*frameThickness,r1=moutingRadius,r2=moutingRadius-0.2,center=true);
          }  
      } 
}



module Pcb() {
   color("blue",0.3) 
   translate([0,0,pcbThickness/2+pcbDistance]) 
   cube([pcbWidth, pcbLength,pcbThickness],center=true);
}

module ICBlock()
{
    Surface();
    
    difference() {
      Frame();
      MountingHoles();
    }    
    MountingPins();
    Grid();  
    PcbLockers();
    // % - do not render
    //%Pcb();
}


module Builder(rows=1,columns=1) {
  for(j=[0:rows-1]) {
    for (i =[0:columns-1]) {
      translate([i*( width+margin),j*(length+margin),0]) { 
         ICBlock();    
      }    
    }    
  }
}


//Builder(rows=2,columns=3);

Builder();

