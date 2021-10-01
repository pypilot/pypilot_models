$fn=60;

style = 0;  // 0 for screw, 1 for glue
angle = 0; // angle for glue


bolt_height = 4;
bolt_diameter = 5.2;

magnet_diameter = 14.5;
magnet_height = 3;

nut_height = 3;

bearing_height = 17;
bearing_diameter = 6.6;

board_width = 26;
board_length = 18.6;
board_height = 4;

bottom_height = 2;

screw_diameter=3.6;

total_height = bolt_height+magnet_height+nut_height+bearing_height+board_height + bottom_height;

// overlapping cylinder for subtraction
module ocylinder(r, h) {
    translate([0, 0, -.1])
        cylinder(r=r, h=h+.2);
}

// cube centered only on x and y
module ccube(x, y, z) {
    translate([-x/2, -y/2, -.1])
        cube([x, y, z+.2]);
}

total_radius = total_height*.8;
h1 = bolt_height+magnet_height + nut_height;
    
module top() {
    ocylinder(r=magnet_diameter/2, h = h1);
    
    translate([0, 0, h1]) {         
        ocylinder(r=bearing_diameter/2, h=bearing_height/2-1);
        ocylinder(r=bolt_diameter/2, h=bearing_height);
        translate([0, 0, bearing_height/2+1])
            ocylinder(r=bearing_diameter/2, h=bearing_height/2);
    }
}

module holder() {
 difference() {
     cylinder(r1=total_radius, r2=(bearing_diameter/2+total_radius/2)/2, h=total_height);
   
    translate([0, 0, bottom_height+board_height])
        top();
  }
}

module base(radius, screw) {
   difference() {
     hull() {
       for(i=[0:2]) {
         rotate(120*i)
           translate([radius+total_height/8, 0, 0])
             cylinder(h=3, r=total_height/6);
       }
       cylinder(r=radius, h=3);
       cylinder(r=1, h=20);
     }
     translate([0, 0, -.1])
     cylinder(r1=radius-.5, r2 = radius-10, h= 22);
     if(screw)
        screw_holes(radius);
   }
}

module screw_holes(radius) {
  for(i=[0:2]) {
    rotate(120*i)
    translate([radius+total_height/20, 0, 0])
       ocylinder(screw_diameter/2, 16);
  }       
}


module glue_top() {
  union() {
    difference() {
        cylinder(r1=total_radius*.8, r2=(bearing_diameter/2+total_radius/2)/2, h=h1+bearing_height);
        top();
    }
    base(total_radius*.8, 1);
   }
}

glue_base_radius=50;
glue_base_height=4;
wire_space=2;
module board_holder_part() {
    ccube(board_length/3, board_width/3, wire_space);
}

module board_holder_half() {
   translate([board_length/2, 0, 0])
            board_holder_part();
   translate([0, board_width/2, 0])
            board_holder_part();
}

module board_holder() {
    board_holder_half();
    mirror([1, 1, 0])
        board_holder_half();
}

glue_inner_r=23;

module glue_base_center() {
    difference() {
        cylinder(r=glue_inner_r,h=glue_base_height*2,center=true);
        screw_holes(total_radius*.8);

        translate([0, 0, glue_base_height-board_height]) { 
            ccube(board_length, board_width, board_height);
            translate([0, 0, -wire_space]) {
                difference() {
                    ccube(board_length, board_width, wire_space);
                    board_holder();
                }
            }
         
        }
    }
}
dd=4+angle*angle/90-angle/8;
lip_height=1.6;
module glue_base() {
 difference() {    
  intersection() {
      ccube(glue_base_radius*2, glue_base_radius*2, glue_base_radius*2);  
      union() {
        difference() {
          hull() {
            scale([1, 1, .1])
                sphere(glue_base_radius);
              rotate([0, -angle, 0])
        translate([0, 0, dd])
            cylinder(r=glue_inner_r,h=glue_base_height*2,center=true);
          }
    
          difference() {
              rotate([0, -angle, 0])
            translate([0, 0, dd])
            cylinder(r=glue_inner_r,h=glue_base_height*4);
              translate([0, 0, 1-glue_inner_r/2])
              cube([glue_inner_r*4, glue_inner_r*4, glue_inner_r], center=true);
          }
        }
        rotate([0, -angle, 0])
        translate([0, 0, dd-lip_height]) {
              translate([0, 0, glue_base_height])
            difference() {
                translate([0, 0, .1])
            cylinder(r=glue_inner_r,h=lip_height);
                    base(total_radius*.85, 0);
                cylinder(r=total_radius*.85, h=5,center=true);

            }
        glue_base_center();
        }
      }
  }
  // wire hole
  translate([0, 0, glue_base_height-board_height-2]) {
        rotate([0, -angle, 0])
  translate([0,0, dd])
      scale([1, 1, .5])
      rotate([-90, 0, 0])
      cylinder(r=2.5, h=60);
   }
  }
}


if(style==0) {    
difference() {
 union() {
     translate([0, 0, total_height])
     mirror([0,0,1]) {
        difference() {
            union() {
                holder();
            base(total_radius, 1);
            }
        }
     }
  } 
}
} else {    
    translate([glue_base_radius+total_radius, 0, 0])
    glue_top();
    glue_base();
}