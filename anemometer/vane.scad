$fn=60;

 use <naca4.scad>

magnet_size = 25.4/2+.5;
magnet_h = 25.4/8+.2;

pcb_d = 11;
pcb_h = 3;

bearing_d = 22.3;
bearing_h = 7;


module body() {
      union() {
         scale([1,1,.5])
    	     sphere(r=bearing_d/2+2);
             cylinder(h=bearing_h+pcb_h+5.6, r1=bearing_d/2+2, r2=bearing_d/2+3);
          translate([0, 0, bearing_h+4])
          minkowski() {
              sphere(1.2);
            cylinder(h=pcb_h+1.2, r1=bearing_d/2+2.4, r2=bearing_d/2+2.4);
          }
     }
}

module vane() {
    difference() {
      union() {
         rotate(90, [-1, 0, 0])
            cylinder(28, r1=6, r2=1.8);
          rotate(90, [0, 0, 1])
              rotate(180, [1, 0, 0]) {
                   translate([92, 0, -10])
             linear_extrude(height = 56, scale = .6)
               translate([-92, 0, 0])
                 polygon(points = airfoil_data(10, L=45));
              }
          }

            // round corners of vane
          translate([-20,40.3, 2.1])
              difference() {
                cube([40, 10, 10]);
                rotate([0, 90, 0])
                    cylinder(r=8, h=40);
               }

         translate([-20,59.6, -48])
              difference() {
                cube([40, 10, 6]);
                  translate([0, 0, 5])
                rotate([0, 90, 0])
                    cylinder(r=3, h=40);
               }
    
         translate([-20,32, -47])
              difference() {
                cube([40, 7, 3]);
                  translate([0, 7, 5])
                rotate([0, 90, 0])
                    cylinder(r=4, h=40);
               }               
      }
}


module head() {
  rotate(90, [1, 0, 0])
      difference() {
         scale([1, .5, 1])
         cylinder(h=55, r1=7, r2=5.6);
         translate([0, 0, -1])
            cylinder(h=75, r=2.1);
      }
}


rotate([180,0,0])
difference() {
   union() {
      head();
      vane();
      body();
   }
   
   cylinder(r=pcb_d/2, h=pcb_h+2);
   translate([0, 0, pcb_h])
       cylinder(r=bearing_d/2-2, h=bearing_h+pcb_h+2);
   translate([0, 0, pcb_h+1.4])
       cylinder(r=bearing_d/2, h=bearing_h+pcb_h+2);
   
   translate([0, 0, pcb_h+bearing_h+3.1 ])
   for(i=[0:2])
       rotate(i*120)
        rotate([90, 0, 0])
           cylinder(r=1.15, h=bearing_d);
   
   translate([-magnet_size/2, -magnet_size/2,-magnet_h+.1])
   cube([magnet_size*2, magnet_size, magnet_h]);
}
