ControlPoint[] controlPointList = new ControlPoint[3];
CheckPoint[][] checkPointList = new CheckPoint[3][4];
MaterialPoint[] materialPointList = new MaterialPoint[3];

Check controllerCheck;

Plane controllerPlane;

float planesScale, planesX, planesY, planesOffsetY, planeRectSize;
float controllerScale, controllerX, controllerY;

void initController() {
  planeRectSize = (height-40)/3;
  planesScale = 78;
  planesX = width-(planeRectSize/2)-10;
  planesY = 10+(planeRectSize/2);
  createCheckPoints();
  createMaterialPoints();
  controllerPlane = new Plane(module,0);
  controllerPlane.legs[0] = true;
  controllerPlane.legs[1] = true;
  controllerPlane.legs[2] = true;
  controllerPlane.legs[3] = true;
  createControlPoints();
  controllerPlane.calculateVertex();
  controllerCheck = new Check(10,false,0,0,"Shape");
}

void updateController() {

  if (controllerCheck.state) {
    precission = true;
    intro = false;
    help = false;
  } 
  else {
    precission = false;
  }
  controllerPlane.calculateVertex();
  updateControlPoints();
  controllerCheck.update(mouseX,mouseY);
}

void createMaterialPoints() {
  for (int j=0;j<3;j++) {
    materialPointList[j] = new MaterialPoint(j);
  }
}

void createCheckPoints() {
  for (int i=0;i<3;i++) {
    for (int j=0;j<4;j++) {
      checkPointList[i][j] = new CheckPoint(i,j);
    }
  }
}

void createControlPoints() {
  for (int j=0;j<3;j++) {
    controlPointList[j] = new ControlPoint(j);
  }
}

void updateControlPoints() {
  pushMatrix();
  rotateZ(-PI/2);
  for (int j=0;j<3;j++) {
    pushMatrix();
    translate(module.pointList[j].x,module.pointList[j].y);
    controlPointList[j].update();
    popMatrix();
  }
  popMatrix();
}

float controlPointOffset = 1.1;

void updateMaterialPoint (int thisPlane) {
  materialPointList[thisPlane].update(-controlPointOffset,controlPointOffset);
}

void updateCheckPoints(int thisPlane) {
  checkPointList[thisPlane][0].update(0,controlPointOffset);
  checkPointList[thisPlane][3].update(-controlPointOffset,0);
  checkPointList[thisPlane][2].update(0,-controlPointOffset);
  checkPointList[thisPlane][1].update(controlPointOffset,0);
}

void planeStyle() {
  strokeWeight(1);
  stroke(255,255);
  noFill();
}

void controllerStyle() {
  strokeWeight(1);
  stroke(255,50);
  fill(backgroundColor,220);
}

