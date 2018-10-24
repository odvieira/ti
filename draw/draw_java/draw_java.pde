/**************************************************
TI-Map - UNIVERSIDADE TECNOLÓGICA FEDERAL DO PARANÁ
Author: Daniel Eduardo Vieira
        João Vitor Baby Fonsaka

Requirements:  map.svg
               coordinates of this map
***************************************************/

PShape map;

float alpha,
			x,
			y,
			r_width,
			r_height,
			scr_scale = 1,
			minLat = -25.346814,
			minLon = -49.389163,
			maxLat = -25.645500,
			maxLon = -49.185324;

int iterator,
    hue,
    sat,
    bgt,
		scr_w = 1250,
		scr_h = 2080;

Table table;

void set_coord(float latNE, float lonNE, float latSW, float lonSW) {
	r_width = lonNE - lonSW;
	r_height = latNE - latSW;

	x = (lonNE + lonSW) / 2;
	y = (latNE + latSW) / 2;


}

void setup() {
  //Environment settings
	scr_scale = 0.32;
	scr_w *= scr_scale;
	scr_h *= scr_scale;
  size(scr_w, scr_h); // map.size = [1250, 2080] -> img.size * 0.32 [Must be the size of the map]
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  background(0xFFFFFFFF);
  hue = 360;
  sat = 100;
  bgt = 100;
  alpha = 0;

  //Loading Map
  map = loadShape("./temp/map.svg");
  map.scale(0.32); // Good size for a 2080p original size
  shapeMode(CORNER);

  //Loading Table
  table = loadTable("./temp/table.csv", "header, tsv");

	for (TableRow row : table.rows()) {
		set_coord();
    fill(hue - iterator * 50, sat, bgt, alpha);
    rect(iterator * 50, 200 + iterator * 50, 150, 150);
  }

	shape(map);
}

void draw() {

}
