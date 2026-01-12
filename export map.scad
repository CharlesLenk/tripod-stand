include <openscad-utilities/common.scad>
use <tripod stand.scad>

name = "";
width = default_width();
wire_d = default_wire_d();

if (name == "tripod_stand")
    tripod_stand();
