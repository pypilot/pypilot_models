shaft_diameter = 32;  // 32mm = 1 1/4 inch
//shaft_diameter = 150;  // 1 1/4 inch
height = shaft_diameter/1.8;

screw_height = height*1;
screw_radius = shaft_diameter/16;
slot=3;

arm_len=90;
thickness=4;


$fn=32;
   
   
module screw_holes() {
  rotate([90, 0, 0])
     translate([shaft_diameter*.85, screw_height/4, 0]) {
         cylinder(r=screw_radius, h= shaft_diameter/2+1);
        mirror([0,0,1])
            cylinder(r=screw_radius/1.5, h= shaft_diameter/2+1);
     }
 }
    
module ring() {
  difference() {
    union() {
        difference() {
            union() {
                cylinder(r=shaft_diameter/2*1.4, h=height, center=true);
                cube([shaft_diameter*2.1, shaft_diameter*.4, screw_height], center=true);
            }
        }
    }
    
    screw_holes();
    mirror()
        screw_holes();
    mirror([0,0,1]) {
        screw_holes();
        mirror()
            screw_holes();
    }
    cube([shaft_diameter*3, slot, screw_height+10], center=true);
     }           
  }

arm_ratio=.8;
module arm() {
 difference() {
  union() {
      hull() {
      translate([ -shaft_diameter/2*1, 0, -height/2+height*arm_ratio/2])
              cube([thickness, arm_len/3, height*arm_ratio], center=true);
      translate([-arm_len/2, 0, -height/2])        
        cylinder(r=7, h=height/2);
      }
      
    hull() {
      translate([ -shaft_diameter/2*1.2, 0, -height/2+height*arm_ratio/2])
        cube([thickness, arm_len/5, height*arm_ratio], center=true);
      translate([-arm_len, 0, -height/2])        
        cylinder(r=7, h=4);
    }
  }
  translate([-arm_len, 0, 0])
    cylinder(r=2, h=100, center=true);
 }
}


difference() {
    union() {
        ring();
        rotate(90)
            arm();
    }
    cylinder(r=shaft_diameter/2, h=screw_height+10, center=true);
}