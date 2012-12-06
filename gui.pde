PFont font,mediumFont,bodyFont,boldFont; 

PFont pdfFont;
// RFont pdfFont;

PImage iaacLogo, dhubLogo, iaacLogoMask, dhubLogoMask ;
boolean cursorOn;
long nextCursorTime;
int cursorDelay = 500;
String cursorIcon;

int lightGray = 255;
int midGray = 200;
int darkGray = 255;
//int lightColor = 200;
color controlPointColor = color (255,0,0);
/////////////// vertical scrollbar
VerticalScrollbar helpScrollbar;

/////////////// scrollbars
int Bnum = 0;
Scrollbar[] scrollbarList = new Scrollbar[Bnum];
float startPos[] = {
};
String scrollbarNames[]  = {
};
/////////////// options
int Onum = 3;
int Owireframe = 0;
int Osketch = 1;
int Oshaded = 2;
Option[] optionList = new Option[Onum];
boolean optionStartState[] = {
  false,false,true};
String optionNames[] = {
  "Wireframe","Sketch","Shaded"};
/////////////// check boxes
int Cnum = 1;
int Crotation = 0;
Check[] checkList = new Check[Cnum];
boolean startState[] = {
  true};
String checkNames[] = {
  "Rotate"};
/////////////// buttons
int Tnum = 8;
Button[] buttonList = new Button[Tnum];
String buttonNames[] = {
  "Reset","Load","Preview","Submit","Export","Info","Help","Random"};
int Fnum = 4;
/////////////// text fields
TextField[] textFieldList = new TextField[Fnum];
String textFieldNames[] = {
  "Name","Last name","E-mail","Location"};
int nextTextField = -1;
////////////// help text
String helpText[];
//String[] helpTextString = new String[2];

void initGui() {
  helpText = loadStrings("help.txt");
  helpScrollbar = new VerticalScrollbar(0,0,width-planeRectSize-20-10,10);

  iaacLogo = loadImage ("iaac_black.jpg");
  dhubLogo = loadImage ("dhub_black.jpg");

  iaacLogoMask = loadImage ("iaac_black.jpg");
  dhubLogoMask = loadImage ("dhub_black.jpg");

  font = loadFont("Replica-Bold-12.vlw"); 
  boldFont  = loadFont("AFCarplates-Bold-14.vlw"); 
  mediumFont = loadFont("AFCarplates-Bold-20.vlw");
  bodyFont =  loadFont("Replica-Bold-18.vlw");
  pdfFont = createFont("Arial",128);
  //  pdfFont = new RFont("Arial.ttf", 50, RFont.CENTER);

  //for (int i=0;i<Bnum;i++) {
  //  scrollbarList[i] = new Scrollbar(i,startPos[i]);
  //}

  for (int i=0;i<Cnum;i++) {
    checkList[i] = new Check(i,startState[i],0,0,checkNames[i]);
  }
  for (int i=0;i<Onum;i++) {
    optionList[i] = new Option(i,optionStartState[i],0,0,optionNames[i]);
  }
  for (int i=0;i<Tnum;i++) {
    buttonList[i] = new Button(i,0,0,buttonNames[i]);
  }
  if (applet) {
    buttonList[4].active = false;
  }
  for (int i=0;i<Fnum;i++) {
    textFieldList[i] = new TextField(i,0,0,textFieldNames[i]);
  }
}

void keyGUI (char thisKey) {
  for (int i=0;i<Fnum;i++) {
    textFieldList[i].keyTextField(thisKey);
  }
}

void updateForm() {
  textFieldList[0].val = module.authorName;
  textFieldList[1].val = module.authorLastName;
  textFieldList[2].val = module.authorEmail;
  textFieldList[3].val = module.authorCountry;
}

