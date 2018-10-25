
PImage img;

PShader shade;

int offsetX,
		offsetY,
		zoom = -1;


public void settings() {
  size(Integer.parseInt(System.getenv("HM_SCR_W")), Integer.parseInt(System.getenv("HM_SCR_H")), P2D);
}

public void setup() {
  img = loadImage(System.getenv("HM_OUT"));

	// The offsets are needed if the image size is
  // different from the display size
  offsetX = (width - img.width)/2;
  offsetY = (height - img.height)/2;


  initShaders(img);
}

public void mouseMoved() {
  shade.set("lensPos", mouseX - offsetX, mouseY - offsetY);
}

public void mouseClicked() {
	zoom = 0-zoom;
}

public void draw() {
  if(zoom == 1) {
		noCursor();
		background(128);
		shader(shade);
		drawOutput(offsetX, offsetY, img.width, img.height);
	}
	else {
		background(img);
		cursor();
	}
}

public void initShaders(PImage img) {
  shade = loadShader("fisheye.glsl");
  shade.set("image", img);
  shade.set("size", img.width, img.height);
  shade.set("lensSize", 100.0f);
  shade.set("lensPos", 200, 100);
}

public void drawOutput(float x, float y, float w, float h) {
  pushMatrix();
  translate(x, y);
  beginShape(QUAD);
  vertex(0, 0, 0, 0);
  vertex(0, h, 0, 1);
  vertex(w, h, 1, 1);
  vertex(w, 0, 1, 0);
  endShape();
  popMatrix();
}
