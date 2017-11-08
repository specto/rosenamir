import processing.video.*;

Capture video;

int desiredFrameRate = 24;
color roseColor = color(255, 67, 242);
float roseAmount = 0.7;


void setup() {
  fullScreen(P2D, SPAN);
  frameRate(desiredFrameRate);
  video = new Capture(this, width, height, desiredFrameRate);
  video.start();   
  background(0);
  noSmooth();
  noCursor();
}

void draw() {
  if (video.available()) {
    video.read();
  }
  image(video, 0, 0, width, height);
  loadPixels();

  for (int i = 0, j = width - 1;
       i < pixels.length - width / 2; 
       ++i, --j) {
    pixels[i] = pixels[j];
    pixels[j] = lerpColor(pixels[j], roseColor, roseAmount);
    if (i + 1 == j) {
      i += width / 2;
      j += width / 2 + width;
    }
  } 
  updatePixels();
}