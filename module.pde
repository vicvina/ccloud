// shape

float legWidth = .18; //.09;
float jointWidth = .02; //.01;
float jointLength = .13; 
float planeSeparation = .04;
float holeOffsetX = .1;
float holeWidth = .05;
float holeHeight = .1;

float pdfScale = 816;
float textScale = .0003;


// control point constrains
float minh = sqrt(2)/8;
float maxh = sqrt(2)-(sqrt(2)/8);
float maxr = sqrt(2-legWidth*2)-(jointWidth*2);

// materials
int materialNum = 7;
String[] materialNames = {
  "Plywood","Green","Red","Orange","Yellow","Dark Brown","Light Brown"};

// connectors

//float connectorWidth = .15;
//float connectorLenght = .2+jointLength*2;

///////////////////////////////

void loadParameters () {
  //String[] parameters = loadStrings("param.txt");
  String[] parameters = loadStrings("http://dhubfablab.cat/ccloud/param.txt");
  if (parameters != null) {
    legWidth = Float.parseFloat(parameters[0]);
    jointWidth = Float.parseFloat(parameters[1]);
    jointLength = Float.parseFloat(parameters[2]);
    planeSeparation = Float.parseFloat(parameters[3]);
    pdfScale = Float.parseFloat(parameters[4]);
    textScale = Float.parseFloat(parameters[5]); 
    printMessage("Parameters loaded and updated");
  } 
  else {
    printMessage("Error: Parameters could not be loaded");
  }
}

class Module {
  int moduleId;
  String authorName, authorLastName, authorCountry, authorEmail;
  String date, time;
  int moduleType;

  PVector moduleCoords = new PVector(0,0,0);
  PVector modulePos = new PVector(0,0,0);
  PVector moduleScreen = new PVector(0,0,0);

  Plane[] planeList = new Plane[3];
  PVector[] pointList = new PVector[3];

  Module(int thisModuleId, int x, int y, int z) {
    moduleId = thisModuleId;
    moduleCoords.set(x,y,z);
    // modulePos = coordsToPos(moduleCoords);
    // default control points
    pointList[0] = new PVector(.2,.2);
    pointList[1] = new PVector(1-.4,legWidth/2);
    pointList[2] = new PVector(legWidth/2,1-.4);
    for (int i=0;i<3;i++) {
      planeList[i] = new Plane(this, i);
    }
    resetModule();
  }

  void resetModule() {
    authorName = "";
    authorLastName = "";
    authorCountry = "";
    authorEmail = "";
    float h = .2;
    pointList[0] = new PVector(.2,.2);
    pointList[1] = new PVector(1-.4,legWidth/2);
    pointList[2] = new PVector(legWidth/2,1-.4);
    for (int i=0;i<3;i++) {
      planeList[i].material = int(random(materialNum));
      for (int j=0;j<4;j++) {
        planeList[i].legs[j] = true;
      }
    }
  }

  void randomModule() {
    resetModule();
    float h = random(minh,maxh);
    float r1 = random(maxr);
    float r2 = random(maxr);
    float alpha1 = random(PI/2);
    float alpha2 = random(PI/2);
    pointList[0] = new PVector(cos(PI/4)*h,cos(PI/4)*h);
    pointList[1] = new PVector(1- (r2/2 * cos (alpha1)),(legWidth/2) + (r1/2 * sin (alpha1)));
    pointList[2] = new PVector((legWidth/2) + (r2/2 * cos (alpha2)), 1- (r2/2 * sin (alpha2)));
    for (int i=0;i<3;i++) {
      int legsNum = 0;
      while (legsNum == 0) {
        for (int j=0;j<4;j++) {
          if (random(10) < 5) {
            planeList[i].legs[j] = true;
          } 
          else {
            planeList[i].legs[j] = false;
          }
        }
        for (int j=0;j<4;j++) {
          if(planeList[i].legs[j]) legsNum ++;
        }
      }
    }
  }

  void update() {
    for (int i=0;i<3;i++) {
      planeList[i].calculateVertex();
    }
    setTimeStamp();
  }

