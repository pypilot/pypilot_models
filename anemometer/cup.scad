$fn=60;

cup_d = 45;
cup_r = 50;

bearing_d = 22.2;
bearing_h = 7;

angle=86;

pipe_d=10;

magnet_d=4.1;

key_r=.9;

difference() {
    union() {
        translate([0, 0, -bearing_h])
        
        minkowski() {
            cylinder(r=bearing_d/2+1, h=bearing_h*2+key_r*2);
            sphere(1.4);
        }
        translate([0, 0, bearing_h-key_r])
            minkowski() {
                cylinder(r=bearing_d/2+1.5, h=key_r*2);
                sphere(1.4);
            }
        for(i=[0:2])
            rotate(i*120) {
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
         }
    }

  translate([0, 0, -1])
    cylinder(r=bearing_d/2, h=bearing_h*2);
  translate([0, 0, -2])
    cylinder(r=bearing_d/2-2, h=bearing_h*2);

  cylinder(r=pipe_d/2, h=bearing_h*3, center=true);
  translate([0, 0, -bearing_d/4])
    rotate(60)
      rotate([90, 0, 0])
        cylinder(r=magnet_d/2, h=bearing_d/2);

  for(i=[0:2])
      translate([0, 0, bearing_h-.2])
        rotate(60+120*i)
          rotate([90, 0, 0])
            cylinder(r=key_r, h=bearing_d*2);

}
