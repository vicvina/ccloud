
float pdfSrokeWeight = .000001;
float previewScale = 150;
float previewX; 
float previewY;
float previewOffsetX;
float previewOffsetY;
float planeOffset = 2.1;
boolean previewDragged = false;

PGraphics thumbnail;
Button closeButton;

void initPreview() {
  thumbnail = createGraphics(300,300,P3D);
  previewX = width/2;
  previewY = height/2;
  closeButton = new Button(10,0,0,"Close");
}

void drawThumbnails() {
  controllerStyle();
  fill(backgroundColor);
  noStroke();
  rect(10,10,width-20,height-20);
  createThumbnail(true);
  pushMatrix();
  translate(width/2-150,height/2-250);
  image(thumbnail,0,0);
  popMatrix();
}

void drawPreview() {
  module.update();
  pushMatrix();
  controllerStyle();
  fill(255);
  stroke(0);
  rect(10,10,width-20,height-20);
  translate(previewX,previewY);
  scale(previewScale);

  pushMatrix();
  rotateZ(PI+PI/4);
  noFill();
  module.planeList[1].display(true,false,false,false);
  popMatrix();

  pushMatrix();
  translate(-planeOffset,0);
  rotateZ(PI+PI/4);
  noFill();
  module.planeList[0].display(true,false,false,false);
  popMatrix();

  pushMatrix();
  translate(planeOffset,0);
  rotateZ(PI+PI/4);
  noFill();
  module.planeList[2].display(true,false,false,false);
  popMatrix();
  popMatrix();   
  strokeWeight(1);
  closeButton.locate(20,20);
  closeButton.displayInv();
  fill(0);
  noStroke();
  rect(0,0,width,10);
  rect(0,height-10,width,height);
  rect(0,10,10,height);
  rect(width-10,0,width,height);
}

void updatePreview() {
  closeButton.update(mouseX,mouseY); 
  if (previewDragged) {
    previewX = (mouseX-previewOffsetX);
    previewY = (mouseY-previewOffsetY);
  }
}

void pressPreview() {
  closeButton.press(mouseX,mouseY);
  previewOffsetX = mouseX-previewX;
  previewOffsetY = mouseY-previewY;
  previewDragged = true;
}

void releasePreview() {
  closeButton.release(mouseX,mouseY);
  previewDragged = false;
} 

void savePdf () {
  if (module.authorEmail == null || module.authorEmail.equals("")) {
    printMessage("Please enter personal data to export module");
  } 
  else {
    String fileName = module.authorEmail+".pdf";
    PGraphics pdf = createGraphics((int)pdfScale*3, (int)pdfScale, PDF, "pdf/"+fileName);

    pdf.beginDraw();
    pdf.background(255);
    pdf.bezierDetail(200);
    pdf.translate(pdfScale*3/2,pdfScale/2);

    pdf.pushMatrix();
    pdf.translate(-pdfScale,0);
    drawPlane(pdf,pdfScale/2,0,true);
    pdf.popMatrix();

    pdf.pushMatrix();
    drawPlane(pdf,pdfScale/2,1,true);
    pdf.popMatrix();

    pdf.pushMatrix();
    pdf.translate(pdfScale,0);
    drawPlane(pdf,pdfScale/2,2,true);
    pdf.popMatrix();

    pdf.dispose();
    pdf.endDraw();
    printMessage("Module exported to "+fileName);
  }
}

