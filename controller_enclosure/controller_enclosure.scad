$fn=42;

width = 51;
length = 77;

bottom_height = 12;
thickness = 1.2;
top_thickness = 2.2;
bottom_edge = 12;
board_thickness=2;

top_height=23;

module cubecxy(x, y, z) {
    translate([-x/2, -y/2, 0])
        cube([x, y, z]);
}


mount_gap=5;
module flange() {
    translate([0, length/2, 0])
        difference() {
            hull() {
                scale([.8,1,1])
                rotate(45)
                minkowski() {
                    cubecxy(width*.6, width*.6, thickness/2);
                    cylinder(r=4, h=thickness);
                }
                
                translate([0, 0, bottom_height*.6])
                scale([1,1,.5])
                rotate([0, 90, 0])
                cylinder(r=bottom_height/3, h=width*.8, center=true);
            }
            translate([0, width/4, -1])
                cylinder(r=2.4, h=bottom_height);
            translate([0, -width/3,-.1])
            cubecxy(width, width/2, mount_gap);
        }
}

module mount() {
   translate([4-width/2, 4-length/2, thickness])
    difference() {
            cylinder(r=5, h=bottom_height-board_thickness-.7);
        cylinder(r=1.5, h=bottom_height+1);
    }
}

module both() {
    children();
    mirror([0, 1, 0])
    children();
}

module all() {
    both()
        children();
    mirror([1, 0, 0])
        both()
            children();
}
module bottom() {
  difference() {
    union() {
        translate([0, 0, mount_gap])
        cubecxy(width+3*thickness, length+2*thickness, bottom_height+thickness);
        flange();
        mirror([0, 1, 0])
        flange();
    }
    translate([0, 0, thickness+mount_gap])
        cubecxy(width, length, bottom_height+thickness);
  }
all()  translate([width/2-1, 0, mount_gap+2])
    rotate([90, 0, 0])
        cylinder(r=2, h=length,center=true);
  translate([0,0,mount_gap])
  all() mount();
}

module cable_hole(cable_r) {
    translate([-.1,0,top_height-9])
    rotate([0, 90, 0])
    union() {
             cylinder(r=cable_r, h=3*thickness+2);
        translate([-30,0,0])
            cylinder(r=cable_r, h=3*thickness+2);
    }
}

module cable_holes() {
    hull() {
      translate([2, 26, 4])
      cable_hole(3);
      translate([2, 17, 4])
      cable_hole(3);
    }
    hull() {
        translate([2, 2, 4])
        cable_hole(3);
        translate([2, -7, 4])
        cable_hole(3);
    }        
   hull() {
        translate([-12, -43, 10])
       rotate(90)        cable_hole(3.5);
    }
   hull() {
        translate([2, -30, 4])
      ;//  cable_hole(3.5);
    }    
}
    
module topmount() {
   translate([1-width/2, 1-length/2, thickness])
            cylinder(r=3, h=top_height );
}
module top() {
    difference() {
        union() {
            minkowski() {
                cylinder(r=thickness,h=thickness);
                translate([top_thickness/2, 0, 0])
                    cubecxy(width+3*top_thickness, length+2*top_thickness, top_height+bottom_height+top_thickness);
            }
            for(i=[-1:0])
                translate([width/2+thickness+top_thickness+2, 9.5+i*23, top_thickness])
                     cylinder(r=3.5, h=top_height+bottom_height+thickness);

            for(i=[-10:9]) {
                translate([width/2+3*thickness, 4*i+2, 0])
                union() {
                    translate([0, 0, top_thickness])
                        cylinder(r=2.7, h=top_height+bottom_height+thickness);
                    translate([0, 0, 2.7])
                        sphere(r=2.7);
                 }
             }
        }
        fit_width=.6;
        translate([thickness/2, 0, top_thickness])
            cubecxy(width+3*thickness+fit_width, length+2*thickness+fit_width, top_height+bottom_height);
        translate([thickness/2, 0, top_thickness + top_height])
            cubecxy(width+3*thickness+fit_width, length+2*thickness+fit_width, bottom_height+thickness*3);
        hull() {
        translate([thickness/2, 0, top_height+bottom_height+thickness*2+.01+mount_gap]) 
            mirror([0,0,1]) {
                flange();
                mirror([0, 1, 0])
                    flange();
            }
            translate([0, 0, 100])
            cubecxy(width, length, thickness);
        }
        translate([width/2, 0, 0])
            cable_holes();

// window?? no            
            //translate([-width/4, -length/4,-.5])
        //cube([10, 20, thickness+1]);
        
    }
    translate([width/2+3, 9.5, thickness])
        cylinder(r=4.5, h=top_height);
    translate([0, 0, top_height+bottom_height])
    knobs(.8);
    all() topmount();

    font = "Liberation Sans";
    translate([0,0, 3.2])
    rotate(180, [0, 1, 0])
    rotate(-90)
        linear_extrude(height = 3.2)
            text("pypilot", size = 15, font=font, halign = "center", valign = "center", $fn = 16);
}

//translate([1.4*width, 0, 0])
//    bottom();

top();
