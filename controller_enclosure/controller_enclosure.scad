$fn=30;

highpower=false;
midpower=true;

width_gap=1.6;
width = (highpower ? 87 : (midpower ? 71 : 51)) + width_gap*2;
length = highpower ? 117 : (midpower ? 104 : 77);

bottom_height = highpower ? 12 : midpower ? 8 : 12;
thickness = 1.2;
top_thickness = 1.2;
bottom_edge = 12;
board_thickness=3;

top_height= highpower ? 40 : midpower ? 21 : 23;

module cubecxy(x, y, z) {
    translate([-x/2, -y/2, 0])
        cube([x, y, z]);
}


mount_gap=highpower ? 5 : 4;
module flange() {
    translate([0, length/2, .2])
    difference() {
        hull() {
            
            if(highpower  || midpower) {
                hull() {
                    translate([-width*.26, 0, 0])
                     rotate(45)
                     minkowski() {
                        cubecxy(width*.25, width*.2, thickness/2);
                        cylinder(r=6, h=mount_gap+bottom_height/3);
                    }
                    translate([ width*.26, 0,0])
                    rotate(-45)
                        minkowski() {
                            cubecxy(width*.25, width*.2, thickness/2);
                            cylinder(r=6, h=mount_gap+bottom_height/3);
                        }
                }
            } else {
                scale([.8,1,1])
                rotate(45)
                minkowski() {
                    cubecxy(width*.6, width*.6, thickness/2);
                    cylinder(r=4, h=thickness);
                }
            }
            
            translate([0, 0, bottom_height*.6])
                scale([1,1,.5])
                rotate([0, 90, 0])
               ;// cylinder(r=bottom_height/3, h=width*.9, center=true);
            }
            
            // screw holes
            if(highpower || midpower) {
                r = highpower ? 3 : 2.4;
                translate([-width/5, width/7, -1])
                    cylinder(r=r, h=bottom_height+mount_gap);
                translate([width/5  , width/7, -1])
                    cylinder(r=r, h=bottom_height+mount_gap);
            } else {
                translate([0, width/4, -1])
                    cylinder(r=2.4, h=bottom_height+mount_gap);
            }
            translate([0, -width/3,-.1])
            cubecxy(width, width/2, mount_gap);
        }
}

module mount() {
    dx = highpower ? 5 : midpower ? 5.5    : 3;
    dy = highpower ? 5 : midpower ? 4.5    : 3;
   translate([dy-width/2+width_gap, dx-length/2, thickness])
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
        translate([0, thickness/4, mount_gap])
        minkowski() {
            cubecxy(width+thickness/2, length, bottom_height-thickness);
            cylinder(r=thickness, h=thickness);
        }
        flange();
        mirror([0, 1, 0])
        flange();

        if(highpower || midpower) {
            z = top_height+14;
            intersection() {
                translate([-2,0,z])
                    rotate([180,0,0])
                    difference() {
                       cable_space(); 
                        cable_holes();
                    }
                translate([width/2-1, -length/2, mount_gap])
                cube([50, length, top_height]);
            }
        }
    }

    translate([0, 0, thickness+mount_gap])
        cubecxy(width, length, bottom_height+thickness);
      all() tabs(mount_gap+.5,2);
  }
  

  // gaps for vents
  all()
  for(i=[0:2])
      translate([width/2-width_gap+.4, (i+.5)*length/8, mount_gap])
            cube([width_gap, length/30, bottom_height]);
  
  
   all()  translate([width/2-1, 0, mount_gap+2])
        rotate([90, 0, 0])
            cylinder(r=2, h=length,center=true);
   translate([0,0,mount_gap])
        all() mount();

    // cooling fins
    c =highpower?5:midpower ?4:0;
    if(c)
        both()
    for(i=[0:c])
      translate([0,9.5*i,mount_gap-1])
      scale([1,1,2.8])
        rotate([0, 90, 0])
            cylinder(r=1, h=width,center=true);
}

module cable_hole(cable_r) {
    translate([-.1,0,top_height-9])
    rotate([0, 90, 0])
    union() {
             cylinder(r=cable_r, h=2*thickness+2);
        translate([-30,0,0])
            cylinder(r=cable_r, h=2*thickness+2);
    }
}

module cable_holes() {
  translate([width/2, 0, 0])
    if(highpower) {
            hull() {
                translate([2, 45, 4])
                    cable_hole(3);
                translate([2, 11, 4])
                    cable_hole(3);
            }
            hull() {
                translate([2, -13, 4])
                    cable_hole(3);
                translate([2, -23, 4])
                    cable_hole(3);
            }        
            hull() {
                translate([2, -38, 4])
                    cable_hole(3);
                translate([2, -48, 4])
                    cable_hole(3);
            }        
   
   } else if(midpower) {
       hull() {
       cable(26);
       cable(6);
       }
       
       hull() {
       cable(-23);
       cable(-33);
       }
   }
}

