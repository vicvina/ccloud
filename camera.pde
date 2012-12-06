float zoom, targetZoom, z, targetZ, y, targetY, x, targetX;
float fov, targetFov;

float offsetX,offsetY;

Camera camera1,camera2;

void initCamera() {
  camera1 = new Camera(this);
  camera2 = new Camera(this);
  fov = 1.047;// camera1(); 
  targetFov = 0.47;
  targetX = .5;
  targetY = .4;
  zoom = .5;
  x = .5;
  y = .5;
}

void updateCamera() {
  if (dragged) {
    targetX -= (mouseX-offsetX)/500;
    offsetX = mouseX;
    targetY -= (mouseY-offsetY)/500;
    offsetY = mouseY;
  }
  if (rotation && !dragged) {
    targetX += .0005;
  }
  camera1.zoom((targetFov-fov));
  camera1.tumble((targetX-x)*2*PI,(targetY-y)*2*PI);
  fov = targetFov;
  y = targetY;
  x = targetX;
  camera1.feed();
  scale(.1+(zoom/fov*100));
}

void resetCamera() {
  camera2.feed();
  translate(-width/2,-height/2);
}

void pressCamera() {
  if (mouseX > 260 && mouseX < width-planeRectSize-10) {
    offsetX = mouseX;
    offsetY = mouseY;
    dragged = true;
  }
}

void releaseCamera() {
  dragged = false;
}












