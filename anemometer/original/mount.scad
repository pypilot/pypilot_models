$fn=60;

support_diameter = 15.6;
pole_diameter = 12.4;

module base() {
    difference() {
        translate([0, 0, 5])
            minkowski() {
                cube([56, 31, 6],center=true);
                sphere(2);
            }
        for(j=[0:1]) for(i=[0:1]) {
            translate([22-44*j, 11-22*i, 0])
                cylinder(r=2.4, h=21, center=true);
        }
    }
}

difference() {
    union() {
        base();
        translate([0, 0, 7])
            cylinder(r1=(support_diameter+4)*1.8/2, r2=(support_diameter+4)/2, h=30);
        translate([0, 0, 8])
            difference() {
                rotate([0, 45, 0])
                    minkowski() {
                        cube([39, 6, 39],center=true);
                        sphere(2);
                    }
                translate([0, 0, -20])
                cube([60, 60, 30], center=true);
            }
    }
    translate([0, 0, -.1])
        cylinder(r=support_diameter/2, h=40);
    
    rotate([0, 90, 0])
        cylinder(r=pole_diameter/2, h=62, center=true);
    
    // route for wires
    translate([0, 0, pole_diameter/2+2]) {
    rotate([0, 90, 10])
        scale([1, .5, 1])
            cylinder(r=3.4, h=20);
    translate([18, 3.3, 0])
    rotate([0, 90, -10])
        scale([1, .5, 1])
            cylinder(r=3.4, h=20);
    }
}