screw_radius = 2;
$fn=30;


difference() {
    union() {
        minkowski() {
            cube([10, 32, 3], center=true);
            sphere(1);
        }
        minkowski() {
            sphere(1);
        hull() {
            cube([8, 14, 3], center=true);
            translate([0, 0, 5])
                rotate([0,90,0])
                    cylinder(r=3, h=8, center=true);
        }
    }
    }
    translate([0, 12, 0])
        cylinder(r=screw_radius, h=6, center=true);
    translate([0, -12, 0])
        cylinder(r=screw_radius, h=6, center=true);

        cylinder(r=1.5, h=20, center=true);
    
    translate([0,0,-.5])
    cylinder(r=3, h=4.2,center=true);
}


