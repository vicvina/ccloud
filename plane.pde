class Plane {
  Module parent;
  int planeId;
  int legsNum;
  int material;
  boolean[] legs = new boolean[4];
  String infoString;

  int vertexNum = 12;
  Vertex [] vertexList = new Vertex [vertexNum*4];
  Vertex [] masterList = new Vertex [vertexNum*4];
  Vertex [] noLegMasterList = new Vertex [vertexNum*4];

  Plane (Module _parent, int _planeId) {
    parent = _parent;
    planeId = _planeId;
    material = int(random(materialNum));

    legs[0] = true;
    legs[1] = true;
    legs[2] = true;
    legs[3] = true;

    for (int i=0;i<masterList.length;i++) {
      masterList[i] = new Vertex();
    }

    for (int i=0;i<noLegMasterList.length;i++) {
      noLegMasterList[i] = new Vertex();
    }

    for (int i=0;i<vertexList.length;i++) {
      vertexList[i] = new Vertex();
    }
    // calculateVertex();
  }

  void display(boolean displayInfo, boolean outlineText, boolean applyMaterial, boolean applyStroke) {
    infoString = parent.authorName+" "+parent.authorCountry+" "+parent.date+" "+char(planeId+65)+" "+materialNames[material];
    // " x"+nf((int)parent.moduleCoords.x,2)+" y"+nf((int)parent.moduleCoords.y,2)+" z"+nf((int)parent.moduleCoords.z,2)+" "+
    rotateZ(PI/4);
    if (applyMaterial) {
      getMaterial(applyStroke);
    } 
    if (preview) {
      stroke(0);
    }
    drawVertex();
    if (displayInfo) {
      pushMatrix();
      if (applyMaterial) {
        getInfo();
      } 
      else {
        fill(255,0,0);
      }
      textFont(pdfFont);
      textAlign(RIGHT);
      if (planeId == 0) {
        pushMatrix();
        int infoLeg = 0;
        rotateZ(PI/2);
        while (legs[infoLeg] == false) {
          infoLeg ++;
          rotateZ(-PI/2);
        }
        translate(.85,.010,0.001);
        scale(textScale);
        text(infoString,0,0);
        popMatrix();
      }  
      else {
        if (legs[0] || legs[1]) {
          pushMatrix();
          int infoLeg = 0;
          rotateZ(PI/2);
          while (legs[infoLeg] == false) {
            infoLeg ++;
            rotateZ(-PI/2);
          }
          translate(.85,.010,0.001);
          scale(textScale);
          text(infoString,0,0);
          popMatrix();
        }
        if (legs[2] || legs[3]) {
          pushMatrix();
          rotateZ(-PI/2);
          rotateZ(-PI/2);

          rotateZ(PI/2);
          int infoLeg = 2;
          while (legs[infoLeg] == false) {
            infoLeg ++;
            rotateZ(-PI/2);
          }
          translate(.85,.010,0.001);
          scale(textScale);
          text(infoString,0,0);
          popMatrix();
        }
      }

      if (planeId == 0) {
        textAlign(CENTER);
        pushMatrix();
        translate((parent.pointList[0].x/2),(parent.pointList[0].x/2),.001);
        scale(textScale);
        rotate(PI/4);
        rotate(-PI/2);
        text("B1",0,-30);
        popMatrix();

        pushMatrix();
        translate(-(parent.pointList[0].x/2),-(parent.pointList[0].x/2),.001);
        scale(textScale);
        rotate(PI/4);
        rotate(-PI/2);
        rotate(PI);
        text("B2",0,-30);
        popMatrix();

        pushMatrix();
        translate(-(parent.pointList[0].x/2),(parent.pointList[0].x/2),.001);
        scale(textScale);
        rotate(-PI/4);
        rotate(PI/2);
        text("C1",0,-30);
        popMatrix();

        pushMatrix();
        translate((parent.pointList[0].x/2),-(parent.pointList[0].x/2),.001);
        scale(textScale);
        rotate(-PI/4);
        rotate(PI/2);
        rotate(PI);
        text("C2",0,-30);
        popMatrix();
      } 
      else {
        textAlign(CENTER);
        if (legs[0] || legs[1]) {
          pushMatrix();
          translate((parent.pointList[0].x/2),(parent.pointList[0].x/2),.001);
          scale(textScale);
          rotate(PI/4);
          rotate(PI/2);
          text(char(planeId+65)+"1",0,-30);
          popMatrix();
        }

        if (legs[2] || legs[3]) {
          pushMatrix();
          translate(-(parent.pointList[0].x/2),-(parent.pointList[0].x/2),.001);
          scale(textScale);
          rotate(PI/4);
          rotate(PI/2);
          rotate(PI);
          text(char(planeId+65)+"2",0,-30);
          popMatrix();
        }
      }

      if (vizMode == 2 && material !=0 && !preview) {
        pushMatrix();
        int infoLeg = 0;
        rotateZ(PI/2);
        while (legs[infoLeg] == false) {
          infoLeg ++;
          rotateZ(-PI/2);
        }
        translate(.75,.010,-0.001);
        scale(textScale);
        textAlign(RIGHT);
        text(infoString,0,0);
        popMatrix();
      }

      if (planeId == 0) {
        rotate(PI/2);
        rotate(PI);
        textAlign(CENTER);
        pushMatrix();
        translate((parent.pointList[0].x/2),(parent.pointList[0].x/2),-.001);
        scale(textScale);
        rotate(PI/4);
        rotate(-PI/2);
        text("C2",0,-30);
        popMatrix();

        pushMatrix();
        translate(-(parent.pointList[0].x/2),-(parent.pointList[0].x/2),-.001);
        scale(textScale);
        rotate(PI/4);
        rotate(-PI/2);
        rotate(PI);
        text("C1",0,-30);
        popMatrix();

        pushMatrix();
        translate(-(parent.pointList[0].x/2),(parent.pointList[0].x/2),-.001);
        scale(textScale);
        rotate(-PI/4);
        rotate(PI/2);
        text("B1",0,-30);
        popMatrix();

        pushMatrix();
        translate((parent.pointList[0].x/2),-(parent.pointList[0].x/2),-.001);
        scale(textScale);
        rotate(-PI/4);
        rotate(PI/2);
        rotate(PI);
        text("B2",0,-30);
        popMatrix();
      } 
      else {
        textAlign(CENTER);
        if (legs[0] || legs[1]) {
          pushMatrix();
          translate((parent.pointList[0].x/2),(parent.pointList[0].x/2),-.001);
          scale(textScale);
          rotate(PI/4);
          rotate(PI/2);
          text(char(planeId+65)+"1",0,-30);
          popMatrix();
        }

        if (legs[2] || legs[3]) {
          pushMatrix();
          translate(-(parent.pointList[0].x/2),-(parent.pointList[0].x/2),-.001);
          scale(textScale);
          rotate(PI/4);
          rotate(PI/2);
          rotate(PI);
          text(char(planeId+65)+"2",0,-30);
          popMatrix();
        }
      }
      popMatrix();
    }
  }

  void calculateVertex() {
    legsNum = 0;
    for (int i=0;i<4;i++) {
      if(legs[i]) legsNum ++;
    }

    float h = parent.pointList[0].x;
    float variableJointLength = (sqrt(pow(h,2)+pow(h,2))/2);
    float divider = sin(PI/4);  

    if (planeId == 0) {   /////////////////////////////////// plane A

      // definition of plane A with leg present 

      masterList[0].locate(-parent.pointList[0].x+(variableJointLength*divider),parent.pointList[0].y-(variableJointLength*divider));
      masterList[1].locate(masterList[0].x+(jointWidth/2*divider),masterList[0].y+(jointWidth/2*divider));
      masterList[2].locate(-parent.pointList[0].x+(jointWidth/2*divider),parent.pointList[0].y+(jointWidth/2*divider));
      masterList[3].locate(-parent.pointList[1].y,parent.pointList[1].x,-parent.pointList[1].y,parent.pointList[1].x,-legWidth/2,1);
      masterList[4].locate(0,1);
      masterList[5].locate(0,1); 
      masterList[6].locate(0,1);
      masterList[7].locate(0,1);
      masterList[8].locate(legWidth/2,1);
      masterList[9].locate(parent.pointList[2].x,parent.pointList[2].y,parent.pointList[2].x,parent.pointList[2].y,parent.pointList[0].x-(jointWidth/2*divider),parent.pointList[0].y+(jointWidth/2*divider));
      masterList[10].locate(masterList[9].x-(variableJointLength*divider),masterList[9].y-(variableJointLength*divider));
      masterList[11].locate(masterList[10].x+(jointWidth/2*divider),masterList[10].y-(jointWidth/2*divider));

      // definition of plane A without leg ... modify curve... done ...... next : position 3 extra vertex centered, for later morphing!

      noLegMasterList[0].locate(-parent.pointList[0].x+(variableJointLength*divider),parent.pointList[0].y-(variableJointLength*divider));
      noLegMasterList[1].locate(noLegMasterList[0].x+(jointWidth/2*divider),noLegMasterList[0].y+(jointWidth/2*divider));
      noLegMasterList[2].locate(-parent.pointList[0].x+(jointWidth/2*divider),parent.pointList[0].y+(jointWidth/2*divider));
      noLegMasterList[3].locate(noLegMasterList[2].x+legWidth/2*divider,noLegMasterList[2].y+legWidth/2*divider);
      noLegMasterList[4].locate(0,0,0,0,noLegMasterList[3].x,noLegMasterList[3].y);
      noLegMasterList[6].locate(parent.pointList[0].x-(jointWidth/2*divider),parent.pointList[0].y+(jointWidth/2*divider));
      noLegMasterList[5].locate(0,variableJointLength*divider,0,variableJointLength*divider,noLegMasterList[6].x-(legWidth/2*divider),noLegMasterList[6].y+(legWidth/2*divider));
      noLegMasterList[7].locate(masterList[9].x-(variableJointLength*divider),masterList[9].y-(variableJointLength*divider));
      noLegMasterList[8].locate(masterList[10].x+(jointWidth/2*divider),masterList[10].y-(jointWidth/2*divider));
      noLegMasterList[9].locate(noLegMasterList[8].x,noLegMasterList[8].y);
      noLegMasterList[10].locate(noLegMasterList[8].x,noLegMasterList[8].y);
      noLegMasterList[11].locate(noLegMasterList[8].x,noLegMasterList[8].y);

      if (legs[0]) {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i].x = masterList[i].x;
          vertexList[i].y = masterList[i].y;
          vertexList[i].x1 = masterList[i].x1;
          vertexList[i].y1 = masterList[i].y1;
          vertexList[i].x2 = masterList[i].x2;
          vertexList[i].y2 = masterList[i].y2;
        }
      } 
      else {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i].x = noLegMasterList[i].x;
          vertexList[i].y = noLegMasterList[i].y;
          vertexList[i].x1 = noLegMasterList[i].x1;
          vertexList[i].y1 = noLegMasterList[i].y1;
          vertexList[i].x2 = noLegMasterList[i].x2;
          vertexList[i].y2 = noLegMasterList[i].y2;
        }
      }
      if (legs[1]) {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i+vertexNum].x = masterList[i].y;
          vertexList[i+vertexNum].y = -masterList[i].x;
          vertexList[i+vertexNum].x1 = masterList[i].y1;
          vertexList[i+vertexNum].y1 = -masterList[i].x1;
          vertexList[i+vertexNum].x2 = masterList[i].y2;
          vertexList[i+vertexNum].y2 = -masterList[i].x2;
        }
      } 
      else {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i+vertexNum].x = noLegMasterList[i].y;
          vertexList[i+vertexNum].y = -noLegMasterList[i].x;
          vertexList[i+vertexNum].x1 = noLegMasterList[i].y1;
          vertexList[i+vertexNum].y1 = -noLegMasterList[i].x1;
          vertexList[i+vertexNum].x2 = noLegMasterList[i].y2;
          vertexList[i+vertexNum].y2 = -noLegMasterList[i].x2;
        }
      }

      if (legs[2]) {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i+(vertexNum*2)].x = -masterList[i].x;
          vertexList[i+(vertexNum*2)].y = -masterList[i].y;
          vertexList[i+(vertexNum*2)].x1 = -masterList[i].x1;
          vertexList[i+(vertexNum*2)].y1 = -masterList[i].y1;
          vertexList[i+(vertexNum*2)].x2 = -masterList[i].x2;
          vertexList[i+(vertexNum*2)].y2 = -masterList[i].y2;
        }
      } 
      else {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i+(vertexNum*2)].x = -noLegMasterList[i].x;
          vertexList[i+(vertexNum*2)].y = -noLegMasterList[i].y;
          vertexList[i+(vertexNum*2)].x1 = -noLegMasterList[i].x1;
          vertexList[i+(vertexNum*2)].y1 = -noLegMasterList[i].y1;
          vertexList[i+(vertexNum*2)].x2 = -noLegMasterList[i].x2;
          vertexList[i+(vertexNum*2)].y2 = -noLegMasterList[i].y2;
        }
      }

      if (legs[3]) {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i+(vertexNum*3)].x = -masterList[i].y;
          vertexList[i+(vertexNum*3)].y = masterList[i].x;
          vertexList[i+(vertexNum*3)].x1 = -masterList[i].y1;
          vertexList[i+(vertexNum*3)].y1 = masterList[i].x1;
          vertexList[i+(vertexNum*3)].x2 = -masterList[i].y2;
          vertexList[i+(vertexNum*3)].y2 = masterList[i].x2;
        }
      } 
      else {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i+(vertexNum*3)].x = -noLegMasterList[i].y;
          vertexList[i+(vertexNum*3)].y =  noLegMasterList[i].x;
          vertexList[i+(vertexNum*3)].x1 = -noLegMasterList[i].y1;
          vertexList[i+(vertexNum*3)].y1 = noLegMasterList[i].x1;
          vertexList[i+(vertexNum*3)].x2 = -noLegMasterList[i].y2;
          vertexList[i+(vertexNum*3)].y2 = noLegMasterList[i].x2;
        }
      }
    } 
    else {     /////////////////////////////////// planes B, C

      // definition of planes BC with leg present, watch out for unused vertex!

      masterList[0].locate(variableJointLength*divider,variableJointLength*divider);
      masterList[1].locate(masterList[0].x-(jointWidth/2*divider),masterList[0].y+(jointWidth/2*divider));


      /// cambiar aqui la distancia entre B1 y B2, y entre C1 y C2    (jointWidth * divider)

      masterList[2].locate(masterList[1].x-variableJointLength*divider+planeSeparation*divider,masterList[1].y-variableJointLength*divider+planeSeparation*divider);
      masterList[3].locate(-parent.pointList[0].x+(planeSeparation*divider),parent.pointList[0].y+(planeSeparation*divider));
      masterList[4].locate(-parent.pointList[1].y,parent.pointList[1].x,-parent.pointList[1].y,parent.pointList[1].x,-legWidth/2,1);

      masterList[5].locate(0,1);
      masterList[6].locate(0,1); 
      masterList[7].locate(0,1);
      masterList[8].locate(0,1);

      masterList[9].locate(legWidth/2,1);
      masterList[10].locate(parent.pointList[2].x,parent.pointList[2].y,parent.pointList[2].x,parent.pointList[2].y,parent.pointList[0].x,parent.pointList[0].y);
      masterList[11].locate(parent.pointList[0].x,parent.pointList[0].y);

      masterList[12].locate(parent.pointList[0].x,parent.pointList[0].y);
      masterList[13].locate(parent.pointList[0].x,parent.pointList[0].y);
      masterList[14].locate(parent.pointList[1].x,parent.pointList[1].y,parent.pointList[1].x,parent.pointList[1].y,masterList[9].y,masterList[9].x);
      masterList[15].locate(masterList[8].y,masterList[8].x);
      masterList[16].locate(masterList[7].y,masterList[7].x);
      masterList[17].locate(masterList[6].y,masterList[6].x);
      masterList[18].locate(masterList[5].y,masterList[5].x);
      masterList[19].locate(masterList[4].y,masterList[4].x);
      /// cambiar aqui la distancia entre B1 y B2, y entre C1 y C2    (jointWidth * divider)

      masterList[20].locate(parent.pointList[2].y,-parent.pointList[2].x,parent.pointList[2].y,-parent.pointList[2].x,parent.pointList[0].y+(planeSeparation*divider),-parent.pointList[0].x+(planeSeparation*divider));
      masterList[21].locate(masterList[2].y,masterList[2].x);
      masterList[22].locate(masterList[1].y,masterList[1].x);
      masterList[23].locate(masterList[0].y,masterList[0].x);

      // definition of planes BC without leg present

      noLegMasterList[0].locate(masterList[0].x,masterList[0].y);
      noLegMasterList[1].locate(masterList[1].x,masterList[1].y);
      noLegMasterList[2].locate(masterList[2].x,masterList[2].y);
      noLegMasterList[3].locate((-legWidth/2*divider)+(planeSeparation*divider),(legWidth/2*divider)+(planeSeparation*divider));
      noLegMasterList[4].locate(parent.pointList[0].x-(legWidth/2*divider),parent.pointList[0].y+(legWidth/2*divider));
      noLegMasterList[5].locate(parent.pointList[0].x,parent.pointList[0].y); 
      noLegMasterList[6].locate(noLegMasterList[5].x,noLegMasterList[5].y);
      noLegMasterList[7].locate(noLegMasterList[5].x,noLegMasterList[5].y);
      noLegMasterList[8].locate(noLegMasterList[5].x,noLegMasterList[5].y);
      noLegMasterList[9].locate(noLegMasterList[5].x,noLegMasterList[5].y);
      noLegMasterList[10].locate(noLegMasterList[5].x,noLegMasterList[5].y);
      noLegMasterList[11].locate(noLegMasterList[5].x,noLegMasterList[5].y);

      noLegMasterList[12].locate(noLegMasterList[5].x,noLegMasterList[5].y);
      noLegMasterList[13].locate(noLegMasterList[5].x,noLegMasterList[5].y);
      noLegMasterList[14].locate(noLegMasterList[4].y,noLegMasterList[4].x);
      noLegMasterList[15].locate(noLegMasterList[3].y,noLegMasterList[3].x);
      noLegMasterList[16].locate(noLegMasterList[2].y,noLegMasterList[2].x);
      noLegMasterList[17].locate(noLegMasterList[1].y,noLegMasterList[1].x);
      noLegMasterList[18].locate(noLegMasterList[0].y,noLegMasterList[0].x);
      noLegMasterList[19].locate(noLegMasterList[18].y,noLegMasterList[18].x);
      noLegMasterList[20].locate(noLegMasterList[18].y,noLegMasterList[18].x);
      noLegMasterList[21].locate(noLegMasterList[18].y,noLegMasterList[18].x);
      noLegMasterList[22].locate(noLegMasterList[18].y,noLegMasterList[18].x);
      noLegMasterList[23].locate(noLegMasterList[18].y,noLegMasterList[18].x);


      if (legs[0]) {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i].x = masterList[i].x;
          vertexList[i].y = masterList[i].y;
          vertexList[i].x1 = masterList[i].x1;
          vertexList[i].y1 = masterList[i].y1;
          vertexList[i].x2 = masterList[i].x2;
          vertexList[i].y2 = masterList[i].y2;
        }
      } 
      else {
        for (int i=0;i<vertexNum;i++) {
          vertexList[i].x = noLegMasterList[i].x;
          vertexList[i].y = noLegMasterList[i].y;
          vertexList[i].x1 = noLegMasterList[i].x1;
          vertexList[i].y1 = noLegMasterList[i].y1;
          vertexList[i].x2 = noLegMasterList[i].x2;
          vertexList[i].y2 = noLegMasterList[i].y2;
        }
      }

      if (legs[1]) {
        for (int i=vertexNum;i<vertexNum*2;i++) {
          vertexList[i].x = masterList[i].x;
          vertexList[i].y = masterList[i].y;
          vertexList[i].x1 = masterList[i].x1;
          vertexList[i].y1 = masterList[i].y1;
          vertexList[i].x2 = masterList[i].x2;
          vertexList[i].y2 = masterList[i].y2;
        }
      } 
      else {
        for (int i=vertexNum;i<vertexNum*2;i++) {
          vertexList[i].x = noLegMasterList[i].x;
          vertexList[i].y = noLegMasterList[i].y;
          vertexList[i].x1 = noLegMasterList[i].x1;
          vertexList[i].y1 = noLegMasterList[i].y1;
          vertexList[i].x2 = noLegMasterList[i].x2;
          vertexList[i].y2 = noLegMasterList[i].y2;
        }
      }

      if (legs[2]) {
        for (int i=0;i<vertexNum;i++) {
          vertexList[(vertexNum*2)+i].x = -masterList[i].x;
          vertexList[(vertexNum*2)+i].y = -masterList[i].y;
          vertexList[(vertexNum*2)+i].x1 = -masterList[i].x1;
          vertexList[(vertexNum*2)+i].y1 = -masterList[i].y1;
          vertexList[(vertexNum*2)+i].x2 = -masterList[i].x2;
          vertexList[(vertexNum*2)+i].y2 = -masterList[i].y2;
        }
      } 
      else {
        for (int i=0;i<vertexNum;i++) {
          vertexList[(vertexNum*2)+i].x = -noLegMasterList[i].x;
          vertexList[(vertexNum*2)+i].y = -noLegMasterList[i].y;
          vertexList[(vertexNum*2)+i].x1 = -noLegMasterList[i].x1;
          vertexList[(vertexNum*2)+i].y1 = -noLegMasterList[i].y1;
          vertexList[(vertexNum*2)+i].x2 = -noLegMasterList[i].x2;
          vertexList[(vertexNum*2)+i].y2 = -noLegMasterList[i].y2;
        }
      }

      if (legs[3]) {
        for (int i=0;i<vertexNum;i++) {
          vertexList[(vertexNum*3)+i].x = -masterList[(vertexNum)+i].x;
          vertexList[(vertexNum*3)+i].y = -masterList[(vertexNum)+i].y;
          vertexList[(vertexNum*3)+i].x1 = -masterList[(vertexNum)+i].x1;
          vertexList[(vertexNum*3)+i].y1 = -masterList[(vertexNum)+i].y1;
          vertexList[(vertexNum*3)+i].x2 = -masterList[(vertexNum)+i].x2;
          vertexList[(vertexNum*3)+i].y2 = -masterList[(vertexNum)+i].y2;
        }
      } 
      else {
        for (int i=0;i<vertexNum;i++) {
          vertexList[(vertexNum*3)+i].x = -noLegMasterList[(vertexNum)+i].x;
          vertexList[(vertexNum*3)+i].y = -noLegMasterList[(vertexNum)+i].y;
          vertexList[(vertexNum*3)+i].x1 = -noLegMasterList[(vertexNum)+i].x1;
          vertexList[(vertexNum*3)+i].y1 = -noLegMasterList[(vertexNum)+i].y1;
          vertexList[(vertexNum*3)+i].x2 = -noLegMasterList[(vertexNum)+i].x2;
          vertexList[(vertexNum*3)+i].y2 = -noLegMasterList[(vertexNum)+i].y2;
        }
      }
    }

    for (int i=0;i<vertexList.length;i++) {
      if(vertexList[i].x1 != 0 || vertexList[i].y1 != 0 || vertexList[i].x2 != 0 || vertexList[i].y2 != 0 ) {
        vertexList[i].isBezier = true;
      } 
      else {
        vertexList[i].isBezier = false;
      }
    }
  }

  void drawVertex() {
    if (planeId == 0) {
      beginShape();
      for (int i=0;i<vertexList.length;i++) {
        vertexList[i].plot();
      }
      endShape();
    } 
    else {
      if (legs[0] || legs[1]) {
        beginShape();
        for (int i=0;i<vertexNum*2;i++) {
          vertexList[i].plot();
        }
        endShape();
      }
      if (legs[2] || legs[3]) {
        beginShape();
        for (int i=0;i<(vertexNum*2);i++) {
          vertexList[(vertexNum*2)+i].plot();
        }
        endShape();
      }
    }
   rectMode(CENTER);

    if (legs[0]) {
      rect(0,1-holeOffsetX,holeWidth,holeHeight);
    }
    if (legs[1]) {
      rect(1-holeOffsetX,0,holeHeight,holeWidth);
    }
    if (legs[2]) {
      rect(0,-1+holeOffsetX,holeWidth,holeHeight);
    }
    if (legs[3]) {
      rect(-1+holeOffsetX,0,holeHeight,holeWidth);
    }

    rectMode(CORNER);
  }

  void getInfo() {
    switch(vizMode) {
    case 0:
      fill(200,255);
      break;
    case 1:
      fill(0);
      break;
    case 2:
      switch (material) {
      case 0:
        fill(0,255);
        break;
      case 1:
        fill(0,255,0,255);
        break;
      case 2:
        fill(255,0,0,255);
        break;
      case 3:
        fill(255,128,0,255);
        break;
      case 4:
        fill(255,255,0,255);
        break;
      case 5:
        fill(72,44,17,255);
        break;
      case 6:
        fill(255,200,150,255);
        break;
      }
      break;
    }
  }

  void getMaterial(boolean applyStroke) {
    switch(vizMode) {
    case 0:
      light = false;
      noFill();
      stroke(200,200);
      strokeWeight(1.6);
      break;
    case 1:
      light = false;
      strokeWeight(2);
      switch (planeId) {
      case 0:
        stroke(30,255);
        fill(100,100,100,255);
        break;
      case 1:
        stroke(30,255);
        fill(50,50,50,255);
        break;
      case 2:
        stroke(30,255);
        fill(150,150,150,255);
        break;
      }
      break;
    case 2:       
      light = true;
      strokeWeight(2);
      switch (material) {
      case 0:
        stroke(0,200);
        fill(160,110,80,255);
        break;
      case 1:
        stroke(0,255,0,150);
        fill(0,255,0,50);
        break;
      case 2:
        stroke(255,0,0,200);
        fill(255,0,0,50);
        break;
      case 3:
        stroke(255,128,0,200);
        fill(255,128,0,50);
        break;
      case 4:
        stroke(255,255,0,200);
        fill(255,255,0,50);
        break;
      case 5:
        stroke(72,44,17,200);
        fill(72,44,17,50);
        break;
      case 6:
        stroke(255,200,150,200);
        fill(255,200,150,50);
        break;
      }
      break;
    }
    if (!applyStroke) {
      strokeWeight(1);
    }
  }
}









