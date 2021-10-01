$fn=60;

 use <naca4.scad>

module body() {
      union() {
         scale([1,1,.5])
    	     sphere(r=10.1);
             cylinder(10, r=10);
         difference() {
             translate([0, 0, 9])
                cylinder(6, r1=10, r2=14);
             translate([0, 0, 9])
                cylinder(6.1, r1=8, r2=12);
         }
     }
}

module vane() {
   difference() {
      union() {
         rotate(90, [-1, 0, 0])
            cylinder(100, r1=5, r2=.3);
          if (0) {
           difference() {
             translate([-1, 20, -50])
                cube([2, 90, 50]);
             translate([-2, 60, -85])
           
            rotate(50, [1, 0, 0])
                   cube([4, 40, 90]);
             }
          } else {
            rotate(90, [0, 0, 1])
              rotate(180, [1, 0, 0])
              translate([135, 0, 0])
             linear_extrude(height = 50, scale = .5)
               translate([-120, 0, 0])
                 polygon(points = airfoil_data(7, L=75)); 
           }
          
      }
      union() {
        translate([-8, 51, -82])
            rotate(50, [1, 0, 0])
                cube([16, 40, 70]);
        translate([-8, 112, -52])
            rotate(25, [1, 0, 0])
                cube([16, 40, 70]);
         translate([-8, 60, -80])
                cube([16, 60, 30]);
         translate([0, 107, -47.5])
            difference() {
                cube([8, 8, 6], center=true);
                translate([0, -2, 1])
                rotate([0, 90, 0])
                    cylinder(r=4, h=10, center=true);
            }
         translate([0, 75, -47.5])
            difference() {
                cube([8, 8, 6], center=true);
                translate([0, 3.5, 7.5])
                rotate([0, 90, 0])
                    cylinder(r=10, h=10, center=true);
            }         
       }
   }
   translate([0, 14, 0])
    rotate(60, [1, 0, 0])
    cylinder(r=4, h=11);

}

module head() {
  rotate(90, [1, 0, 0])
      difference() {
         scale([1, .5, 1])
         cylinder(60, r1=10, r2=7);
         translate([0, 0, -1])
            cylinder(h=62, r=3);
      }
   translate([0, -14,0])
      scale([1.8, 1, 1])
    rotate(-60, [1, 0, 0])
      cylinder(r=4, h=10);
}

module plug() {
   translate([0, -30, -20])
   difference() {
      union() {
         sphere(5);
         cylinder(3, r=5);
         cylinder(5, r=4);
      }
      cylinder(6, r=3);
   }
}
rotate([180,0,0])
difference() {
   union() {
      head();
      vane();
      body();
      //plug();
       
      translate([0, 0, -2])
         cylinder(11, r=4.1);
      translate([0, 0, 4])
         rotate([0, 90, 0])
             cylinder(9, r=1.6);
   }
   translate([0, 0, -1])
       cylinder(11.1, r=2.5);

   translate([0, 0, 4]) {
    rotate([0, 90, 0])
       cylinder(12, r=.8);
    rotate([0, -90, 0])
       cylinder(12, r=.8);
   }
}
