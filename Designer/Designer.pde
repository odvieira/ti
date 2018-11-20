/**************************************************
TI-Map - UNIVERSIDADE TECNOLÓGICA FEDERAL DO PARANÁ
Author: Daniel Eduardo Vieira
        João Vitor Baby Fonsaka

Requirements:  map.svg
               coordinates of this map
***************************************************/
PShape map;

float	alpha,
		x,
		y,
		r_width,
		r_height,
		minLat,
		maxLat,
		minLon,
		maxLon,
		scr_scale;

int	hue,
	sat,
	bgt,
	scr_w,
	scr_h;

Table table;

public void settings() {
	size(Integer.parseInt(System.getenv("HM_SCR_W"))*2, Integer.parseInt(System.getenv("HM_SCR_H"))*2);
}

public void setup() {
  //Environment settings
	colorMode(HSB, 360, 100, 100, 100);
	noStroke();
	background(0xFFFFFFFF);
	hue = 360;
	sat = 100;
	bgt = 100;
	alpha = 1;
	scr_w = Integer.parseInt(System.getenv("HM_SCR_W"))*2;
	scr_h = Integer.parseInt(System.getenv("HM_SCR_H"))*2;
	scr_scale = Float.parseFloat(System.getenv("HM_SCR_SCALE"));
	minLat = Float.parseFloat(System.getenv("HM_MIN_LAT"));
	maxLat = Float.parseFloat(System.getenv("HM_MAX_LAT"));
	minLon = Float.parseFloat(System.getenv("HM_MIN_LON"));
	maxLon = Float.parseFloat(System.getenv("HM_MAX_LON"));

  //Loading Map
	map = loadShape(System.getenv("HM_MAP"));
	map.scale(scr_scale*2);
	shapeMode(CORNER);

  //Loading Table
	table = loadTable(System.getenv("HM_TABLE"), System.getenv("HM_TABLE_OPT"));
}

public void draw() {
	background(128);

	shape(map);

	plotHeatMap();

	save(System.getenv("HM_OUT"));

	exit();
	//noLoop();
}

public void set_coord(float latNE, float lonNE, float latSW, float lonSW) {
	r_width = (lonNE-lonSW)/(maxLon-minLon)*scr_w;
	r_height = (latNE-latSW)/abs(minLat-maxLat)*scr_h;

	x = (lonSW-minLon)/(maxLon-minLon)*scr_w;
	y = abs(((maxLat-latNE))/(maxLat-minLat))*scr_h;
}

public void plotHeatMap() {
	for (TableRow row : table.rows()) {
		set_coord(row.getFloat("latNE"), row.getFloat("lonNE"), row.getFloat("latSW"), row.getFloat("lonSW"));
		fill(hue, sat, bgt, alpha);
		rect(x, y, r_width, r_height);
	}
}

