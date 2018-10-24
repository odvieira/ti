uniform sampler2D image;

// Image size in pixels
uniform ivec2 size;

// Lens position
uniform ivec2 lensPos;

// Lens size (radius in pixels)
uniform float lensSize;

varying vec4 vertTexCoord;

void main() {
	// Get current uv position
	vec2 st = vertTexCoord.st;

	// get current pixel position
	vec2 pxl = size * st;

	// Get distance from lens centre
	float pxl2lens = distance(pxl, lensPos);

	// If outside lens use pixel
	if(pxl2lens > lensSize){
		gl_FragColor = texture2D(image, st).rgba;
		return;
	}
	// We are inside the lens radius so calculate
	// new uv coordinate

	// Get direction vector to pixel
	vec2 direction = pxl - lensPos;

	float factor = 0.4 + 0 * pxl2lens / lensSize;
	vec2 npxl = lensPos + direction * factor;
	vec2 nst = npxl / size;

	gl_FragColor = texture2D(image, nst).rgba;
}
