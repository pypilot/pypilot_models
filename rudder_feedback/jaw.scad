$fn=60;

length=120;

module piece() {
    difference() {
        minkowski() {
        hull() {
            cylinder(r=5, h=2.5);
            translate([18, 0, 0])
                cylinder(r=4, h=3);
        }
        sphere(.8);
    }
        translate([18.5, 0, -1])
        cylinder(r=2, h=5);
    }
}

module jaw() {
    rotate([90, 0, 0])
    union() {
        piece();
        translate([0, 0, 10])
        piece();        
    
        cylinder(r=5.8, h=10);
    }
}

difference() {
    jaw();
    translate([0, -6.5, 0])
        rotate(90, [0, 1, 0])
            cylinder(r=1.6, h=20, center=true);        
}

translate([0, 30, 0])
    union() {
        jaw();
        union() {
            translate([-30, -6, 0])
            rotate([0, 90, 0])
            cylinder(r1=3, r2=5.5, h=30);
            translate([-length, -6, 0])
                rotate([0, 90, 0]) 
                    difference() {
                        cylinder(r=3, h=length);
                        cylinder(r=1.4 , h=40,center=true);
                    }
        }
    }
    