void updateGUI() {
  if (millis() > nextCursorTime) {
    nextCursorTime = millis() + cursorDelay;
    cursorOn = !cursorOn;
  }
  if (help) {
    helpScrollbar.update(mouseX,mouseY);
  }
  for (int i=0;i< Bnum; i++) {
    scrollbarList[i].update(mouseX, mouseY);
  }
  for (int i=0;i< Cnum; i++) {
    checkList[i].update(mouseX, mouseY);
  }
  for (int i=0;i< Onum; i++) {
    optionList[i].update(mouseX, mouseY);
  }
  for (int i=0;i< Tnum; i++) {
    buttonList[i].update(mouseX, mouseY);
  }
  for (int i=0;i< Fnum; i++) {
    textFieldList[i].update(mouseX, mouseY);
  }
  rotation = checkList[Crotation].state;
  for (int i=0;i< Onum; i++) {
    if (optionList[i].state) vizMode = i;
  }
  if (nextTextField != -1) {
    textFieldList[nextTextField].active = true;
    nextTextField = -1; 
  }
  form = false;
  for (int i=0;i<Fnum;i++) {
    if (textFieldList[i].active == true) {
      form = true;
    }
  }
  module.authorName = textFieldList[0].val;
  module.authorLastName = textFieldList[1].val;
  module.authorEmail = textFieldList[2].val;
  module.authorCountry = textFieldList[3].val;
}

void drawGUI () {
  controllerStyle();
  strokeWeight(1);
  rectMode(CORNER);
  rect(10,10,planeRectSize,height-planeRectSize-30);  
  pushMatrix();
  int cx=16;
  int cy=28;
  int lh=12;
  fill(255,200);
  textFont(mediumFont);
  pushMatrix();
  translate(cx,cy);
  scale (.5);
  text("FABRICATION LABORATORY",0,0);
  popMatrix();
  cy += 26;
  text("COLLABORATIVE",cx,cy);
  cy += 22;
  text("CLOUD",cx,cy);
  textFont(font);
  text(versionString,cx+74,cy);
  cy += 18;
  text("New Scenarios for Design and",cx,cy);
  cy += 12;
  text("Three Dimensional Production",cx,cy);
  cy += 12;
  line (10,cy,planeRectSize+10,cy);
  cy += 12;
  cy += 6;
  lh=32;
  for (int i=0;i<Fnum;i++) {
    textFieldList[i].locate(cx,cy);
    cy += lh;
    textFieldList[i].display();
  }
  /*
  pushMatrix();
   createThumbnail(true);
   translate(cx+75,cy);
   scale(.5);
   image(thumbnail,0,0);
   popMatrix();
   */
  lh= 16;
  int buttony = cy;
  buttonList[3].locate(cx,cy);
  cy += lh;
  buttonList[2].locate(cx,cy);
  cy += lh;
  buttonList[0].locate(cx,cy);
  cy += lh;
  buttonList[7].locate(cx,cy);
  cy += lh;
  buttonList[1].locate(cx,cy);
  cy += lh;
  buttonList[4].locate(cx,cy);
  cy += lh;
  buttonList[5].locate(cx,cy);
  cy += lh;
  buttonList[6].locate(cx,cy);
  cy += lh;
  cx = 100;
  cy = buttony;
  checkList[Crotation].locate(cx,cy);
  cy += lh;
  cy += lh;
  optionList[0].locate(cx,cy);
  cy += lh;
  optionList[1].locate(cx,cy);
  cy += lh;
  optionList[2].locate(cx,cy);
  //for (int i=0;i< Bnum; i++) {
  //  scrollbarList[i].display();
  //}
  for (int i=0;i< Cnum; i++) {
    checkList[i].display();
  }
  for (int i=0;i< Onum; i++) {
    optionList[i].display();
  }
  for (int i=0;i< Tnum; i++) {
    buttonList[i].display();
  }
  if (help) {
    helpScrollbar.display();
  }
  popMatrix();
}

void drawLogo() {
  pushMatrix();
  translate(-88,height-83,-500);
  scale(1.5);
  fill(255,200);
  textAlign(LEFT);
  textFont(font);
  pushMatrix();
  translate(10,160);
  text("Produced by",0,-10);
  scale(.53);
  iaacLogo.mask(iaacLogoMask);
  image(iaacLogo,0,0);
  popMatrix();
  pushMatrix();
  translate(10,10);
  text("Organized by",0,-10);
  scale(.75);
  dhubLogo.mask(dhubLogoMask);
  image(dhubLogo,0,0);
  popMatrix();
  popMatrix();
}


