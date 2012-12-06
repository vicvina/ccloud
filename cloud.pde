Module module;

void createModules() {
  module = new Module(0,0,0,0);
}

void drawModules() {
  module.update();  
  module.display();  
}



/*

 int cloudSize = 10;
 int moduleNum = 8;// cloudSize*cloudSize;
 
 ArrayList moduleList = new ArrayList();
 
 void createModules() {
 //img = loadImage("wood/berg_ahorn_color.jpg");
 moduleList.add(new Module(0,0,0,0));
 }
 
 void createNewModule() {
 boolean freeFlag = false;
 boolean adjacentFlag =false;
 
 PVector newCoords = new PVector (-100,-100,-100);
 int counter = 0;
 while((freeFlag == false || adjacentFlag == false) && counter < 100) {
 counter ++;
 // newCoords.set((int)random(cloudSize)-cloudSize/2,(int)random(cloudSize)-cloudSize/2,(int)random(cloudSize)-cloudSize/2);   
 newCoords.set((int)random(cloudSize),(int)random(cloudSize),(int)random(cloudSize));   
 freeFlag = true;
 for (int i=0;i<moduleList.size();i++) {
 Module currentModule = (Module) moduleList.get(i);
 //  println(round(PVector.sub(currentModule.moduleCoords,newCoords).mag()));
 if (round(PVector.sub(currentModule.moduleCoords,newCoords).mag()) == 0) {
 freeFlag = false;
 println ("sameCoords");
 break;
 }
 }
 adjacentFlag = false;
 PVector newPos = coordsToPos(newCoords);
 for (int i=0;i<moduleList.size();i++) {
 Module currentModule = (Module) moduleList.get(i);
 if (round(PVector.dist(currentModule.modulePos,newPos)) == 2) {
 adjacentFlag = true;
 break;
 }
 }
 }
 if (counter < 100) {
 moduleList.add(new Module(0,(int)newCoords.x,(int)newCoords.y,(int)newCoords.z));
 } 
 else {
 println("cloud full");
 }
 
 }
 
 
 void drawAxis() {
 pushMatrix();
 line(0,0,0,1,0,0);
 line(0,0,0,0,1,0);
 line(0,0,0,0,0,1);
 popMatrix();
 }
 
 void drawConnectors() {
 if (checkList[Clines].state) {
 stroke(100,scrollbarList[Blines].getVal()*255);
 strokeWeight(scrollbarList[Bwidth].getVal()*5);
 }
 if (checkList[Cfill].state) {
 fill(100,scrollbarList[Balpha].getVal());
 }
 for (int i=0;i<moduleList.size();i++) {
 Module moduleA =  (Module)moduleList.get(i);
 for (int j=i+1;j<moduleList.size();j++) {
 if (i != j) {
 Module moduleB = (Module)moduleList.get(j);
 if (checkIfAdjacent(moduleA,moduleB)) {  // if adjacent
 PVector offset = PVector.sub(moduleB.modulePos,moduleA.modulePos);  // vector between modules' center
 PVector middlePoint = PVector.add(moduleA.modulePos,PVector.div(offset,2)); // middle point bettwen modules' center
 pushMatrix();
 float r = offset.mag(); //sqrt(x*x+y*y+z*z); // radial distance
 float theta = atan2(offset.y,offset.x); // zenith angle, range -pi..pi
 float phi = acos(offset.z/r); // azimuth angle, range -pi/2..pi/2
 translate(middlePoint.x,middlePoint.y,middlePoint.z);            
 rotateZ(theta); // "heading" or "around"
 rotateY(phi);  // "tilt" or "elevation"
 rotateY(PI/2);
 if (phi > 1 && phi < 2) {
 rotateX(PI/2); // dirty hack, but it works!
 }
 drawConnector();
 popMatrix();
 }
 }
 }
 }
 }
 
 boolean checkIfAdjacent(Module moduleA, Module moduleB) {
 if (round(PVector.dist(moduleA.modulePos,moduleB.modulePos)) == 2) {
 return true;
 } 
 else {
 return false;
 }
 }
 
 void drawConnector() {
 beginShape();
 vertex(-connectorLenght/2,0);
 vertex(0,connectorWidth/2);
 vertex(connectorLenght/2,0);
 vertex(0,-connectorWidth/2);
 endShape(CLOSE);
 }
 
 void drawModulesInfo() {
 for (int i=0;i<moduleList.size();i++) {
 Module currentModule = (Module) moduleList.get(i);
 fill(255,0,0,100);
 pushMatrix();
 
 //  translate(currentModule.flatX,currentModule.flatY);
 scale(2);
 textAlign(CENTER);
 //   textFont(font);
 
 //  text(nf(currentModule.worldX,2,2)+","+nf(currentModule.worldY,2,2)+","+nf(currentModule.worldZ,2,2),currentModule.flatX,currentModule.flatY);
 text(currentModule.moduleX+","+currentModule.moduleY+","+currentModule.moduleZ,currentModule.flatX,currentModule.flatY); 
 
 text(i,0,4);
 textAlign(LEFT);
 popMatrix();
 }
 }
 
 void drawModules() { 
 for (int i=0;i<moduleList.size();i++) {
 pushMatrix();
 Module currentModule = (Module) moduleList.get(i);
 currentModule.display();
 popMatrix();
 }
 }
 */


