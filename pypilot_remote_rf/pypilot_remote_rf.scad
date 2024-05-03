$fn=40;

// for aaa
aaa = true;
length=79;
width=46;
height = aaa ? 31 : 15;

module lid(lsize) {
    translate([0,3,0])
    minkowski() {
        cube([length+2*lsize-6, width+-1+lsize, 1.5+lsize], center=true);
        cylinder(r=4, h=.6);
    }
}

module board() {
    scale(1.012)  // easier fit
    linear_extrude(height+2)
   import("pypilot_remote_rf.svg");
}

module screw() {
    cylinder(r=1.4, h=10);
    translate([0,0,10])
    cylinder(r1=1.4, r2=3.2, h=3);
}

module screws() {
    translate([78,0,2]) {
       translate([0,12,0])
        screw();
        translate([0,32,0])
        screw();
    }
}

module slot() {
    hull() {
            cylinder(r=1.6, h=5);
            translate([-10,0,0])
            cylinder(r=1.6, h=5);
    }
}

module flange() {
   translate([-8-length/2,7-width/2,height/2-3])
    difference() {
        minkowski() {
            cube([16, width-10, 2]);
            cylinder(r=3,h=2);
        }
        translate([0,8,-1])
        slot();
        translate([0,28,-1])
        slot();
    }
}

module enclosure(lsize=0) {
        difference() {
        union() {
            minkowski() {
                cube([length,width,height-4], center=true);
                union() {
                    sphere(r=4);
                    translate([0,0,2])
                        cylinder(r=4, h=2);
                }
            }
            translate([0,-4,1]) {
                flange();
                mirror([1,0,0])
                    flange();
            }
        }

    translate([0, 1, -4])
    minkowski() {
        cube([length-18,width-18,height], center=true);
        cylinder(r=4, h=1);
    }

translate([-76/2-1,-45/2+1, -height/2])
    board();


if(aaa) {
translate([0, 0,height/2-1.5])
    lid(lsize);
} else {
    translate([0,0,height/2-2])
        lid(lsize);
}

translate([0,width-4,height/2+2.9])
    cube([length+25, width, 10], center=true);

}

}

if(0) {
    enclosure(.4);
}else{
    scale([.995,1,.9])
//translate([0,-60, 1.5]) 
    rotate([180,0,0])
    intersection()
    {
        difference() {
            translate([0,-1,height/2+1])
                cube([length+7, width+6, 3.5],center=true);
            translate([0,0, height+.5])
            scale([1,1.01,1])
                rotate([180,0,0])
                 #  enclosure();
            rotate(180)
             translate([length/2-8,-3,height/2-2.5])
                 mirror([1,0,0])
             linear_extrude(2.2)
                 text("pypilot",  size=16);
        }
        translate([0,-2,2])
        minkowski() {
            cube([length-1, width-3.5, height], center=true);
                            sphere(r=4);
        }
    }
}