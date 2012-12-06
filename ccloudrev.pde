import processing.pdf.*;


import processing.opengl.*;
import javax.media.opengl.*;
import damkjer.ocd.*;

//import geomerative.*;

String versionString = "4.00";

boolean applet = false;

boolean gui = true;
boolean intro = false;
boolean help = false;
boolean dragged = false;
boolean inverted = true;
boolean precission = false;
boolean preview = false;
boolean form = true;
boolean light = true;
boolean rotation = true;

boolean thumbnails = false;

int vizMode = 2;
//boolean secondHelpScreen = false;

int backgroundColor;

void setup() {
  //RG.init(this);
  size(1000,600,OPENGL);
  frameRate(24);
  hint(DISABLE_OPENGL_ERROR_REPORT);
  // hint(DISABLE_OPENGL_2X_SMOOTH);  
  // hint(ENABLE_OPENGL_4X_SMOOTH);
  bezierDetail(30);
  addMouseWheelListener(new java.awt.event.MouseWheelListener() { 
    public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) { 
      mouseWheel(evt.getWheelRotation());
    }
  }
  ); 
  loadParameters();
  createModules();
  initController();
  initGui();
  initCamera();
  initPreview();
  initConsole();
  printMessage("Welcome to Collaborative Cloud at DHUB");
}

void draw() {
  if (inverted) {
    backgroundColor = 20;
  } 
  else {
    backgroundColor = 255;
  }
  background(backgroundColor);
  if (!preview) {
    if (light) {
      lights();  
    } 
    pushMatrix();
    updateCamera();
    drawModules();
    popMatrix();
  }
  resetCamera();
  noLights();
  drawLogo();
  GL gl=((PGraphicsOpenGL)g).beginGL();
  gl.glClear(GL.GL_DEPTH_BUFFER_BIT);
  ((PGraphicsOpenGL)g).endGL();

  if (gui) {
    if (intro) {
      drawIntro();
    }
    if (help) {
      drawHelp();
    }
    updateController();
    updateGUI();
    drawController();
    drawGUI();

  }
  if (preview) {
    updatePreview();
    drawPreview();
  }
  updateConsole();
}

void mousePressed() {
  if (!preview) {
    pressGUI(mouseX,mouseY);
    pressController();
    if (!precission && !form) {

      if (mouseX > 200 && mouseX < width-planeRectSize-10) {
        if (intro) {
          intro = false;
        } 
        else if (help) {

        } 
        else {
          pressCamera();
        }
      }
    }
  } 
  else {
    pressPreview();
  }
}

void mouseReleased() {
  releasePreview();
  releaseGUI();
  releaseController();
  releaseCamera();
}

void mouseWheel(int delta) {
  if (preview) {
    previewScale -= delta*2;
    //  previewX += (width/2-previewX)/delta/previewScale*2;
    //  previewY += (height/2-previewY)/delta/previewScale*2;
    if (previewScale < 100) previewScale = 100;
  } 
  else if (!precission) {
    zoom -= delta/1000.0;
  }
}

void keyPressed(){
  if (!form) {
    switch(key) {
    case 'P':
      loadParameters();
      break;
    case ENTER:
      if (!preview) {
        checkList[Crotation].state = !checkList[Crotation].state;
        break;
      }
    case ' ':
      if (!preview) {
        vizMode ++;
        if (vizMode>2) vizMode =0;
        for (int i=0;i<Onum; i++) {
          optionList[i].state = false;
        }
        optionList[vizMode].state = true;
        break;
      }
    case '.':
      if (!preview) {
        controllerCheck.state = !controllerCheck.state;
        if (controllerCheck.state) {
          intro = false;
          help = false;
        }
      }
      break;
    case 'p':
      preview = !preview;
      if (preview) {
        intro = false;
        help = false;
        //  thumbnails = false;
      }
      break;
    case 't':
      /*
      thumbnails = !thumbnails;
       if (thumbnails) {
       intro = false;
       help = false;
       preview = false;
       }
       */
      break;
    case 'r':
      module.randomModule();
      printMessage("Random module generated");
      break;
    case 'R':
      module.randomModule();
      break;
    case TAB:
      if (!preview) {
        gui = !gui;
      }
      break;
    }
  } 
  else {
    keyGUI(key);
  }
}

void executeCommand(int thisCommand) {
  switch (thisCommand) {
  case 0:
    for (int i=0;i<Onum; i++) {
      optionList[i].state = false;
    }
    optionList[2].state = true;
    initCamera();
    module.resetModule();
    updateForm();
    printMessage("Module reset");
    break;
  case 1:
    for (int i=0;i<Onum; i++) {
      optionList[i].state = false;
    }
    optionList[2].state = true;
    readModuleDefinition();
    break;   
  case 2:
    preview = true;
    help = false;
    intro = false;
    break;
  case 3:
    writeModuleDefinition();
    break;   
  case 4:
    if (!applet) {
      savePdf();
    } 
    else {
      printMessage("Please use local version to save PDF format");
    }
    break;   
  case 5:
    controllerCheck.state = false;
    help = false;
    intro = true;
    break;   
  case 6:
    controllerCheck.state = false;
    help = true;
    intro = false;
    break;  
  case 7:
    module.randomModule();
    printMessage("Random module generated");
    break;   
  case 10:
    preview = false;
    break;   
  }
}









