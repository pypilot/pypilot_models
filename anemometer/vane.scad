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
              sphere(1);
            cylinder(h=pcb_h+1, r1=bearing_d/2+2.4, r2=bearing_d/2+2.4);
          }
     }
}

module vane() {
      union() {
         rotate(90, [-1, 0, 0])
            cylinder(50, r1=5, r2=2.4);
          rotate(90, [0, 0, 1])
              rotate(180, [1, 0, 0]) {
                   translate([120, 0, 0])
             linear_extrude(height = 45, scale = .6)
               translate([-90, 0, 0])
                 polygon(points = airfoil_data(10, L=50));
          translate([80, 0, 0])
            mirror([0, 0, 1])
                  translate([-10,0,0])
             linear_extrude(height = 10, scale = .6)
               translate([-40, 0, 0])
                 polygon(points = airfoil_data(10, L=50));
                }
      }
}


module head() {
  rotate(90, [1, 0, 0])
      difference() {
         scale([1, .45, 1])
         cylinder(h=70, r1=7, r2=5);
         translate([0, 0, -1])
            cylinder(h=75, r=1.8);
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
   translate([0, 0, pcb_h+1.2])
       cylinder(r=bearing_d/2, h=bearing_h+pcb_h+2);
   
   translate([0, 0, pcb_h+bearing_h+2.8 ])
   for(i=[0:2])
       rotate(i*120)
        rotate([90, 0, 0])
           cylinder(r=.9, h=bearing_d);
   
   translate([-magnet_size/2, -magnet_size/2,-magnet_h+.1])
   cube([magnet_size*2, magnet_size, magnet_h]);
}
