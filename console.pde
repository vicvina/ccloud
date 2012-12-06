
String message;
float currentAlpha, targetAlpha;
float consoleX,consoleY;
float consoleDelay = .05;

void initConsole() {
  consoleX = width/2;
  consoleY = height/2;
}

void printMessage (String thisString) {
  message = thisString;
  currentAlpha = 500;
  targetAlpha = 0;
}

void updateConsole() {
  if (currentAlpha > 1) {
    textAlign(CENTER);
    textFont (bodyFont);
    if (preview) {
      fill (100, constrain(currentAlpha,0,255));
    } 
    else {
      fill (255, constrain(currentAlpha,0,255));
    }
    text(message,consoleX,consoleY);
    currentAlpha += (targetAlpha-currentAlpha)*consoleDelay;
  }
}









