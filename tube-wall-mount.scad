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

module ScrewHole(hole_diameter, countersink_diameter, length) {	
	countersink_radius = countersink_diameter / 2;

	union() {
		translate([0, 0, -pad]) {
			cylinder(r=hole_diameter/2, h=length+2*pad);
		}
		translate([0, 0, length+2*pad-countersink_radius]) {
			cylinder(r1=0, r2=countersink_radius, h=countersink_radius+pad);
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

module TubeWallMount(width, height, thickness, diameter, gap, wide) {
	difference() {
		union() {
			cube([width, height, thickness]);
			translate([wide, 0, thickness]) {
				rotate([0, -90, 0]) {
					Hook(diameter, height-thickness, gap, wide, thickness);
				}
			}
			translate([width, 0, thickness]) {
				rotate([0, -90, 0]) {
					Hook(diameter, height-thickness, gap, wide, thickness);
				}
			}
			translate([width/2, height/2, thickness]) {
				cylinder(r=5, h=10);
			}
		}
		translate([width/2, height/2, ]) {
			ScrewHole(4, 8, 15);
		}
	}
}

/****** RENDERS ****/
plate_width = 80;
plate_height = 20;
plate_thickness = 5;
tube_diameter = 10;
tube_wall_gap = 15;
hooks_width = 10;
TubeWallMount(plate_width, plate_height, plate_thickness, tube_diameter, tube_wall_gap, hooks_width);