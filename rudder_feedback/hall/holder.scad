//  petg
//  infil 28%
// temp 238
// layer height .25, line width .4
// wall count 2, top 2, bottom 3
// brim 6
// infill 45, outer wall 40, inner wall 35, top/bottom 40, travel 50, initial 30

$fn=60;

bolt_height = 4;
bolt_diameter = 8.1;
magnet_diameter = 14.8;
magnet_height = 3.6;
nut_height = 3;
bearing_height = 24.5;

washer_diameter = 9.7;
washer_thickness = 2.7;

board_width =12;
board_length = 8.2;
board_height = 6;
board_holder_thickness=2;

screw_diameter=3.6;

fit=.5;
wire_r = 3;

total_height = bolt_height+magnet_height+nut_height+bearing_height+board_height+board_holder_thickness;

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

total_radius = 26.4;
h1 = bolt_height+magnet_height + nut_height;
holder_length=total_radius - board_length;
    
module top() {
    difference() {
   ocylinder(r=magnet_diameter/2, h = h1);
    }
    translate([0, 0, h1-2])
       ocylinder(r=bolt_diameter/2, h=bearing_height+2);
    translate([0, 0, h1+bearing_height-washer_thickness])
       ocylinder(r=washer_diameter/2, h=washer_thickness);
    translate([0, 0, h1])
       ocylinder(r=washer_diameter/2, h=washer_thickness);
}

module holder() {
    difference() {
        cylinder(r1=total_radius, r2=(bolt_diameter/2+total_radius/2)/2, h=total_height);
        translate([0, 0, board_height+board_holder_thickness])
            top();
        t = board_holder_thickness;
        
        hull() {
            ccube(board_width+2*t+fit, board_length+2*t+fit, board_height+t+fit+.2);
                translate([-holder_length*3/4-fit, 0, 0])
                    ccube(1, wire_r*3+fit, board_height+t+fit+.2);
        }
        ocylinder(r=magnet_diameter/2, h = board_height+t);
    }
}

module base(radius) {
   difference() {
     hull() {
       for(i=[0:2]) {
         rotate(120*i)
           translate([radius, 0, 0])
             cylinder(h=7, r=total_radius/2.7 );
       }
       cylinder(r=radius, h=1);
     }
     translate([0, 0, -.1])
     cylinder(r1=radius-.5, r2 = radius-12, h= 22);
      screw_holes(radius);
   }
}

module screw_holes(radius)
{
   for(i=[0:2]) {
    rotate(120*i)
    translate([radius+total_height/16, 0, 0])
       ocylinder(screw_diameter/2, 16);
   }       
}

module board_holder() {
    t = board_holder_thickness;
    difference() {
        union() {
            translate([0, 0, -.1])
            cylinder(r=magnet_diameter/2-fit, h = board_height+t+.2);
            hull() {
                ccube(board_width+2*t, board_length+2*t, board_height+t);
                translate([holder_length*3/4, 0, 0])
                    ccube(1, wire_r*3, board_height+t);
            }
        }
       translate([0, 0, wire_r*2+t/2-2.5]) {
           translate([0, 0, -.1])
           cylinder(r=magnet_diameter/2-fit-t*3/4, board_height);
          ccube(board_width, board_length, board_height+wire_r);
       }
        translate([-board_width/2, 0, wire_r/2+2.05])
        rotate([0, 90, 0])
           scale([1, 1, 1])
              cylinder(r=wire_r, h=holder_length*2);
                translate([-board_width/2+wire_r/2+1, 0, wire_r/2])
            hull() {
                  ccube(wire_r+2, board_length, wire_r*2);
                ccube(wire_r+4, board_length/2, wire_r*2);
            }
    }
}

if(0)
union() {
  translate([0, 0, total_height])
     mirror([0,0,1]) {
        difference() {
            union() {
               holder();
                base(total_radius);
            }
            translate([0, 0, wire_r/3])
            rotate([0, -90, 0])
                hull() {
                    scale([1.4, 1.1, 1])
                        translate([1, 0, 0])
                        cylinder(r=wire_r, h=.1);
                    translate([0, 0, total_radius])
                        scale([1, 1, 1])
                        translate([1, 0, 0])
                            cylinder(r=wire_r, h=.1);
                }  
            //cube([100, 100, 100]);
        }
    }
}

//    translate([total_radius*2, 0, 0])
//translate([0, 0, total_height])
//rotate([180,0,0])
//rotate(180)
   board_holder();
