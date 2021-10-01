
$fn=28;

length = 90;
set_length = 5;
bolt_d=6;
end_bolt=4;

use_bolt = 0;

//rotate(1.5, [0, 1, 0])
difference() {
  minkowski() {
 union() {
    hull() {
        translate([-set_length, 0, 0])
            cylinder(h=6, r=bolt_d*1, center=true);
        translate([length-end_bolt*8, 0, 0])
            cylinder(h=2, r=end_bolt*1, center=true);
    }
    hull() {
        translate([length-end_bolt*9, 0, 0])
            cylinder(h=2, r=end_bolt*1.1, center=true);
        translate([length, 0, 0])
            cylinder(h=2, r=end_bolt*1, center=true);
    }
}
   
   sphere(1);
   }
   
   if(use_bolt) {
    bolt(6);
   } else
   cylinder(r=2, h= 10, center=true);
   
//    holes for arm attachment to ball socket
    for(x=[0:2])
        translate([length-x*end_bolt*4, 0, 0])
            cylinder(h=15, r=end_bolt/2, center=true);


translate([-4, 0, 0])
  rotate(-90, [0, 1, 0])
     cylinder(h=15, r=1.5);
}




module bolt(bolt_d) {
    difference() {
        union() {
            cylinder(h=16, r=bolt_d/2, center=true);
            for(i=[0:17])
                rotate(i*360/18)
                    translate([bolt_d/2, 0, 0])
                        cylinder(r=.5, h=16, center=true, $fn=3);
        }
        
        translate([0, 0, -2])
        cube([20, .8, 14], center=true);
    }
    translate([0, 0, 2.5])
       cylinder(h=20, r=bolt_d/2+.5);
}
