PShape map;

void setup() {
  size(480,680);
  map = loadShape("./temp/map.svg");
  map.scale(0.32);
}

void draw() {
  shapeMode(CORNER);
  shape(map);
}
