import processing.pdf.*;
import java.util.Calendar;
import java.io.File;

///////////////////////
// GENERAL VARIABLES //
///////////////////////

// Want to save a pdf in the root folder ?
boolean savePDF = false;
// Cell size
int imageSize = 120;
// Page general padding
int padding = 60;
// Custom SVG color ?
boolean customColor = true;
// Custom SVG color
color iconColor = color(255, 255, 255);
// Label color 
color labelColor = color(255, 255, 255);

///////////////////////

PShape[] images;
String[] imageNames;
int posX = 0;
int posY = 0;

void setup() {
  size(1280, 800, P2D);
  background(0);

  // ------ load images ------
  // replace this location with a folder on your machine or use selectInput()
  File dir = new File(dataPath(""));

  if (savePDF) beginRecord(PDF, timestamp()+".pdf");

  if (dir.isDirectory()) {
    
    String[] contents = dir.list();
    
    images = new PShape[contents.length]; 
    
    imageNames = new String[contents.length]; 
    
    for (int i = 0 ; i < contents.length; i++) {
      
      // skip hidden files and folders starting with a dot, load .png files only
      if (contents[i].charAt(0) == '.') continue;
      
      else if (contents[i].toLowerCase().endsWith(".svg")) {
        
        File childFile = new File(dir, contents[i]); 
        
        images[i] = loadShape(childFile.getPath());
        
        if (customColor) images[i].disableStyle();
        
        imageNames[i] = childFile.getName();
        
        noStroke();
        fill(iconColor);
        shape(images[i], padding+posX, padding+posY);
        
        fill(labelColor);
        textSize(12);
        textAlign(CENTER);
        text(imageNames[i], padding+posX, padding+posY+60);
        
        if(posX <= width-(padding*2)-imageSize)
        {
          posX += imageSize;
        }
        else
        {
          posY += imageSize;
          posX = 0;
        }
      }
    }
  }
  if (savePDF) {
    savePDF = false;
    endRecord();
  }
  
}

void draw()
{
  // nothing
}

void keyReleased()
{
  
  if (key == 'p' || key == 'P') savePDF = true;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}