void pressGUI(int mx, int my) {
  for (int i=0;i< Bnum; i++) {
    scrollbarList[i].press(mx, my);
  }
  for (int i=0;i< Cnum; i++) {
    checkList[i].press(mx,my);
  }
  for (int i=0;i< Onum; i++) {
    optionList[i].press(mx,my);
  }
  for (int i=0;i< Tnum; i++) {
    buttonList[i].press(mx,my);
  }
  for (int i=0;i< Fnum; i++) {
    textFieldList[i].press(mx,my);
  }
  if (help) {
    helpScrollbar.press(mx,my);
  }
}

void releaseGUI() {
  for (int i=0;i< Bnum; i++) {
    // scrollbarList[i].release();
  }
  for (int i=0;i< Onum; i++) {
    //  optionList[i].release(mouseX,mouseY);
  }
  for (int i=0;i< Tnum; i++) {
    buttonList[i].release(mouseX,mouseY);
  }
  for (int i=0;i< Fnum; i++) {
    // textFieldList[i].release();
  }
  if (help) {
    helpScrollbar.release();
  }
}

void drawIntro() {
  pushMatrix();
  rectMode(CORNER);
  controllerStyle();
  rect(planeRectSize+20,10,width-(planeRectSize*2)-40,height-20);
  translate(210,32);
  int cy=0;
  int lh=30;
  fill(200);
  textFont(bodyFont);
  text(("Collaborative Cloud is an initiative which objective is to"),0,cy);
  cy += lh;
  text(("familiarize people with open fabrication. Besides DIY innovations"),0,cy);
  cy += lh;
  text(("and local fabrication, Collaborative Cloud introduces ideas of"),0,cy);
  cy += lh;
  text(("sharing design, tools and ideas... Collaborative Cloud is a"),0,cy);
  cy += lh;
  text(("continuously changing design and your decisions will define the"),0,cy);
  cy += lh;
  text(("final scale and form. Design your own piece and contribute to the"),0,cy);
  cy += lh;
  text(("ever growing Collaborative Cloud installation at DHUB!"),0,cy);
  cy += lh;
  cy += lh;
  textFont(font);
  text(("Built with Processing."),0,cy);
  cy += lh;
  textFont(font);
  popMatrix();
}

void drawHelp() {
  pushMatrix();
  rectMode(CORNER);
  controllerStyle();
  textLeading(15); 
  rect(planeRectSize+20,10,width-(planeRectSize*2)-40,height-20);
  translate(210,0);
  int cy=(int)(20-(height-20)*helpScrollbar.getVal());
  int lh=15;
  fill(220);
  for (int i=0;i<helpText.length;i++) {
    if (cy > 10 && cy < height-20) {
      if (helpText[i].length() > 1) {
        if (helpText[i].substring(0,1).equals("%")) {
          textFont(boldFont);
          text(helpText[i].substring(1,helpText[i].length()),0,cy,width-(planeRectSize*2)-60,width-(planeRectSize*2)-40);
        } 
        else {
          textFont(font);
          text(helpText[i],0,cy,width-(planeRectSize*2)-60,width-(planeRectSize*2)-40);
        }
      }

    }
    cy += lh;
  }
  textFont(font);
  popMatrix();
}

class Option { 
  int num;
  float x, y;
  int size;       
  String name;
  boolean state;
  boolean rollover;

  Option(int thisN, boolean thisState, float thisX, float thisY, String thisName) { 
    num = thisN;
    x =thisX;
    y = thisY;
    state = thisState;
    size = 9; 
    name = thisName;
  } 
  void press(float mx, float my) { 
    if ((mx >= x) && (mx <= x+size) && (my >= y) && (my <= y+size)) { 
      if (state != true) {
        for (int i=0;i<Onum;i++) {
          optionList[i].state = false;
        }
        state = true;
      }
    } 
  } 

