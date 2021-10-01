$fn=60;

bottom_support=1;
side_support=0;

bearing_diameter = 11;
bearing_height = 3.8;
magnet_diameter = 13;
magnet_height = 4.2;

bolt_height = 3.6;
nut_height = 4.8;
bolt_radius=4.7;
bearing_spacing = 6.6;
board_thickness = 3.5;
bottom_thickness = 1.6;

total_height = bolt_height+magnet_height+nut_height+bearing_height+bearing_spacing+bearing_height+board_thickness + bottom_thickness;

module ocylinder(r, h) {
    translate([0, 0, -.1])
        cylinder(r=r, h=h+.2);
}

total_radius = total_height*.5;

board_dimension=18;
screw_diameter=4;

module mount() {
    difference() {  union() {
      difference() {
        hull() {
            translate([20, 0, -19])
            rotate([0, 30, 0])
            cylinder(r=10, h=2, center=true);
            for(i=[0:2]) {
                rotate(120*i)
                    translate([total_radius+total_height/16, 0, 0])
                        cylinder(h=3, r=total_height/6);
            }
         }
        for(i=[0:2]) {
            rotate(120*i)
               translate([total_radius+total_height/16, 0, 0])
                ocylinder(screw_diameter/2, 6);
        }
        
    }
    }

}


}

union() {
    translate([0, 0, -12])
    cylinder(r=70, h=2, center=true);
    
rotate([0, -30, 0])
    mount();
hull() {
    difference() {
        rotate([0, -30, 0])
              mount();
        translate([0, 0, 22])
        cube([100, 100, 50], center=true);
    }
    translate([0, 0, -12])
    cylinder(r=50, h=2, center=true);
}
}