module cable(x) {
    translate([1, x, 3])
    translate([-.1,0,top_height-9])
    rotate([0, 90, 0])
    scale([1,3,1])
             cylinder(r=3.5, h=4*thickness+2);
}

module cable_space() {
  translate([width/2, 0, 0])
    if(highpower) {
            hull() {
                translate([2, 45, 4])
                    cable_hole(3);
                translate([2, 11, 4])
                    cable_hole(3);
            }
            hull() {
                translate([2, -13, 4])
                    cable_hole(3);
                translate([2, -23, 4])
                    cable_hole(3);
            }        
            hull() {
                translate([2, -38, 4])
                    cable_hole(3);
                translate([2, -48, 4])
                    cable_hole(3);
            }        
   
   } else if(midpower) {
            hull() {
                translate([1, 33, 5])
                    cable_hole(3);
                translate([1, 1, 5])
                    cable_hole(3);
            }
            hull() {
                translate([1, -1, 5])
                    cable_hole(3);
                translate([1, -41, 5])
                    cable_hole(3);
            }
            hull() {
                translate([-55, 52, 9])
                rotate(90)        cable_hole(3.5);
            } 
   } else {
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
}

module topmount() {
   translate([1-width/2, 1-length/2, thickness])
      cylinder(r=3, h=top_height ); 
}

module tabs(z,l) {
       translate([-top_thickness-width/2, 1-length/2-l, z])
    rotate([-90,0,0])
            cylinder(r=.8, h=7 +2*l);   
}

module air_vent(hole) {
    height=bottom_height+top_height;
    translate([-width/2-thickness, 0, 0]) {
    if(hole) {
        rotate([0,-90,0]) 
        translate([height/2,0,0])
            cylinder(r=3,h=4.1);
    } else {
        difference() {
            cylinder(r=6.2,h=height);
                translate([0,0,-.1])
            cylinder(r=5,h=height+1);
                translate([0,-30,-1])
                    cube([60, 60, 60]);
        }
        rotate([0,-90,0]) 
        hull() {
            translate([3,0,0])
                cylinder(r=3,h=1);
            translate([height/2,0,2.8])
                cylinder(r=3,h=1);
            translate([height-3,0,0])
                cylinder(r=3,h=1);
        }
    }
}
}

module air_vents(hole) {
    for(i=[-2:2])
        translate([0,i*20,0])
            air_vent(hole);
}
    

module top() {
    difference() {
        union() {
            minkowski() {
                cylinder(r=thickness,h=thickness);
                translate([0, 0, 0])
                    cubecxy(width+2.5*top_thickness, length+2*top_thickness, top_height+bottom_height+top_thickness);
            }
            if(highpower) {
                    translate([width/2+thickness+top_thickness+2, -1, top_thickness])
                        cylinder(r=5, h=top_height+bottom_height+thickness);
                    translate([width/2+thickness+top_thickness+2, -30, top_thickness])
                        cylinder(r=5, h=top_height+bottom_height+thickness);
            } else if(midpower) {
                    translate([width/2+thickness+top_thickness+2, -8, top_thickness])
                        cylinder(r=5, h=top_height*.7);
            } else {
                for(i=[-1:0])
                    translate([width/2+thickness+top_thickness+2, 9.5+i*23, top_thickness])
                        cylinder(r=3.5, h=top_height+bottom_height+thickness);
            }
            for(i=[-18:16]) {
                translate([width/2+2*thickness, 3*i+2, 0])
                union() {
                    translate([0, 0, top_thickness])
                        cylinder(r=2., h=top_height+bottom_height+thickness);
                    translate([0, 0, 2.])
                        sphere(r=2.);
                 }
             }
             
             air_vents(false);
        }
        air_vents(true);
        fit_width=.6;
        translate([0, 0, top_thickness])
            cubecxy(width+2.5*thickness+fit_width, length+2*thickness+fit_width, top_height+bottom_height);
        translate([0, 0, top_thickness + top_height])
            cubecxy(width+2*thickness+fit_width, length+2*thickness+fit_width, bottom_height+thickness*3);
        hull() {
        translate([0, 0, top_height+bottom_height+thickness*2+.01+mount_gap]) 
        scale(1.03)
            mirror([0,0,1]) {
                flange();
                mirror([0, 1, 0])
                    flange();
            }
            translate([0, 0,100])
            cubecxy(width, length, thickness);
        }
        cable_space();
            cable_holes();

    }
        
    if(!highpower && !midpower)
        translate([width/2+3, 9.5, thickness])
            cylinder(r=4.5, h=top_height);

    all() topmount();
    all() tabs(top_height+bottom_height+top_thickness+.4, 0);

    font = "Liberation Sans";
    translate([0,0, 2])
    rotate(180, [0, 1, 0])
    rotate(-90)
        linear_extrude(height = 2)
            text("pypilot", size = highpower ? 25 : (midpower ? 20 : 15), font=font, halign = "center", valign = "center", $fn = 16);
}

//translate([1.4*width, 0, 0])
   bottom();



translate([0,0,35])
rotate([180,0,0]) 
{


//top();

}