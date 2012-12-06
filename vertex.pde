  class Vertex {
  boolean isBezier;
  float x,y,x1,y1,x2,y2,u,v;
  Vertex () {
  }

  void locate(float thisX, float thisY) {
    x = thisX;
    y = thisY;
  }

  void locate(float thisX1, float thisY1, float thisX2, float thisY2, float thisX, float thisY) {
    x1 = thisX1;
    y1 = thisY1;
    x2 = thisX2;
    y2 = thisY2;
    x = thisX;
    y = thisY;
  }

  void plot() {
    if (isBezier) {
      bezierVertex(x1,y1,x2,y2,x,y);
    } 
    else {
      vertex (x,y);
    }
  }

  void plot(PGraphics pdf) {
    if (isBezier) {
      pdf.bezierVertex(x1,y1,x2,y2,x,y);
    } 
    else {
      pdf.vertex (x,y);
    }
  }
}


