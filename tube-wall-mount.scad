/*
	name: 		tube-wall-mount.scad
	author:		Aymeric B.
	date:		23.06.2014
*/


/****** PARAMETERS ****/
$fn = 80;
pad = 0.1;

/****** MODULES ****/
module RoundingEdge(radius, length) {	
	difference() {
		translate([0, 0, -pad]) {
			cube([2*radius+pad, 2*radius+pad, length+2*pad]);
		}
		translate([0, 0, -2*pad]) {
			cylinder(r=radius,h=length+4*pad);
		}
	}
}

module Hook(diameter, depth, gap, length, thickness) {
	width = gap + diameter + thickness;
	height = depth + thickness;
	cylinder_center_position_x = gap + diameter/2;
	cylinder_center_position_y = height - depth + diameter/2;
	hook_radius = 7;

	difference() {
		cube([width, height, length]);
		translate([cylinder_center_position_x, cylinder_center_position_y, -1]) {
			cylinder(r=diameter/2, h=length+2);
		}
		translate([gap, cylinder_center_position_y, -1]){ 
			cube([diameter, depth, length+2]);
		}
		translate([width-hook_radius, hook_radius, 0]) {
			rotate([0, 0, -90]) {
				RoundingEdge(hook_radius, length);
			}	
		}		
	}	
}

/****** RENDERS ****/
Hook(10, 15, 15, 10, 5);