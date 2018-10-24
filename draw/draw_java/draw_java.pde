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
			minLat = -25.645500,
      maxLat = -25.346814,
			minLon = -49.389163,
			maxLon = -49.185324,
      scr_scale = 0.36;

int hue,
    sat,
    bgt,
		scr_w = 445,
		scr_h = 705;

Table table;

void set_coord(float latNE, float lonNE, float latSW, float lonSW) {
  r_width = (lonNE-lonSW)/(maxLon-minLon)*scr_w;
  r_height = (latNE-latSW)/abs(minLat-maxLat)*scr_h;

  x = (lonSW-minLon)/(maxLon-minLon)*scr_w;
  y = abs(((maxLat-latNE))/(maxLat-minLat))*scr_h;
}

void settings() {
  size(scr_w, scr_h); // map.size = [1250, 2080] -> img.size * 0.32 [Must be the size of the map]
}

void setup() {
  //Environment settings
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  background(0xFFFFFFFF);
  hue = 360;
  sat = 100;
  bgt = 100;
  alpha = 1;

  //Loading Map
  map = loadShape("./temp/map.svg");
	map.scale(scr_scale);
  shapeMode(CORNER);

  //Loading Table
  table = loadTable("./temp/table.csv", "header, csv");

	shape(map);

	for (TableRow row : table.rows()) {
		set_coord(row.getFloat("latNE"), row.getFloat("lonNE"), row.getFloat("latSW"), row.getFloat("lonSW"));
		fill(hue, sat, bgt, alpha);
		rect(x, y, r_width, r_height);
	}

	save("output.png");

	exit();
}
