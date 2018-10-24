/**************************************************
TI-Map - UNIVERSIDADE TECNOLÓGICA FEDERAL DO PARANÁ
Author: Daniel Eduardo Vieira
        João Vitor Baby Fonsaka

Requirements:  map.svg
               coordinates of this map
***************************************************/

PShape map;

int iterator,
    hue,
    sat,
    bgt;

float alpha;

void setup() {
  //Environment settings
  size(400,666); // map.size = [1250, 2080] -> img.size * 0.32 [Must be the size of the map]
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
}

void draw() {
  shape(map);

  //Example of generating heat points (alpha variable by mouse clicking)
  for(iterator = 0; iterator < 5; iterator++) {
    fill(hue - iterator * 50, sat, bgt, alpha);
    rect(iterator * 50, 200 + iterator * 50, 150, 150);
  }
}

void mouseClicked() {
  alpha = alpha + 0.9;
}