void drawController() {
  pushMatrix();
  translate(planesX,planesY);

  for (int i=0;i<3;i++) {
    controllerStyle();
    rectMode(CENTER);
    rect(0,0,planeRectSize,planeRectSize);
    pushMatrix();
    scale(planesScale);
    rotateZ(PI/4);
    module.planeList[i].display(false,false,true,false);
    updateCheckPoints(i);
    updateMaterialPoint(i);
    popMatrix();
    fill(255,150);
    textAlign(RIGHT);
    textFont(mediumFont);
    text(char('A'+i),-2+planeRectSize/2,-(planeRectSize/2)+19);
    translate(0,planeRectSize+10);
  }
  popMatrix();

  if (precission) {
    controllerScale = (height/2)-10; 
    controllerX = width/2;
    controllerY = height/2;
    controllerStyle();
  } 
  else {
    controllerScale = planeRectSize/2;
    controllerX = planeRectSize/2+10;
    controllerY = height-planeRectSize/2-10;
  }

  pushMatrix();
  if (precission) {
    controllerStyle();
    rectMode(CORNER);
    rect(planeRectSize+20,10,width-(planeRectSize*2)-40,height-20);
  }
  translate(controllerX,controllerY);
  scale(controllerScale);
  controllerStyle();
  if (!precission) {
    rectMode(CENTER);
   rect(0,0,2,2);
  }
  stroke(255,0,0,100);
  // line(-1,-1,1,1);
  // line(-1,1,1,-1);
  float limitLine = .05;
  float minCoord = minh*cos(PI/4);
  float maxCoord = maxh*cos(PI/4);
  line(minCoord,minCoord,maxCoord,maxCoord);
  line(minCoord+limitLine,minCoord-limitLine,minCoord-limitLine,minCoord+limitLine);
  line(maxCoord+limitLine,maxCoord-limitLine,maxCoord-limitLine,maxCoord+limitLine);

  line(legWidth/2,1,-controlPointList[2].y,controlPointList[2].x);
  line(1,legWidth/2,-controlPointList[1].y,controlPointList[1].x);
  line (1-maxr/2,legWidth/2,1,legWidth/2);
  line (legWidth/2,1-maxr/2,legWidth/2,1);
  line (legWidth/2,1,maxr/2+legWidth/2,1);
  line (1,legWidth/2,1,maxr/2+legWidth/2);

  float ellipse2X = screenX(legWidth/2,1);
  float ellipse2Y = screenY(legWidth/2,1);
  float ellipse1X = screenX(1,legWidth/2);
  float ellipse1Y = screenY(1,legWidth/2);
  rotateZ(PI/4);
  stroke(100,200);
  planeStyle();
  controllerPlane.display(false,false,false,false);

  //////////////// control points

  for (int j=0;j<3;j++) {
    controlPointList[j].display();
  }
  popMatrix();

  controllerStyle();
  noFill();
  stroke(255,0,0,50);

  arc(ellipse2X,ellipse2Y,maxr*controllerScale,maxr*controllerScale,PI+(PI/2),TWO_PI);
  arc(ellipse1X,ellipse1Y,maxr*controllerScale,maxr*controllerScale,PI/2,PI);

  for (int j=0;j<3;j++) {
    materialPointList[j].display();
  }

  for (int i=0;i<3;i++) {
    for (int j=0;j<4;j++) {
      checkPointList[i][j].display();
    }
  }

  fill(255);
  rectMode(CORNER);
  if (precission) {
    controllerCheck.locate(planeRectSize+24,14);
  } 
  else {
    controllerCheck.locate(14,height-planeRectSize-6);
  }
  controllerCheck.display();
}

void pressController() {
  for (int j=0;j<3;j++) {
    controlPointList[j].press();
  }
  for (int j=0;j<3;j++) {
    materialPointList[j].press();
  }
  for (int i=0;i<3;i++) {
    for (int j=0;j<4;j++) {
      checkPointList[i][j].press();
    }
  }
  controllerCheck.press(mouseX,mouseY);
}

void releaseController() {
  for (int j=0;j<3;j++) {
    controlPointList[j].release();
  }
  for (int j=0;j<3;j++) {
    materialPointList[j].release();
  }
  for (int i=0;i<3;i++) {
    for (int j=0;j<4;j++) {
      checkPointList[i][j].release();
    }
  }
  //  controllerCheck.release(m);
}

class ControlPoint {
  int id;
  float pointLenght= 15;
  float controlPointSize = 10;
  float targetX,targetY;
  float x, y;
  float offsetX, offsetY;
  boolean dragged;
  boolean active;
  boolean rollover;

  ControlPoint(int _id) {
    id = _id;
  }

  void update() {
    x = screenX(0,0);
    y = screenY(0,0);
  }

  void display() {
    pushMatrix();
    translate(x,y);
    //  stroke(255,0,0,200);
    stroke(200);
    x = screenX(0,0);
    y = screenY(0,0);
    noFill();
    strokeWeight(2);
    if (abs(x-mouseX) < controlPointSize && abs(y - mouseY) < controlPointSize) {
      rollover = true;
      ellipse(0,0,(controlPointSize+3)/controllerScale,(controlPointSize+3)/controllerScale);
    } 
    else {
      rollover = false; 
      ellipse(0,0,controlPointSize/controllerScale,controlPointSize/controllerScale);
    }
    if (dragged) {

      float distance, angle;

      targetX = (mouseX-controllerX-offsetX)/controllerScale;
      targetY = (mouseY-controllerY-offsetY)/controllerScale;
      float divider = cos(PI/4);
      switch(id) {
        ///// control point constrains
      case 0:
        if (targetX > divider*maxh) {
          targetX = divider*maxh;
        }
        if (targetY > divider*maxh) {
          targetY = divider*maxh;
        }
        if (targetX < divider*minh) {
          targetX = divider*minh;
        }
        if (targetY < divider*minh) {
          targetY = divider*minh;
        }
        if (targetX != targetY) {
          targetX = targetY;
        }
        break;
      case 1:
        distance = dist(1,legWidth/2,targetX,targetY);
        angle =  PI-atan2(targetY-legWidth/2,targetX-1);
        if (distance > maxr/2) {
          if (angle > PI) angle = 0;
          if (angle > PI/2) angle = PI/2;
          targetX = 1-(maxr/2 * cos (angle));
          targetY = (legWidth/2)+(maxr/2 * sin (angle));
        }
        if (targetY < legWidth/2) {
          targetY = legWidth/2;
        }

        if (targetX > 1) {
          targetX = 1;
        }
        break;

      case 2:
        distance = dist(legWidth/2,1,targetX,targetY);
        angle =  -atan2(targetY-1,targetX-legWidth/2);
        if (distance > maxr/2) {
          if (angle > PI) angle = 0;
          if (angle > PI/2) angle = PI/2;
          targetX = (legWidth/2)+(maxr/2 * cos (angle));
          targetY = 1-(maxr/2 * sin (angle));
        }
        if (targetX < legWidth/2) {
          targetX = legWidth/2;
        }

        if (targetY > 1) {
          targetY = 1;
        }
        break;
      }

      module.pointList[id].x = targetX;
      module.pointList[id].y = targetY;
    } 

    rotate(-PI/2);

    if (rollover || dragged) {
      noFill();
      line(-pointLenght/controllerScale,0,pointLenght/controllerScale,0);
      line(0,-pointLenght/controllerScale,0,pointLenght/controllerScale);
    }
    popMatrix();
  }

