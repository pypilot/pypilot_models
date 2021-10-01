$fn=40;

support_diameter = 15.6;
radius = 13;

top_ball_bearing = 1;
top_bearing_diameter = 17.8;
top_bearing_height = 6.4;
top_bearing_spacing = 6;
top_bearing_inside = 14;

top_sleeve_size=6.5;
top_sleeve_inside = 5.2;

magnet_height = 15;
magnet_diameter = 14;

bottom_ball_bearing = 1;
bottom_bearing_diameter = 17.8;
bottom_bearing_height = 6.4;
bottom_bearing_spacing = 6;
bottom_bearing_inside = 14;
bottom_nut_height = 1;

bottom_sleeve_size=6.5;
bottom_sleeve_inside = 5.2;

bottom_bolt_height = 7;
bottom_bolt_diameter = 14;

reed_sensor=0;
reed_offset=9.4;
reed_diameter=2.8;
reed_length=17;

hall_sensor=1;
hall_offset=8;

height = 80;

 fit = 0.4;

module screw_hole(h, r) {
        union() {
            cylinder(h=h, r=r);
            translate([0, 0, 12])
            cylinder(h=7, r2=6, r1=r);
        }
}

module body() {
  difference() {
   union() {
     cylinder(h=height*2/3, r=radius, center=true);
      rotate(90, [1, 0, 0])
        cylinder(h=support_diameter*2, r1=radius, r2=support_diameter/2+2);
      translate([0, 0, -height*7/18+1])
        cylinder(h=height/9+1, r=radius*.9, center=true);
       translate([0, 0, -height*8/18-1.5])
       cylinder(h=height/18+1, r=1*radius, center=true);

       // top cone
      translate([0, 0, height/3])
        cylinder(h=height/5, r1=radius*1.1, r2=radius*.8 + .5);
       
       // support for speed wiring
        translate([0, -reed_offset,  bottom_bearing_start + height/4+1])
            cylinder(h=height/2, r=reed_diameter/2+1.2, center=true);
   }

    // vane bearing holder
    if(top_ball_bearing) {
     translate([0, 0, height/2-top_bearing_height/2+.1-1])
      cylinder(h=top_bearing_height, r=top_bearing_diameter/2, center=true);
     translate([0, 0, height/2 - top_bearing_height*3/2 - top_bearing_spacing-1])
      cylinder(h=top_bearing_height, r=top_bearing_diameter/2, center=true);
     translate([0, 0, height/2 - top_bearing_height - top_bearing_spacing/2-1]) {
        cylinder(h=top_bearing_spacing+2, r=    top_bearing_diameter/2 - fit*2, center=true);
        cylinder(h=top_bearing_spacing+top_bearing_height*2+3, r=    top_bearing_inside/2, center=true);
     }
       translate([0, 0, height/2 - top_bearing_height - top_bearing_spacing/2-1]) {
          cylinder(h=top_bearing_spacing+2, r=    top_bearing_diameter/2 - fit*2, center=true);
          cylinder(h=top_bearing_spacing+top_bearing_height*2+3, r=top_bearing_inside/2, center=true);
       }
     } else {
        translate([0, 0, height/2 - top_bearing_height - top_bearing_spacing/2+1])
            cylinder(h=top_bearing_spacing+top_bearing_height*2+3, r= top_sleeve_size/2, center=true);
        translate([0, 0, height/2 - top_bearing_height - top_bearing_spacing/2-1])
            cylinder(h=top_bearing_spacing+top_bearing_height*2+3, r=top_sleeve_inside/2, center=true);
     }

     // magnet
     translate([0, 0, height/2 - top_bearing_height*2 - top_bearing_spacing - magnet_height/2 -2])
         cylinder(h=magnet_height, r=magnet_diameter/2, center=true);   

   // keyhole
   rotate(90, [0, 1, 0])
   translate([0, -3/2*radius, 0])
       cylinder(h=25, r=1.8, center=true); 
 
   // main cutaway
     cylinder(h=support_diameter, r=support_diameter/2+1, center=true);
 
    bottom_bearing_start=-height/2;
    
    // circuit board
    translate([0, 0, 6])
    cube([18.4, 12, 2], center=true);
    
    // cups bearing holders
        translate([0, 0, bottom_bearing_start+bottom_bearing_height*2+bottom_bearing_spacing+bottom_bolt_height/2+bottom_nut_height-.5])
        cylinder(h=bottom_bolt_height+.1, r=bottom_bolt_diameter/2, center=true);
    
    if(bottom_ball_bearing) {
        translate([0, 0, bottom_bearing_start+bottom_bearing_height*3/2+bottom_bearing_spacing+bottom_nut_height-1])
        cylinder(h=bottom_bearing_height, r=bottom_bearing_diameter/2, center=true);
        translate([0, 0, bottom_bearing_start+bottom_bearing_height+bottom_bearing_spacing/2+bottom_nut_height]) {
            cylinder(h=bottom_bearing_spacing+1, r=bottom_bearing_diameter/2 - 2*fit, center=true);
            cylinder(h=bottom_bearing_spacing+bottom_bearing_height*2+3, r=bottom_bearing_inside/2, center=true);
        }

     translate([0, 0, bottom_bearing_start+(bottom_bearing_height+bottom_nut_height)/2+1])
      cylinder(h=bottom_bearing_height+bottom_nut_height+.1, r=bottom_bearing_diameter/2, center=true);
     } else {
         translate([0, 0, bottom_bearing_start+bottom_bearing_height+bottom_bearing_spacing/2+bottom_nut_height+2])
       cylinder(h=bottom_bearing_spacing+bottom_bearing_height*2+3, r=bottom_sleeve_size/2, center=true);
         translate([0, 0, bottom_bearing_start+bottom_bearing_height+bottom_bearing_spacing/2+bottom_nut_height])
       cylinder(h=bottom_bearing_spacing+bottom_bearing_height*2+3, r=bottom_sleeve_inside/2, center=true);
     }

     // slot for reed sensor
     if(reed_sensor) {
     translate([0, -reed_offset,  bottom_bearing_start + height/4+.2+5])
      cylinder(h=height/2, r=1.2, center=true);
     translate([0, -reed_offset, bottom_bearing_start+.8]) 
       scale([1,1,1.4])
       rotate([0,90,0])
       cylinder(h=reed_length, r=reed_diameter/2, center=true);
     }
     
     if(hall_sensor) {
     translate([0, -reed_offset,  bottom_bearing_start + height/4+.2+1])
      cylinder(h=height/2, r=1.9, center=true);
     translate([0, -hall_offset, bottom_bearing_start+.8-2]) 
       cube([4,4,4], center=true);
     }

    // screw holes    
    rotate([90, 0, 0]) {
       translate([0,  bottom_bearing_start+height/3-17*(1-bottom_ball_bearing), -7]) {
          translate([support_diameter/2, 0, 0])
            screw_hole(h=20, r=1.2);
          translate([-support_diameter/2, 0, 0])
            screw_hole(h=20, r=1.2);
        }
       translate([0,  bottom_bearing_start+height*2/3+15*(1-top_ball_bearing), -7]) {
          translate([support_diameter/2+1, 0, 0])
            screw_hole(h=20, r=1.2);
          translate([-support_diameter/2-1, 0, 0])
            screw_hole(h=20, r=1.2);
        }
    }
    // screw holes
   if(0)
    for(i=[0:2])
        rotate(i*120, [0, 0, 1]) {
         translate([0,-radius-1,bottom_bearing_start+bottom_bearing_height])
    rotate(90, [1, 0, 0])
    cylinder(h=10, r=1.6, center=true);
        }
    
     // cut away support
    translate([0, 6, 0])
    rotate(90, [1, 0, 0])
    cylinder(h=radius*3 + 6, r=support_diameter/2);
  }
}


module pegs(r) {
    for(i=[-1:1]) {
        translate([radius*.85, 0, height/4*i])
            sphere(r, $fn=24);
        translate([-radius*.85, 0, height/4*i])
            sphere(r, $fn=24);
    }
}

if(1) {
// split in half
  union() {  
    intersection() {
        body();
        translate([0, -height/2, 0])
            cube([height, height, height],center=true);
    }
    pegs(1.1);
  }
    translate([3*radius, 0, 0])
        intersection() {    
            rotate(180, [0, 0, 1])
              difference() {
                body();
                pegs(1.2);
              }
            translate([0, -height/2, 0])
                cube([height, height, height],center=true);
        }
} else {
 translate([30, 0, 0])
  intersection() {
    body();
    translate([0, 0, -height/2])
      cylinder(h=12, r1=12.7, r=7.2);
  }

  difference() {
    body();
    translate([0, 0, -height/2])
      cylinder(h=13, r1=13, r2=7.5);
  }
}
