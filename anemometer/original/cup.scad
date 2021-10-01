$fn=60;

cupsize = 26;
r1 = 6;
hubsize = 3;
radius = 60;

rotate(90, [-1, 0, 0]) // lay flat
union() {
  difference() {
    union() { 
        translate([0, r1, 0])
      sphere(r = cupsize);
      translate([0, 0, cupsize*20/22-r1])
        cylinder(h=(cupsize+r1)*2/3, r1=(cupsize+r1)/3, r2=hubsize-1.5);

	translate([0, -hubsize/2-.25, cupsize-.25-r1])
		cylinder(h=radius - cupsize - hubsize +r1, r=hubsize);

   translate([0, -hubsize/2-.25, radius-hubsize+.5])
      rotate(77.5, [0, -1, 0])
    translate([0, 0, -.75])
         cylinder(h=3*hubsize+2, r=hubsize, center=true);

    }
    translate([0, r1, 0])
    translate([0, 0, -
    .2])
       sphere(r = cupsize-1.2);

    translate([-cupsize, 1, -cupsize])
	   cube([2*cupsize, 2*cupsize, 5*cupsize]);
  }
}