  void locate(float thisX,float thisY) {
    x = thisX;
    y = thisY;
  }

  void update (int mx, int my) {
    rollover = over (mx, my);
  }

  void display() { 
    if (rollover) {
      stroke(255); 
    } 
    else {
      stroke(midGray); 
    }
    if (state == true) { 
      fill(midGray);
    } 
    else {
      noFill();
    }
    ellipseMode(CENTER);
    ellipse(x+size/2, y+size/2, size, size); 
    if (rollover) {
      fill(255);
    } 
    else {
      fill(midGray);
    }
    textFont(font); 
    text(name, x+12, y+9); 
  } 

  boolean over(int mx, int my) {
    if ((mx > x) && (mx < x+size) && (my > y) && (my < y+size)) { 
      return true; 
    } 
    else { 
      return false; 
    } 
  }
} 

class Check { 
  int num;
  float x, y;              
  int size;                
  String name;
  boolean state;
  boolean rollover;
  Check(int thisN, boolean thisState, float thisX, float thisY, String thisName) { 
    num = thisN;
    x =thisX;
    y = thisY;
    state = thisState;
    size = 8; 
    name = thisName;
  } 
  void press(float mx, float my) { 
    if ((mx >= x) && (mx <= x+size) && (my >= y) && (my <= y+size)) { 
      state = !state;
    } 
  } 

  void locate(float thisX,float thisY) {
    x = thisX;
    y = thisY;
  }

  void update (int mx, int my) {
    rollover = over (mx, my);
  }

  void display() { 
    strokeWeight(1);
    if (rollover == true) {
      stroke(255); 
    } 
    else {
      stroke(midGray); 
    }
    noFill();
    rect(x, y, size, size); 
    if (state == true) { 
      line(x, y, x+size, y+size); 
      line(x+size, y, x, y+size); 
    } 
    if (rollover == true) {
      fill(255);
    } 
    else {
      fill(midGray);
    }

    textFont(font); 
    text(name, x+12, y+9); 
  } 

  boolean over(int mx, int my) { 
    if ((mx > x) && (mx < x+size) && (my > y) && (my < y+size)) { 
      return true; 
    } 
    else { 
      return false; 
    } 
  }
} 

class Button {
  int num;
  float x, y;              
  int sw,sh;          
  String name;
  boolean rollover;
  boolean pressed;
  boolean active;
  Button(int thisN, float thisX, float thisY, String thisName) { 
    num = thisN;
    x = thisX;
    y = thisY;
    sh = 8; 
    sw = 20;
    name = thisName;
    active = true;
  } 

  void press(int mx, int my) { 
    if (over(mx, my) && active) { 
      pressed = true;
      executeCommand(num);
    } 
  }

  void release(int mx, int my) {
    pressed = false;
  }

  void locate(float thisX,float thisY) {
    x = thisX;
    y = thisY;
  }

  void update (int mx, int my) {
    rollover = over (mx, my);
  }

  void displayInv() {
    if (rollover) {
      stroke (50);
    } 
    else {
      stroke(150); 
    }
    if (pressed == true) {
      fill(100);
    } 
    else {
      noFill();
    }
    textAlign(LEFT);
    rect(x, y, sw, sh); 
    if (rollover) {
      fill (50);
    } 
    else {
      fill(150); 
    }
    textFont(font); 
    text(name, x+sw+4, y+9); 
  }

  void display() { 
    if (active ) {
      if (rollover) {
        stroke(255); 
      }  
      else {
        stroke(midGray); 
      } 
    }
    else {
      stroke(80);
    }
    noFill();
    if (pressed == true) {
      fill(lightGray);
    } 
    else {
      noFill();
    }
    rectMode(CORNER);
    rect(x, y, sw, sh); 
    if (active ) {
      if (rollover) {
        fill(255);
      } 
      else {
        fill(midGray);
      }     
    }
    else {
      fill(80);
    }
    textFont(font); 
    text(name, x+sw+4, y+9); 
  } 