  void setTimeStamp() {
    date = nf(day(),2)+"."+nf(month(),2)+"."+(year()+"").substring(2,4);
    time = nf(hour(),2)+"."+nf(minute(),2)+"."+nf(second(),2);
  }

  void display() {
    pushMatrix();
    //  translate(modulePos.x,modulePos.y,modulePos.z);
    moduleScreen.x = screenX(0,0,0);
    moduleScreen.y = screenY(0,0,0);

    pushMatrix();
    planeList[0].display(true,false,true,true);
    popMatrix();

    pushMatrix();
    rotateY(PI/2);
    planeList[1].display(true,false,true,true);
    popMatrix();

    pushMatrix();
    rotateX(PI/2);
    rotateZ(PI/2);
    planeList[2].display(true,false,true,true);
    popMatrix();

    popMatrix();
  }

  String getDefinition() {
    String definition = "";
    String separator = ",";
    definition += removeSpaces(authorName);
    if (authorName.equals(""))  definition += "_";
    definition += separator;
    definition += removeSpaces(authorLastName);
    if (authorLastName.equals(""))  definition += "_";
    definition += separator;
    definition += removeSpaces(authorEmail);
    definition += separator;
    definition += removeSpaces(authorCountry);
    if (authorCountry.equals(""))  definition += "_";
    definition += separator;
    // time stamp
    definition += date;
    definition += separator;
    definition += time;
    definition += separator;
    // coordinates
    definition += moduleCoords.x;
    definition += separator;
    definition += moduleCoords.y;
    definition += separator;
    definition += moduleCoords.z;
    definition += separator;
    // point list
    for (int i=0;i<3;i++) {
      definition += pointList[i].x;
      definition += separator;
      definition += pointList[i].y;
      definition += separator;
    }
    // material and leg number
    for (int i=0;i<3;i++) {
      definition += planeList[i].material;
      definition += separator;
      for (int j=0;j<4;j++) {
        definition += planeList[i].legs[j];
        definition += separator;
      }
    }
   // println(definition);
    return definition.substring(0,definition.length()-1);
  }

  void setDefinition(String definition) {
    String[] items = splitTokens(definition,",");
    int itemNum = 0;
    module.authorName = addSpaces(items[itemNum]);
    if (module.authorName.equals("_")) module.authorName ="";
    itemNum ++;
    module.authorLastName =  addSpaces(items[itemNum]);
    if (module.authorLastName.equals("_")) module.authorLastName ="";
    itemNum ++;
    module.authorEmail =  addSpaces(items[itemNum]);
    itemNum ++;
    module.authorCountry =  addSpaces(items[itemNum]);
    if (module.authorCountry.equals("_")) module.authorCountry ="";
    itemNum ++;
    updateForm();
    itemNum ++;
    itemNum ++;
    itemNum ++;
    itemNum ++;
    itemNum ++;
    for (int i=0;i<3;i++) {
      pointList[i].x = Float.parseFloat(items[itemNum]);
      itemNum ++;
      pointList[i].y = Float.parseFloat(items[itemNum]);
      itemNum ++;
    }
    for (int i=0;i<3;i++) {
      planeList[i].material = Integer.parseInt(items[itemNum]);
      itemNum ++;
      for (int j=0;j<4;j++) {
        planeList[i].legs[j] = Boolean.parseBoolean(items[itemNum]);
        itemNum ++;
      }
    }
  }

  String removeSpaces(String thisString) {
    String newString = "";
    for (int i=0;i<thisString.length();i++) {
      if (thisString.substring(i,i+1).equals(" ")) {
        newString += "^";
      } 
      else {
        newString += thisString.substring(i,i+1);
      }
    }
    return newString;
  }

  String addSpaces(String thisString) {
    String newString = "";
    for (int i=0;i<thisString.length();i++) {
      if (thisString.substring(i,i+1).equals("^")) {
        newString += " ";
      } 
      else {
        newString += thisString.substring(i,i+1);
      }
    }
    return newString;
  }
}








