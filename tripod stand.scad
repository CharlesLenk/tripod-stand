include <openscad-utilities/common.scad>

tripod_stand(50);

module tripod_stand(width) {
	leg_d = 6;
	width = width - leg_d;
	height = 1.5 * width;
	echo(str("\nHeight = ", height, "\n"));

	top_r = leg_d/1.5;
	leg_arch_angle = 30;
	leg_arch_hypotenuse = top_r * sin((180 - leg_arch_angle)/2) / sin(leg_arch_angle/2);

	opposite = width/2;
	adjacent = sqrt(height ^ 2 + width ^ 2);
	hypotenuse = opposite / sin(leg_arch_angle/2);

	cut_depth = 1;
	leg_rotation_angle = 240;
	xy_cut(size = 2 * width) {
		translate([0, 0, leg_d/2 - cut_depth]) {
			leg();
			translate([opposite, 0])
				rotate(leg_rotation_angle)
					translate([opposite, 0])
						leg();
			translate([-opposite, 0])
				rotate(-leg_rotation_angle)
					translate([-opposite, 0])
						leg();
		}
	}

	module leg() {
		leg_tilt_angle = 35;
		rotate([leg_tilt_angle, 0, 0]) {
			translate([opposite, 0]) {
				rotate([0, -leg_arch_angle/2, 0]) {
					translate([-top_r, 0, hypotenuse - leg_arch_hypotenuse]) {
						rotate([90, 0, 0]) {
							rotate_extrude(angle = 180 - leg_arch_angle) {
								translate([top_r, 0, 0]) {
									circle(d = leg_d);
								}
							}
						}
					}
				}
			}
			translate([opposite, 0]) {
				rotate([0, -leg_arch_angle/2, 0]) {
					sphere(d = leg_d);
					cylinder(d = leg_d, h = hypotenuse - leg_arch_hypotenuse);
				}
			}
			translate([-opposite, 0]) {
				rotate([0, leg_arch_angle/2, 0]) {
					sphere(d = leg_d);
					cylinder(d = leg_d, h = hypotenuse - leg_arch_hypotenuse);
				}
			}
		}
	}
}