  boolean over(int mx, int my) {
    if ((mx > x) && (mx < x+sw) && (my > y) && (my < y+sh)) { 
      return true; 
    } 
    else { 
      return false; 
    } 
  }
}

class Scrollbar { 
  int num;
  float x, y;              // The x- and y-coordinates 
  float sw, sh;          // Width and height of scrollbar 
  float pos;             // Position of thumb 
  float posMin, posMax;  // Max and min values of thumb 
  boolean rollover;      // True when the mouse is over 
  boolean locked;        // True when its the active scrollbar 
  float minVal, maxVal;  // Min and max values for the thumb 
  String name;
  Scrollbar (int n, float sp, float thisX, float thisY) { 
    num = n;
    x = thisX;
    y = thisY; 
    sw = 60;
    sh = 8;
    name = scrollbarNames[num];
    minVal = 0; 
    maxVal = 1; 
    posMin = x; 
    posMax = x + sw - sh; 
    float scalar = sw-sh;
    pos =  x +  (sp*scalar);
  } 

  void locate(float thisX,float thisY) {
    float currentVal = getVal();
    x = thisX;
    y = thisY;
    posMin = x; 
    posMax = x + sw - sh; 
    float scalar = sw-sh;
    pos =  x +  (currentVal*scalar);
  }

  void update(int mx, int my) { 
    if (over(mx, my) == true) { 
      rollover = true; 
    } 
    else { 
      rollover = false; 
    } 
    if (locked == true) { 
      pos = constrain(mx-sh/2, posMin, posMax); 
    } 
  } 

  void press(int mx, int my) { 
    if (rollover == true) { 
      locked = true; 
    } 
    else { 
      locked = false; 
    } 
  } 

  void release() {
    locked = false; 
  } 

  boolean over(int mx, int my) {
    if ((mx > x) && (mx < x+sw) && (my > y) && (my < y+sh)) { 
      return true; 
    } 
    else { 
      return false; 
    } 
  } 

  void display() { // Draws the scrollbar to the screen 

    stroke(midGray);
    noFill();
    rect(x, y, sw, sh); 
    rect(pos, y, sh, sh); 
    if ((rollover==true) || (locked==true)) { 
      fill(darkGray); 
    } 
    else { 
      fill(midGray); 
    } 
    textFont(font); 
    text(getVal(), x+sw, y+8); 
    text(name, x+100, y+8); 
  } 

  float getVal() {
    float scalar = sw/(sw-sh); 
    float ratio = (pos - x) * scalar; 
    float offset = minVal + (ratio/sw * (maxVal-minVal)); 
    return offset; 
  } 

  void setVal(float mval) {
    float scalar = (sw-sh); 
    float pos =  x +  (mval*scalar);
  }
} 

class VerticalScrollbar { 
  int num;
  float x, y;              // The x- and y-coordinates 
  float sw, sh;          // Width and height of scrollbar 
  float pos;             // Position of thumb 
  float posMin, posMax;  // Max and min values of thumb 
  boolean rollover;      // True when the mouse is over 
  boolean locked;        // True when its the active scrollbar 
  float minVal, maxVal;  // Min and max values for the thumb 

  VerticalScrollbar (int n, float sp, float thisX, float thisY) { 
    num = n;
    x = thisX;
    y = thisY; 
    sw = 10;
    sh = height-20;
    minVal = 0; 
    maxVal = 1; 
    posMin = y; 
    posMax = y + sh - sw; 
    float scalar = sw-sh;
    pos = y +  (sp*scalar);
  } 

  void locate(float thisX,float thisY) {

  }

  void update(int mx, int my) { 
    float currentVal = getVal();
    //  println(currentVal);
    // x = thisX;
    // y = thisY;
    // posMin = y; 
    // posMax = y + sh - sw; 


    if (over(mx, my) == true) { 
      rollover = true; 
    } 
    else { 
      rollover = false; 
    } 
    if (locked == true) { 
      pos = constrain(my-sw/2, posMin, posMax); 
      //     float scalar = sw-sh;
      //pos = y +  (currentVal*scalar);
    } 
  } 

