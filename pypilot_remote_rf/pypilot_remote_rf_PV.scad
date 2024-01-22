$fn=40;

length=65;
width=33;
height = 10;

module board() {
    scale(1.012)  // easier fit
    linear_extrude(3)
   import("pypilot_remote_rf.svg");
}

module bumps() {
    for(i=[-1:1]) {
    translate([i*20, width/2+5, .5])
    minkowski() {
        cylinder(r=3, h=height-1,center=true);
        sphere(2);
    }
}
}

module enclosure() {
    difference() {
        union() {
            minkowski() {
                cube([length,width,height], center=true);
                cylinder(r=6, h=1);
                sphere(1);
            }
            bumps();
            mirror([0,1,0])
            bumps();
        }
        translate([0, 0, -4])
            minkowski() {
                cube([length-2,width-2,height+12], center=true);
                cylinder(r=4, h=1);
            }

        translate([-length/2-6,-width/2-6, height/2-1])
            board();
    }
}

pvlen=52;
pvwid=30;

module lid()
{
scale(.99)
    difference() {
        translate([0,0,-height/2-1])
        minkowski() {
        cube([length, width, 2], center=true);
            cylinder(r=6, h=1);
        }
        enclosure();
        translate([0,0,-height/2-2])
        cube([pvlen, pvwid,2],center=true);

        translate([pvlen/2-2,pvwid/2-2,-height/2-2])
            cylinder(r=2,h=5);
        translate([-pvlen/2+2,pvwid/2-2,-height/2-2])
            cylinder(r=2,h=5);        
    }
}

lid();

//enclosure();
