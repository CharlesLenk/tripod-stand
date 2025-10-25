include <openscad-utilities/common.scad>

tripod_stand(50);

module tripod_stand(width) {
	height = 1.5 * width;

	leg_d = 5;
	top_r = leg_d/2 + 2;

	leg_angle = 30;

	tilt_angle = atan(width/height);
	c_hypoteneuse = top_r * sin((180 - leg_angle)/2) / sin(leg_angle/2);

	adjacent = sqrt(height ^ 2 + width ^ 2);
	hypoteneuse = adjacent / cos(leg_angle/2);
	opposite = sin(leg_angle/2) * hypoteneuse;

	cut_depth = 1;
	angle = 240;
	xy_cut() {
		translate([0, 0, leg_d/2 - cut_depth]) {
			leg();
			translate([opposite, 0]) rotate(angle) translate([opposite, 0]) leg();
			translate([-opposite, 0]) rotate(-angle) translate([-opposite, 0]) leg();
		}
	}

	module leg() {
		rotate([tilt_angle, 0, 0]) {
			translate([opposite, 0]) {
				rotate([0, -leg_angle/2, 0]) {
					translate([-top_r, 0, hypoteneuse - c_hypoteneuse]) {
						rotate([90, 0, 0]) {
							rotate_extrude(angle = 180 - leg_angle) {
								translate([top_r, 0, 0]) {
									circle(d = leg_d);
								}
							}
						}
					}
				}
			}
			translate([opposite, 0]) {
				rotate([0, -leg_angle/2, 0]) {
					sphere(d = leg_d);
					cylinder(d = leg_d, h = hypoteneuse - c_hypoteneuse);
				}
			}
			translate([-opposite, 0]) {
				rotate([0, leg_angle/2, 0]) {
					sphere(d = leg_d);
					cylinder(d = leg_d, h = hypoteneuse - c_hypoteneuse);
				}
			}
		}
	}
}
