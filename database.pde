String dbName = "cloud";
String fileName;
String extension = "txt";

String lastAccess = null;

void writeModuleDefinition() {
  if (module.authorEmail == null || module.authorEmail.equals("")) {
    printMessage("Please enter personal data to submit module");
  } 
  else {
    fileName = module.authorEmail;
    String data = module.getDefinition();
    // println(data);
    String url = "http://dhubfablab.cat/ccloud/cloud.php?type=save&filename="+fileName+"&extension="+extension+"&data="+data;
    //  if (true) {
    writeDone(loadStrings(url));
    //  } 
    //  else {
    //   Thread t = new Thread(new AsyncLoadStrings(this, url, "writeDone"));
    //    t.start();
    // }
  }
}

void readModuleDefinition() {
  if (module.authorEmail == null || module.authorEmail.equals("")) {
    printMessage("Please enter personal data to load module");
  }  
  else {
    fileName = module.authorEmail;
    String url = "http://dhubfablab.cat/ccloud/cloud.php?type=load&filename="+fileName+"&extension="+extension+"&";
    //if (true) {
    readDone(loadStrings(url));
    // } 
    //  else {
    //  Thread s = new Thread(new AsyncLoadStrings(this, url, "readDone"));
    //   s.start();
    //   }
  }
}

void readDone(String[] messages) {
  println("readDone");
  if (messages != null) {
    if (messages[1].contains("Warning")) {
      printMessage("Error: Module "+fileName+" not found");
    } 
    else {
      initCamera();
      println(messages);
      module.setDefinition(messages[0]);
      printMessage("Module "+fileName+" loaded");
    }
  } 
  else {
    printMessage("Error: Can not access database.");
  }
}

void writeDone(String[] messages) {
  if (messages != null) {
    //   println(messages);
    printMessage("Module "+fileName+" uploaded");
  } 
  else {
    printMessage("Error: Can not access database.");
  }
}


