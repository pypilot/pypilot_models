$fn = 60;

board_length = 49;
board_width = 21;
board_height=17;
thickness = 2;
fit=.4;

module plate() {
            rotate(60)
        translate([-board_width*.2, -board_width*.7, 0])
        cube([board_width, board_width, thickness*2]);
}

module screw_holder() {
    difference() {
       hull() {
            plate();
            mirror()
                plate();
           }       
    hull() {
        translate([0, board_width*.7, -thickness])
            cylinder(r=2, h=15);
        translate([0, board_width, -thickness])
            cylinder(r=2, h=15);
    }
   }
}

if(1) 

union() {
difference() {
    union() {
        translate([-board_length/2-thickness, -board_width/2-thickness, 0])
            cube([board_length+thickness*2, board_width+thickness*2, board_height]);
        screw_holder();
        mirror([0,1,0])
        screw_holder();
    }

    translate([-board_length/2, -board_width/2, thickness])
        cube([board_length, board_width, board_height]);
  /*  
    translate([board_length/4, 0, 0])
        cylinder(r=1.5, h=5, center=true);
    translate([-board_length/4, 0, 0])
        cylinder(r=1.5, h=5, center=true);
    */
    
    hull() {
        translate([board_length/2-2, -5.5, 5.9])
            cube([5, 6.5, 1.5]);
        translate([board_length/2-2, -6, 8.5])
           cube([5, 7.6, 2]);
    }
    
    
    translate([-board_length/2-thickness*2, 0, 9]) {
       translate([0, -7.5, 0])
            rotate([0, 90, 0])
               cylinder(r=1.7, h=5);
        translate([0, -2.5, 0])
            rotate([0, 90, 0])
                cylinder(r=1.7, h=5);
        translate([0, 2.5, 0])
            rotate([0, 90, 0])
                cylinder(r=1.7, h=5);
        translate([0, 7.5, 0])
            rotate([0, 90, 0])
                cylinder(r=1.7, h=5);
    }
}

translate([board_length/2- 3, board_width/2-3, 0])
    cylinder(r=2, h=2+thickness);
translate([board_length/2- 3, -board_width/2+3, 0])
    cylinder(r=2, h=2+thickness);
translate([-board_length/2+ 3, board_width/2-3, 0])
    cylinder(r=2, h=2+thickness);
translate([-board_length/2+ 3, -board_width/2+3, 0])
    cylinder(r=2, h=2+thickness);
}

if(0)
translate([0, board_width*2, 0])
    difference() {
        translate([-board_length/2-thickness*2-fit, -board_width/2-thickness*2-fit, 0])
            cube([board_length+thickness*4+fit*2, board_width+thickness*4+fit*2, board_height+thickness]);
        translate([-board_length/2-thickness-fit, -board_width/2-thickness-fit, thickness])
            cube([board_length+thickness*2+fit*2, board_width+thickness*2+fit*2, board_height+thickness]);
        
        translate([board_length/2, -board_width/2+2, 8])
            cube([5, board_width-4, 12]);
        translate([-board_length/2-5,-board_width/2+2.5, 7.5])
           cube([6, 11, 6]);

        translate([0,0,board_height+13])
     rotate([90,0,0])
     cylinder(r=18, h=board_width*2, center=true);   
 }