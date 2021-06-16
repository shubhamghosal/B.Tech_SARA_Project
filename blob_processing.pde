import processing.serial.*;

Serial myPort;

import processing.video.*;


Capture video;


color trackColor; 
float threshold = 25;
float distThreshold = 50;
int k = 0;
int t;
String message;
ArrayList<Blob> blobs = new ArrayList<Blob>();

void setup() {
  size(1000, 480);
   myPort = new Serial(this, "COM6", 9600);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, 640, 480);
  video.start();
  trackColor = color(255, 0, 0);
  
}

void captureEvent(Capture video) {
  video.read();
}

void keyPressed() {
  if (key == 'a') {
    distThreshold+=5;
  } else if (key == 'z') {
    distThreshold-=5;
  }
  if (key == 's') {
    threshold+=5;
  } else if (key == 'x') {
    threshold-=5;
  }


  println(distThreshold);
}

void draw() {
  video.loadPixels();
  image(video, 0, 0);

  blobs.clear();


  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {

        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }
  
 
   int blobID=0;
  for (Blob b : blobs) {
    if (b.size() > 500) {
     
      b.show(blobID);
      blobID++;
      
    }
  }
  rectMode(CORNERS);
  fill(0);
  rect(640,0,1000,480);
  textSize(22);
  textAlign(RIGHT);
  fill(255,0,0);
  text("distance threshold: " + distThreshold, width-10, 25);
  text("color threshold: " + threshold, width-10, 60);
  text("No. of blobs:"+blobID, width-10, 95);
   rectMode(CORNER);
   fill(255,0,0);
  rect(900,400,60,40);
  fill(0,255,0);
  textSize(16);
  text("START",955,430);
  textSize(80);
  fill(100,100,100);
  text("S.A.R.A.",width-30,240);
  
 
}


// Custom distance functions w/ no square root for optimization
float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  if (mouseX<=640 && mouseY<=480){
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
  
  }
  else if(mouseX>900 && mouseX<960 && mouseY>400 && mouseY<440){
    myPort.write('p');
    delay(1000);
  }
  else{
  }
}


void serialEvent(Serial p) {
  try {
    // get message till line break (ASCII > 13)
     message = p.readStringUntil(13);
    // just if there is data
    if (message != null) {
      message = trim(message);
     t = Integer.parseInt(message);
     println(t);
    }
    
  }
  catch (Exception e) {
}
}



//////////////////////////////////////////////////////////////////////////////////
///////////////////////////      blob     ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

class Blob {
  float minx;
  float miny;
  float maxx;
  float maxy;

  ArrayList<PVector> points;

  Blob(float x, float y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
    points = new ArrayList<PVector>();
    points.add(new PVector(x, y));
  }

  void show(int num) {
    stroke(0);
    fill(255);
    strokeWeight(2);
    rectMode(CORNERS);
    rect(minx, miny, maxx, maxy);
    float a = (width-(width-maxx))-(maxx-minx)/2;
    float b = (height-(height-maxy))-(maxy-miny)/2;
    ellipse(a,b,10,10);
    textSize(20);
    fill(255,0,0);
    text("X:"+a,a+20,b+20);
    text("Y:"+b,a+20,b+40);
    fill(255,0,0);
    textSize(64);
    text(num+1,a-20,b-20);
    
   // for(int p =0; p<=num; p++){
    if(a>400 && a<460 && b>60 && b<90){
    // k = 1;
   // }
    //else
    //{
      //k=0;
    //}
    textSize(15);
      text(" selected coloured object detected" , 450, 420);
    if(t == 1){
      
      
    
    // if(mousePressed){
      //if(mouseX>900 && mouseX<960 && mouseY>400 && mouseY<440){
    
   int a1 = (int)a;
    int b1 = (int)b;
    //println("blob no. :"+(p+1));
      println(Integer.toString(a1));
    println(Integer.toString(b1));
    myPort.write('d');
    
 delay(800);
    t=0;
   
//  }

    }
       //k = 0;
   //}
    }
   
 // }
    for (PVector v : points) {
      //stroke(0, 0, 255);
      //point(v.x, v.y);
    }
  }



  void add(float x, float y) {
    points.add(new PVector(x, y));
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y);
  }

  float size() {
    return (maxx-minx)*(maxy-miny);
  }

  boolean isNear(float x, float y) {

    // The Rectangle "clamping" strategy
    // float cx = max(min(x, maxx), minx);
    // float cy = max(min(y, maxy), miny);
    // float d = distSq(cx, cy, x, y);

    // Closest point in blob strategy
    float d = 10000000;
    for (PVector v : points) {
      float tempD = distSq(x, y, v.x, v.y);
      if (tempD < d) {
        d = tempD;
      }
    }

    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}