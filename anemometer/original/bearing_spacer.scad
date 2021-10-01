$fn=60;

module spacer()
  difference() {
    union() {
        cylinder(r=6/2, h=18, center=true);
    //    cylinder(r=8/2, h=6, center=true);
    }
    cylinder(r=5/2, h=19, center=true);
  }
  

spacer();
//translate([20, 0, 0])
  //  spacer();