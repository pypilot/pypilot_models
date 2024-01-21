$fn=40;

uselip=false;


module panel(h)
{
     if(1)   linear_extrude(height=h) {
  
       import("pypilot_remote_rf.svg");    
            
            
    }
    if(1)
    translate([5.5, 5, 0])
    minkowski() {
    cube([66, 34.5, 10]);
        cylinder(r=5,h=10);
    }
}


w=74;
h=43;
r=5;
d=15;
t=2;
module face() {
difference() {
    minkowski() {
        cube([w-2*(t+r),h-2*(t+r),d]);
        cylinder(r=r, h=.1);
    }
}
}

module face2() {
difference() {
    translate([1,1,0])
    minkowski() {
        cube([w-2*(t+r)-2,h-2*(t+r)-2,d]);
        cylinder(r=r, h=.1);
    }
}
}

module screw()
{
    cylinder(r=1.8, h=20);
    translate([0,0,8])
    cylinder(r1=1.8, r2=4, h=4);
}

difference() {  
    minkowski() {
        cube([76, 44, uselip ? 12 : 10.5]);
        cylinder(r=5,h=.1);
    }

    translate([-.5, -.5, 7.8])
    scale(1.005)
       panel(3.5);

    translate([8, 7.5, 1])
       face();

    //translate([7, 6.5, -3])
    //face2();

    translate([10, 9.5, -3])
        cylinder(r=7, h=10);

    translate([66, 34.5, -3])
        cylinder(r=7, h=10);

    
    translate([-10,27,6 ])
        rotate([0,90,0])
            cylinder(r=2.3, h=20);

    translate([-1,-1,0])
        screw();

    translate([77,-1,0])
        screw();

    translate([77,45,0])
        screw();

    translate([-1,45,0])
        screw();

translate([20,-4.5,(uselip ? 4 : 3)])
rotate([90,0,0])
linear_extrude(2)
text("pypilot",  size=7);


}
