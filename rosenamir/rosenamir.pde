import processing.video.*;

Capture video;
PImage videoimg;

int desiredFrameRate = 60;
color roseColor = color(240, 110, 170);

void settings() {
  fullScreen(P2D, SPAN);
  //size(800, 800, P2D);
}

void setup() {  
  frameRate(desiredFrameRate);
  //String[] cameras = Capture.list();
  //println("number of cameras:", cameras.length);
  //printArray(cameras);
  
  video = new Capture(this, 1600, 1200, "WC060 Series HD Webcam");
  video.start();   
  background(0);
  noSmooth();  
  noCursor();
}

void draw() {
  if (video.available()) {
    video.read();
  }
  
  videoimg = video.get();
  noStroke();
  textureMode(NORMAL);
  noTint();
  
  blendMode(REPLACE);
  
  beginShape(QUADS);
  texture(videoimg);
  vertex(0, 0, 1, 0);
  vertex(0, height, 1, 1);
  vertex(width/2, height, 0.5, 1);
  vertex(width/2, 0, 0.5, 0);
  
  vertex(width/2, 0, 0.5, 0);
  vertex(width/2, height, 0.5, 1);
  vertex(width, height, 1, 1);
  vertex(width, 0, 1, 0);
  endShape();
  
  beginShape();
  blendMode(SCREEN);
  fill(roseColor);
  vertex(width/2, 0, 0, 0);
  vertex(width/2, height, 0, 1);
  vertex(width, height, 1, 1);
  vertex(width, 0, 1, 0);
  endShape();
  g.removeCache(videoimg);
}