void drawPlane(PGraphics pdf, float thisScale, int thisPlane, boolean drawInfo) {

  pdf.scale(thisScale);
  if (drawInfo) {
    pdf.fill(255,0,0);
    pdf.textFont(pdfFont);
    pdf.textAlign(RIGHT);

    if (module.planeList[thisPlane].planeId == 0) {
      pdf.pushMatrix();
      int infoLeg = 0;
      while (module.planeList[thisPlane].legs[infoLeg] == false) {
        infoLeg ++;
        pdf.rotate(-PI/2);
      }
      pdf.translate(.85,.010);
      pdf.scale(textScale);
      pdf.text(module.planeList[thisPlane].infoString,0,0);
      pdf.popMatrix();
    }  
    else { 
      if (module.planeList[thisPlane].legs[0] || module.planeList[thisPlane].legs[1]) {
        pdf.pushMatrix();
        int infoLeg = 0;
        while (module.planeList[thisPlane].legs[infoLeg] == false) {
          infoLeg ++;
          pdf.rotate(-PI/2);
        }
        pdf.translate(.85,.010);
        pdf.scale(textScale);
        pdf.text(module.planeList[thisPlane].infoString,0,0);
        pdf.popMatrix();
      }
      if (module.planeList[thisPlane].legs[2] || module.planeList[thisPlane].legs[3]) {
        pdf.pushMatrix();
        pdf.rotate(-PI/2);
        pdf.rotate(-PI/2);
        int infoLeg = 2;
        while (module.planeList[thisPlane].legs[infoLeg] == false) {
          infoLeg ++;
          pdf.rotate(-PI/2);
        }
        pdf.translate(.85,.010);
        pdf.scale(textScale);
        pdf.text(module.planeList[thisPlane].infoString,0,0);
        pdf.popMatrix();
      }
    }

    if (module.planeList[thisPlane].planeId == 0) {
      pdf.textAlign(CENTER);
      pdf.pushMatrix();
      pdf.translate((module.pointList[0].x/2),(module.pointList[0].x/2));
      pdf.scale(textScale);
      pdf.rotate(PI/4);
      pdf.rotate(-PI/2);
      pdf.text("C1",0,-30);
      pdf.popMatrix();

      pdf.pushMatrix();
      pdf.translate(-(module.pointList[0].x/2),-(module.pointList[0].x/2));
      pdf.scale(textScale);
      pdf.rotate(PI/4);
      pdf.rotate(-PI/2);
      pdf.rotate(PI);
      pdf.text("C2",0,-30);
      pdf.popMatrix();

      pdf.pushMatrix();
      pdf.translate(-(module.pointList[0].x/2),(module.pointList[0].x/2));
      pdf.scale(textScale);
      pdf.rotate(-PI/4);
      pdf.rotate(PI/2);
      pdf.text("B1",0,-30);
      pdf.popMatrix();

      pdf.pushMatrix();
      pdf.translate((module.pointList[0].x/2),-(module.pointList[0].x/2));
      pdf.scale(textScale);
      pdf.rotate(-PI/4);
      pdf.rotate(PI/2);
      pdf.rotate(PI);
      pdf.text("B2",0,-30);
      pdf.popMatrix();
    } 
    else {
      pdf.textAlign(CENTER);
      if (module.planeList[thisPlane].legs[0] || module.planeList[thisPlane].legs[1]) {
        pdf.pushMatrix();
        pdf.rotate(PI/2);
        pdf.translate((module.pointList[0].x/2),(module.pointList[0].x/2));
        pdf.scale(textScale);
        pdf.rotate(PI/4);
        pdf.rotate(PI/2);
        pdf.text(char(module.planeList[thisPlane].planeId+65)+"1",0,-30);
        pdf.popMatrix();
      }
      if (module.planeList[thisPlane].legs[2] || module.planeList[thisPlane].legs[3]) {
        pdf.pushMatrix();
        pdf.rotate(PI/2);
        pdf.translate(-(module.pointList[0].x/2),-(module.pointList[0].x/2));
        pdf.scale(textScale);
        pdf.rotate(PI/4);
        pdf.rotate(PI/2);
        pdf.rotate(PI);
        pdf.text(char(module.planeList[thisPlane].planeId+65)+"2",0,-30);
        pdf.popMatrix();
      }
    }
  }

  pdf.pushMatrix();
  pdf.rotate(PI);
  pdf.rotate(PI/2);
  pdf.noFill();
  pdf.stroke(0);
  pdf.strokeWeight(pdfSrokeWeight);
  //module.planeList[thisPlane].calculateVertex();
  if (thisPlane == 0) {
    pdf.beginShape();
    for (int i=0;i<module.planeList[thisPlane].vertexList.length;i++) {
      module.planeList[thisPlane].vertexList[i].plot(pdf);
    }
    pdf.endShape();
  } 
  else {
    if (module.planeList[thisPlane].legs[0] || module.planeList[thisPlane].legs[1]) {
      pdf.beginShape();
      for (int i=0;i<module.planeList[thisPlane].vertexNum*2;i++) {
        module.planeList[thisPlane].vertexList[i].plot(pdf);
      }
      pdf.endShape();
    }
    if (module.planeList[thisPlane].legs[2] || module.planeList[thisPlane].legs[3]) {
      pdf.beginShape();
      for (int i=0;i<(module.planeList[thisPlane].vertexNum*2);i++) {
        module.planeList[thisPlane].vertexList[(module.planeList[thisPlane].vertexNum*2)+i].plot(pdf);
      }
      pdf.endShape();
    }
  }

  pdf.rectMode(CENTER);

  if (module.planeList[thisPlane].legs[0]) {
   pdf.rect(0,1-holeOffsetX,holeWidth,holeHeight);
  }
  if (module.planeList[thisPlane].legs[1]) {
   pdf.rect(1-holeOffsetX,0,holeHeight,holeWidth);
  }
  if (module.planeList[thisPlane].legs[2]) {
    pdf.rect(0,-1+holeOffsetX,holeWidth,holeHeight);
  }
  if (module.planeList[thisPlane].legs[3]) {
    pdf.rect(-1+holeOffsetX,0,holeHeight,holeWidth);
  }

  pdf.rectMode(CORNER);


  pdf.popMatrix();
}