  void press(int mx, int my) { 
    if (rollover == true) { 
      locked = true; 
    } 
    else { 
      locked = false; 
    } 
  } 

  void release() {
    locked = false; 
  } 
  boolean over(int mx, int my) {
    if ((mx > x) && (mx < x+sw) && (my > y) && (my < y+sh)) { 
      return true; 
    } 
    else { 
      return false; 
    } 
  } 

  void display() { // Draws the scrollbar to the screen 
    if ((rollover==true) || (locked==true)) { 
      stroke(darkGray); 

    } 
    else { 
      fill(midGray);
      stroke(midGray);
    } 

    if (locked) {
      fill(255);
    } 
    else {
      noFill();
    }
    rect(x, pos, sw, sw); 
    noFill();
    rect(x, y, sw, sh); 
    textFont(font); 
    //text(getVal(), x+sw, y+8); 
    // text(name, x+100, y+8); 
  } 

  float getVal() {
    float scalar = sh/(sh-sw); 
    float ratio = (pos - y) * scalar; 
    float offset = minVal + (ratio/sh * (maxVal-minVal)); 
    return offset; 
  } 

  void setVal(float mval) {
    float scalar = (sw-sh); 
    float pos =  x +  (mval*scalar);
  }
} 

class TextField { 
  int num;
  float x, y;            
  float sw, sh;        
  boolean rollover;      
  boolean active;       
  String val;

  String name;

  TextField (int n, float thisX, float thisY, String thisName) { 
    num = n;
    x = thisX;
    y = thisY; 
    sw = planeRectSize - 12;
    sh = 16;
    name = thisName;
    val = "";
  } 

  void locate(float thisX,float thisY) {
    x = thisX;
    y = thisY;
  }

  void update(int mx, int my) { 
    if (over(mx, my) == true) { 
      rollover = true; 
    } 
    else { 
      rollover = false; 
    } 
  } 

  void press(int mx, int my) { 
    if (rollover == true) { 
      active = true; 
    } 
    else { 
      active = false; 
    } 
  } 

  void release() {   
  } 

  boolean over(int mx, int my) {
    if ((mx > x) && (mx < x+sw) && (my > y) && (my < y+sh)) { 
      return true; 
    } 
    else { 
      return false; 
    } 
  } 

  void display() {
    stroke(midGray);
    if (active) {
      strokeWeight(2);
    } 
    else {
      strokeWeight(1);
    }
    noFill();
    rectMode(CORNER);
    rect(x, y, sw, sh); 
    if ((rollover==true) || (active==true)) { 
      fill(255); 
    } 
    else { 
      fill(midGray); 
    } 
    textAlign(LEFT);
    textFont(font); 
    text(name, x, y-2); 
    textFont(font);
    if (cursorOn && active) {
      cursorIcon = "_";
    } 
    else {
      cursorIcon = "";
    }
    text(val.substring(constrain(val.length()-22,0,val.length()),val.length())+cursorIcon, x+2, y+12); 
  } 

  void keyTextField(char thisKey) {
    if (active) {
      if ((val.length() < 40) && ((thisKey > 64 && thisKey < 123) || (thisKey > 47 && thisKey < 58) || (thisKey == 64 && textFieldList[2].active == true)
        || (thisKey == 32 && textFieldList[2].active == false) || thisKey == 46 || thisKey == 241 || thisKey == 95 || thisKey == 45 ))  {
        val += thisKey;
        cursorOn = true; 
        nextCursorTime = millis() + cursorDelay;
      } 
      else if (thisKey == BACKSPACE && val.length()>0) {
        val = val.substring(0,val.length()-1);
      } 
      else if (thisKey == ENTER || thisKey == RETURN || (int)thisKey == 10 || (int)thisKey == 9) {
        active = false;
        nextTextField = num+1;
        if (nextTextField == Fnum) nextTextField = -1;
      }
    }
  }

  String getVal() {
    return val; 
  } 

  void setVal(String _val) { 
    val = _val;
  }
} 

boolean getRandomBoolean() {
  if (random(millis())<millis()/2) {
    return true;
  } 
  else {
    return false;
  }
}




















