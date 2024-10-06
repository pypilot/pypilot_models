$fn=60;

cup_d = 45;
cup_r = 50;

bearing_d = 22.4;
bearing_h = 7.3;

angle=86;

pipe_d=9.2;

magnet_d=4.1;

key_r=.9;

rotate([0, -90, 0])
difference() {
    union() {
        translate([0, 0, -bearing_h])
        
        minkowski() {
            union() {
                translate([0,0, -5])
                cylinder(r2=bearing_d/2+1, r1 = pipe_d/2, h=5);
                cylinder(r=bearing_d/2+1, h=bearing_h*2+key_r*2);
            }
            sphere(1.4);
        }
              difference() {
                rotate([angle, 0, 0]) {
                   cylinder(r=cup_d/8, h=cup_r);
                   scale([.7, 1, 1]) {
                      translate([0, 0, cup_r*3/4])
                         cylinder(r1=cup_d/8, r2=cup_d/3, h=cup_r/3);
                      translate([0, 0, cup_r*1/5])
                         cylinder(r2=cup_d/8, r1=cup_d/6, h=cup_r/3);
                   }
                   translate([cup_r/8, 0, cup_r+cup_d/3])
                      sphere(cup_d/2);
                }
                translate([0, -cup_r-cup_d, -cup_d/2]) 
                    cube([cup_d, cup_d*3, cup_d*2]);
                rotate([angle, 0, 0]) 
                  translate([cup_r/8, 0, cup_r+cup_d/3])
                     sphere(.94*cup_d/2);
            }
            
            rotate(180+60)
                rotate([angle, 0, 0])
                   scale([.7, 1, 1])
                      translate([0, 0, cup_r*1/5]) {
                          d=.6;
                         cylinder(r2=(cup_d/8*d+cup_d/6*(1-d)), r1=cup_d/6, h=cup_r/3*d);
                          translate([0, 0, cup_r/3*d-.01])
                              minkowski() {
                                hull() {
                                    cylinder(r=(cup_d/8*d+cup_d/6*(1-d))-2, h=.1);
                                        translate([0, 0, 0])
                                            cylinder(r=4-2, h=1);
                                }
                              sphere(2);
                            }
                        }
    }
    
    translate([0, 0, -20])
        rotate(-90)
            cube([40, 40, 40]);

    translate([0, -9, -20])
        cylinder(r=1.7, h=40);

    rotate(60+180)
    translate([-1, -17, 1.5])
        rotate([0, 90, 0]) {
            cylinder(r=1, h=10);
            translate([0, 0, 3.5])
            cylinder(r1=1, r2=3, h=3);
        }


    translate([-5, -17, 1.5])
        rotate([0, 90, 0])
            cylinder(r=1, h=10);

    translate([0, 0, -20])
    rotate(60)
    difference() {
        translate([0, -20, 0])
            cube([40, 50, 40]);
        translate([0, 9, 0])
                cylinder(r=1.5, h=40);
    }
    

  translate([0, 0, -1])
    cylinder(r=bearing_d/2, h=bearing_h);
  translate([0, 0, -2])
    cylinder(r=bearing_d/2-2, h=bearing_h+2);

  cylinder(r=pipe_d/2, h=bearing_h*4, center=true);

  translate([0, 0, -bearing_d/4])
    rotate(-60)
      rotate([90, 0, 0])
        cylinder(r=magnet_d/2, h=bearing_d/2);

}
