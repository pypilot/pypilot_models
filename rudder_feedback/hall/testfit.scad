$fn=60;
difference() {
    cube([200, 25, 30]);
    for(i=[0:8])
       translate([20+20*i, 12.5, 0])
        cylinder(r=5.8+.1*i, h=100, center=true);
}