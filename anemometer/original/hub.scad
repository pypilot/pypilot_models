$fn=60;

module t() {
    translate([0, 0, -.5])
   union() {
      cylinder(h=14, r=3.2, center=true);
      rotate(-77.5, [1, 0, 0])
         cylinder(10, r=3.15);
   }
}

module hub() {
p=3.5;
difference() {
    union() {
     intersection() {
      translate([0, .5, 0])
    	cylinder(11, r=15, center=true);
      //translate([0, 1, 0])
        //sphere(15);
     }
    }
	union() {
      translate([0, 2*p, 0])
         t();
      translate([-sqrt(3)*p, -p, 0])
      rotate(120)
         t();
      translate([sqrt(3)*p, -p, 0])
      rotate(240)
         t();
   }
             translate([0, -9, -2.1])
            
                cylinder(h=6, r=2.25, center=true);

	cylinder(15, r=2.5, center=true);
}
}


module split() {
            translate([-15, -15, 0])
                cube([30, 30, 30]);
    
}

   intersection() {
       translate([0, 0, -30])
       split();
          hub();
   }


rotate(180, [0, 1, 0])
   translate([32, 0, 0])
   difference() {
     intersection() {
       split();
       hub();
    }
    
    translate([0, 0, -1.4])
      rotate(30)
	   rotate(90, [0, 1, 0])
          cylinder(14, r=.8);
}
