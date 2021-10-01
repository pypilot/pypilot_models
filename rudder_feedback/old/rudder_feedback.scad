
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

module holder() {
difference() {
    hull() {
        cylinder(r=total_radius, h=1);
        translate([0, 0, total_height/3-.5]) {        
            translate([0, 0, total_height*2/3-.5])
                 cylinder(r=total_radius/2, h=1);
        }
    }
    translate([-total_radius, 0, -1])
        ;//cube(total_height);
    ocylinder(r=3, h=total_height);

    translate([-total_radius*1.4/2, -total_radius*1.1/2, -.1])
       cube([total_radius*1.4, total_radius*1.1, bottom_thickness+.3]);

    translate([0, 0, bottom_thickness]) {

    translate([-board_dimension/2, -board_dimension/2, -.1])
       cube([board_dimension, board_dimension, board_thickness+.3]);

    translate([0, 0, board_thickness]) {
    ocylinder(r=magnet_diameter/2, h = bolt_height);
    
    translate([0, 0, bolt_height]) {
        ocylinder(r=magnet_diameter/2+1, h=magnet_height);
        translate([0, 0, magnet_height]) {
            ocylinder(r=magnet_diameter/2+1, h=nut_height);
            translate([0, 0, nut_height]) {
                ocylinder(r=bearing_diameter/2, h=bearing_height);
                translate([0, 0, bearing_height + bearing_spacing])
                    ocylinder(r=bearing_diameter/2, h=bearing_height);                
            }
        }
    }
}
}
  screw_holes(true);
}
}

module screw_holes(pan=false) {
 for(i=[0:1]) {
        rotate(180*i)
            translate([10, 0, -1]) {
                if(pan)
                    cylinder(r1=3, r2=1, h=bottom_thickness);
                cylinder(r=1, h=10);
            }
   }
}


board_dimension= 18;
screw_diameter=4;

difference() {  union() {
    holder();
    if(bottom_support)
      difference() {
        hull() {
            for(i=[0:2]) {
                rotate(120*i)
                    translate([total_radius+total_height/16, 0, 0])
                        cylinder(h=3, r=total_height/6);
            }
            cylinder(r=total_radius, h=3);
            cylinder(r=1, h=10);
        }
        ocylinder(total_radius-2, 10);
        for(i=[0:2]) {
            rotate(120*i)
               translate([total_radius+total_height/16, 0, 0])
                ocylinder(screw_diameter/2, 6);
        }
        
    }

    if(side_support)
    translate([-total_radius, 0, total_height*2/3])
    rotate(90, [0, 1, 0])
      union() {
        translate([0, -total_radius, 0])
            difference() {
                cylinder(r=total_height/4, h=3);
                ocylinder(screw_diameter/2, 3);
            }
        translate([0, total_radius, 0])
            difference() {
                cylinder(r=total_height/4, h=3);
                ocylinder(screw_diameter/2, 3);
            }

       hull() {
          translate([0, 0, 6])
             cube([5, 10, 3], center=true);
          translate([0, 0, 2])
             cube([total_height/3, total_radius*1.6, 3], center=true);
        }
    }
  }
  // hole for wires
  translate([0, 0, bottom_thickness+board_thickness/2])
    rotate(90, [1, 0, 0]) {
      cylinder(r=2, h=1.8*total_radius);
        // cut away for zip tie strain relief
      cylinder(r=3, h=board_dimension/2);
    }
}

size=1.0;
translate([40, 0, 0])
difference() {
    intersection() {
        translate([-total_radius*1.4/2+size/2, -total_radius*1.1/2+size/2, 0])
            cube([total_radius*1.4-size, total_radius*1.1-size, bottom_thickness]);
        ocylinder(total_radius-2, bottom_thickness);
    }
    screw_holes(true);
}
  