  void press () {
    if (rollover) {
      dragged = true;  
      offsetX = mouseX-x;
      offsetY = mouseY-y;
    }
  }

  void release () {
    dragged = false;
  }
}

class CheckPoint {
  int plane,leg;
  float checkPointSize = 8;
  float ratio = .05;
  float x, y;
  boolean active;
  boolean rollover;

  CheckPoint(int _plane, int _leg) {
    plane = _plane;
    leg = _leg;
  }

  void update(float _x,float _y) {
    x = screenX(_x,_y);
    y = screenY(_x,_y);
  }

  void display() {
    pushMatrix();
    //stroke(255,0,0,200);

    translate(x,y);

    //strokeWeight(2);
    rectMode(CENTER);
    fill(backgroundColor);
    if (abs(x-mouseX) < checkPointSize && abs(y - mouseY) < checkPointSize) {
      rollover = true;
      stroke(255);
    } 
    else {
      rollover = false; 
      stroke(midGray);
    }
    rect (0,0,checkPointSize,checkPointSize);

    active = module.planeList[plane].legs[leg];
    if (active) {
      line(-checkPointSize/2,-checkPointSize/2,checkPointSize/2,checkPointSize/2);
      line(checkPointSize/2,-checkPointSize/2,-checkPointSize/2,checkPointSize/2);
    } 
    else {
    }

    popMatrix();
  }

  void press () {
    if (rollover) {
      if (module.planeList[plane].legsNum == 1 && module.planeList[plane].legs[leg] == true) {
        printMessage("All planes must have at least one leg");
      } 
      else {
        module.planeList[plane].legs[leg] = !module.planeList[plane].legs[leg];
      }
    }
  }

  void release () {
  }
}

class MaterialPoint {
  int plane;
  float  sh = 8; 
  float  sw = 20;
  float x, y;
  boolean rollover;
  boolean pressed;

  MaterialPoint(int _plane) {
    plane = _plane;
  }

  void update(float _x,float _y) {
    x = screenX(_x,_y);
    y = screenY(_x,_y);
  }

  void display() {
    pushMatrix();
    translate(x+6,y);
    strokeWeight(1);
    rectMode(CENTER);
    if (pressed) {
      fill(200);
    } 
    else {
      fill(backgroundColor);
    }
    if (mouseX > x && mouseX < x+sw && abs(y - mouseY) < sh) {
      rollover = true;
      stroke(255);
    } 
    else {
      rollover = false; 
      stroke(200);
    }
    rect(0, 0, sw, sh); 
    if (rollover) {
      fill(255);
    } 
    else {
      fill(200);
    }
    textAlign(LEFT);
    textFont(font);
    text ("Material",14,4);
    fill(200);
    text ( materialNames[module.planeList[plane].material],-10,18);
    noFill();
    popMatrix();
  }

  void press () {
    if (rollover) {
      module.planeList[plane].material ++;
      if (module.planeList[plane].material == materialNum) module.planeList[plane].material = 0;
      pressed = true;
    }
  }

  void release () {
    pressed = false;
  }
}

