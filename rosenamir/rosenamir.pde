import processing.video.*;

Capture video;
Movie movie;

int desiredFrameRate = 30;
color roseColor = color(255, 67, 242);
float roseAmount = 0.7;


void setup() {
  //fullScreen(P2D, SPAN);
  fullScreen(P2D);
  frameRate(desiredFrameRate);
  String[] cameras = Capture.list();
  println("number of cameras:", cameras.length);
  for (int i = 0; i < cameras.length; i++) {
    println(i, ": ", cameras[i]);
  }
  video = new Capture(this, cameras[73]);
  video.start();   
  movie = new Movie(this, "clouds.mov");
  movie.loop();
  background(0);
  noSmooth();
  noCursor();
}

void draw() {
  if (!(video.available() || movie.available())) {
    return;
  }
  video.read();
  movie.read();
  PImage videoimg = video.get();
  PImage movieimg = movie.get();
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
  
  tint(roseColor);
  vertex(width/2, 0, 0.5, 0);
  vertex(width/2, height, 0.5, 1);
  vertex(width, height, 1, 1);
  vertex(width, 0, 1, 0);
  endShape();
  
  beginShape();
  blendMode(SCREEN);
  texture(movieimg);
  vertex(width/2, 0, 0, 0);
  vertex(width/2, height, 0, 1);
  vertex(width, height, 1, 1);
  vertex(width, 0, 1, 0);
  endShape();
}