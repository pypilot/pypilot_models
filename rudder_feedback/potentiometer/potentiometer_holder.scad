$fn=36;

angle=30; //0 30 45 if glue
style=1; // 0 screw, 1 glue

shaft_d = 8;
body_d = 17.4;

thickness = 2.5;
box_width = 12;

height_shaft=5;
height_box=2;
height_board=2;

width_board=12;

screw_d=3.5;

module screw_plate(h, peg) {
  difference() {
    union() {
      hull() {
        for(i=[0:2])
          rotate(i*120+60)
          translate([body_d/2+thickness*4, 0, 0])
          cylinder(r=screw_d/2+thickness, h=h);
        if(angle == 0)
            translate([body_d/2+thickness*2, 0, 0])
            cylinder(r=screw_d/2+thickness, h=h);
    }
      if(peg)
        for(i=[0:2])
          rotate(i*110+70)
          translate([body_d*2/3, 0, h])
          sphere(1.2);
    }
 
    for(i=[0:2])
       rotate(i*120+60)
       translate([body_d/2+thickness*4, 0, -.1])
         cylinder(r=screw_d/2, h=h+.2);
    if(!peg)
      for(i=[0:2])
        rotate(i*110+70)
        translate([body_d*2/3, 0, -.1])
           sphere(1.5);
    }
}

module top() {
  difference() {
    union() {
      hull() {
        intersection() {
            d = body_d+thickness;
            translate([0,0,2.5])
            sphere(r=d/2);
            translate([-d/2, -d/2, 0])
            cube([d, d, height_board+height_box+height_shaft]);
        }
        translate([11, -body_d/2, 2])
            sphere(2);
        translate([11, body_d/2, 2])
            sphere(2);        
      } 
      screw_plate(2*height_board, false);
    }

    // ensure overlapping calculations
    translate([0, 0, -.1]){
        
      // bolt
      translate([0, 0, height_board+height_box])
      cylinder(r=shaft_d/2-.5, h=height_shaft+.2);

      // box
      translate([0, 0, height_board])
      intersection() {
          cylinder(r=body_d/2, h=height_box+.2);
          translate([-box_width/2, -body_d/2,0])
              cube([box_width, body_d, height_box+.2]);
      }
    
      // board
      union() {
          cylinder(r=body_d/2, h=height_board+.2);
          translate([0, -body_d/2, 0])
            cube([width_board, body_d, height_board+.2]);
      }
    }
  }
}

//bottom

module bottom(height_bottom) {
    difference() {
        union() {
            //cylinder(r=body_d/2+thickness, h=height_bottom+thickness);
            screw_plate(height_bottom+thickness, true);
            
        }
        
        translate([0, 0, thickness-.1])
        cylinder(r=body_d/2-.5, h = height_bottom+.2);
                
        translate([0, -body_d/2, thickness + .1])
        cube([width_board-1, body_d, height_bottom]);
    }
}


module hb()
{
    translate([9, 0, 0])
        rotate([0, angle, 0])
    translate([-9, 0, 0])
    rotate(118)
        bottom(6);

}


module glue_base() {
difference() {

difference() {
  union() {       
    hb();      
    cylinder(r1=60, r2=30, h=1.05);
    difference() {
        cylinder(r1=40, r2=20, h=3);
        cylinder(r=10, h=4);
    }
    difference() {
      hull() {
        translate([-10, 0, 0])
            cylinder(r=16, h=1);
        translate([9, 0, 0])
            rotate([0, angle, 0])
        translate([-9, 0, 0])
            rotate(118)
            scale([1,1,.1])
            hull()
            bottom();
      }
    }
  }
  mirror([0, 0, 1])
    translate([-50, -50, 0])
      cube([100, 100, 10]);
  }


if(angle) { // route wires under if angled
    rotate(66-angle)
    translate([-50+angle/3, 7, 6])
    rotate([0, 90, 0])
    scale([.5, 1, 1])
      cylinder(r=3.2, h=50);
} else {

      rotate(118)
      translate([5, 0, 3.5])
      rotate([0,90,0])
      scale([.6,1,1])
    cylinder(r=3, h=20);

}

}

}


module bottom_base() {
  difference() {
    bottom(6);
      rotate(0)
      translate([5, 0, 3.5])
      rotate([0,90,0])
      scale([.6,1,1])
    cylinder(r=3, h=20);
  }
}



translate([-75, 0, 0])
   top();

if(style == 0)
    bottom_base();
if(style == 1)
    glue_base();

