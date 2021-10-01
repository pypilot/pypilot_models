$fn=60;

mount_pipe_diameter = 25.4; // 1 inch
vane_pipe_diameter = 19;


difference(){
    cube([mount_pipe_diameter, vane_pipe_diameter,( mount_pipe_diameter+vane_pipe_diameter)/4], center= true);
    translate([0, 0, mount_pipe_diameter/2])
        rotate([90, 0, 0])
            cylinder(r=mount_pipe_diameter/2, h=vane_pipe_diameter+1,center=true);
    translate([0, 0, -vane_pipe_diameter/2])
        rotate([0, 90, 0])
            cylinder(r=vane_pipe_diameter/2, h=mount_pipe_diameter+1,center=true);
}