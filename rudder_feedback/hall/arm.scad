$fn=32;

length = 120;
set_length = 5;
bolt_d=5;
end_bolt=3.2;

difference() {
  minkowski() {
 union() {
    hull() {
        translate([-set_length, 0, 0])
            cylinder(h=6, r=bolt_d*1.5);
        translate([length-end_bolt*8, 0, 0])
            cylinder(h=3, r=end_bolt*1.4);
    }
    hull() {
        translate([length-end_bolt*9, 0, 0])
            cylinder(h=3, r=end_bolt*1.425);
        translate([length, 0, 0])
            cylinder(h=3, r=end_bolt*1.2);
    }
}
   
   sphere(1);
   }
   
   for(i=[0:5])
       rotate(i*60+30)
            translate([bolt_d, 0, 0])
            cylinder(h=16, r=bolt_d*.06, center=true);
   
   translate([0,0,-3]) { 
    cylinder(r=bolt_d/2, h=14);
    for(x=[0:2])
        translate([length-x*end_bolt*4, 0, 0])
            cylinder(h=8, r=end_bolt/2);
}

translate([-2, 0, 3])
  rotate(-90, [0, 1, 0])
     cylinder(h=12, r=1.5);
}


