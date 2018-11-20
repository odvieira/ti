
PImage	img;

PShader shade;

Table table;

int		offsetX,
		offsetY,
		zoom = 0,
		i = 0;


public void settings() {
	size(Integer.parseInt(System.getenv("HM_SCR_W")), Integer.parseInt(System.getenv("HM_SCR_H")), P2D);
}

public void setup() {
	img = loadImage(System.getenv("HM_OUT"));

	table = loadTable("certo.csv", "csv");

	// The offsets are needed if the image size is
	// different from the display size
	offsetX = (width - img.width)/2;
	offsetY = (height - img.height)/2;

	initShaders(img);
}

public void mouseMoved() {
	shade.set("lensPos", mouseX, mouseY);

}

public void mouseClicked(){
	if (zoom == 0){
		zoom = 1;
	}
	else {
		zoom = 0;
	}
}

public void draw() {
  if(zoom == 1) {
		noCursor();
		background(128);
		shader(shade);
		drawOutput(offsetX, offsetY, img.width/2, img.height/2);
	}
	else {
		resetShader();
		image(img,0,0,Integer.parseInt(System.getenv("HM_SCR_W")),Integer.parseInt(System.getenv("HM_SCR_H")));
		cursor();
	}
    resetShader();
    for (int i=0; i< table.getRowCount(); i++){
        int posX = table.getInt(i, 2);
	    int posY = table.getInt(i, 3);
	    
    	if (mouseX > posX-25 && mouseX < posX+25 && mouseY > posY-25 && mouseY < posY+25){
        	textSize(20);
        	stroke(255);
        	if (zoom == 1){
                text(table.getString(i,1), posX+(posX-mouseX)*1.4-9, posY+(posY-mouseY)*1.4);            
            } else {
                text(table.getString(i,1), posX-6, posY);
            }
        	fill(28, 69, 135);
   		}
	}
	shader(shade);

}

public void initShaders(PImage img) {
	shade = loadShader("fisheye.glsl");
	shade.set("image", img);
	shade.set("size", img.width/2, img.height/2);
	shade.set("lensSize", 100.0f);
	shade.set("lensPos", 200, 100);
}

public void drawOutput(float x, float y, float w, float h) {
	pushMatrix();
	translate(0, 0);
	beginShape(QUAD);
	vertex(0, 0, 0, 0);
	vertex(0, h, 0, 1);
	vertex(w, h, 1, 1);
	vertex(w, 0, 1, 0);
	endShape();
	popMatrix();
}