void createThumbnail(boolean soft) {
  thumbnail.beginDraw();
  thumbnail.background(backgroundColor);
  if (soft) {
    thumbnail.smooth();
  } 
  else {
    thumbnail.noSmooth();
  }
  thumbnail.fill(backgroundColor);
  thumbnail.translate(150,150);
  thumbnail.rotateX(millis()/10000.0);
  thumbnail.rotateZ(millis()/10000.0);
  thumbnail.rotateY(millis()/10000.0);
  thumbnail.scale(90);
  thumbnail.stroke(255);
  thumbnail.strokeWeight(2);
  drawModule(thumbnail);
  thumbnail.endDraw();
}

void drawModule(PGraphics pg) {
  pg.pushMatrix();
  drawPlane(pg,1,0,false);
  pg.popMatrix();
  pg.pushMatrix();
  pg.rotateY(PI/2);
  drawPlane(pg,1,1,false);
  pg.popMatrix();
  pg.pushMatrix();
  pg.rotateX(PI/2);
  pg.rotateZ(PI/2);
  drawPlane(pg,1,2,false);
  pg.popMatrix();
}

/*
void drawOutlineText(PGraphics pdf, String thisString) {
 RGroup grp = pdfFont.toGroup(thisString);                               
 for ( int i = 0; i < grp.elements.length; i++ ) {
 RShape shp = grp.elements[i].toShape();                  
 for ( int ii = 0; ii < shp.paths.length; ii++ ) {
 RPath sushp = shp.paths[ii];                   
 for ( int iii = 0; iii < sushp.commands.length; iii++ ) {
 RPoint[] pnts = sushp.commands[iii].getHandles();            
 if ( pnts.length < 2 ) continue;
 switch( sushp.commands[iii].getCommandType() ) {
 case RCommand.LINETO:
 pdf.line( pnts[0].x, pnts[0].y, pnts[1].x, pnts[1].y );
 break;
 case RCommand.QUADBEZIERTO:
 pdf.bezier( pnts[0].x, pnts[0].y, pnts[1].x, pnts[1].y, pnts[1].x, pnts[1].y, pnts[2].x, pnts[2].y );
 break;
 case RCommand.CUBICBEZIERTO:
 pdf.bezier( pnts[0].x, pnts[0].y, pnts[1].x, pnts[1].y, pnts[2].x, pnts[2].y, pnts[3].x, pnts[3].y );
 break;
 }
 }
 }
 }
 }
 
 
 void drawOutlineText(String thisString) {
 RGroup grp = pdfFont.toGroup(thisString);                               
 for ( int i = 0; i < grp.elements.length; i++ ) {
 RShape shp = grp.elements[i].toShape();                  
 for ( int ii = 0; ii < shp.paths.length; ii++ ) {
 RPath sushp = shp.paths[ii];                   
 for ( int iii = 0; iii < sushp.commands.length; iii++ ) {
 RPoint[] pnts = sushp.commands[iii].getHandles();            
 if ( pnts.length < 2 ) continue;
 switch( sushp.commands[iii].getCommandType() ) {
 case RCommand.LINETO:
 line( pnts[0].x, pnts[0].y, pnts[1].x, pnts[1].y );
 break;
 case RCommand.QUADBEZIERTO:
 bezier( pnts[0].x, pnts[0].y, pnts[1].x, pnts[1].y, pnts[1].x, pnts[1].y, pnts[2].x, pnts[2].y );
 break;
 case RCommand.CUBICBEZIERTO:
 bezier( pnts[0].x, pnts[0].y, pnts[1].x, pnts[1].y, pnts[2].x, pnts[2].y, pnts[3].x, pnts[3].y );
 break;
 }
 }
 }
 }
 }
 */


























