//import processing.video.*;
import gohai.glvideo.*;

GLCapture video;

int desiredFrameRate = 30;
color roseColor = color(240, 110, 170);

void setup() {
  //fullScreen(P2D, SPAN);
  fullScreen(P2D, SPAN);
  //surface.setResizable(true);
  
  frameRate(desiredFrameRate);
  String[] cameras = GLCapture.list();
  println("Devices:");
  printArray(cameras);
  if (0 < cameras.length) {
    String[] configs = GLCapture.configs(cameras[0]);
    println("Configs:");
    printArray(configs);
  }
  video = new GLCapture(this, cameras[0]);
  video.start();   
  background(0);
  noSmooth();
  noCursor();
}

void draw() {
  if (video.available()) {
    video.read();
  }
  
  PImage videoimg = video.get();
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
}