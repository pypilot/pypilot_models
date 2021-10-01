 use <naca4.scad>

module body() {
      union() {
         scale([1,1,.5])
            difference() {
    			   sphere(r=10);
               translate([0, 0, 2])
 		     	      sphere(r=10);
         }
         difference() {
             cylinder(10, r=10);
             translate([0, 0, 1.5])
                 cylinder(7, r=8.5);
         }
         difference() {
             translate([0, 0, 9])
                cylinder(6, r1=10, r2=14);
             translate([0, 0, 9])
                cylinder(6.1, r1=8, r2=12);
         }
         translate([0, 0, 15])
            difference() {
               cylinder(5, r=14);
               translate([0, 0, -.05])
               cylinder(5.1, r=12);
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
              translate([120, 0, 0])
             linear_extrude(height = 50, scale = .4)
               translate([-140, 0, 0])
                 polygon(points = airfoil_data(6)); 
           }
          
      }
      translate([-8, 110, -50])
         rotate(25, [1, 0, 0])
            cube([16, 40, 70]);

      rotate(90, [-1, 0, 0])
            translate([0, 0, -20])
            cylinder(100, r1=5, r2=.3);
   }
}

module head() {
  rotate(90, [1, 0, 0])
      difference() {
         cylinder(50, r=5);
         translate([0, 0, -1])
            cylinder(52, r=4);
      }
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

difference() {
   union() {
      head();
      vane();
      body();
   }
}