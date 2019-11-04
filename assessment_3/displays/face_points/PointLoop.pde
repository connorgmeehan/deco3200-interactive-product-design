//class PointLoop {

//  PVector currentVal;
//  PVector nextVert;
//  int x, y;
//  color c;
//  int totalIndex;
//  PVector[][] facePoints;


//  PointLoop(PVector[][] _facePoints, int _x, int _y, color _c) {
    
//    facePoints = _facePoints;
//    x = _x;
//    y = _y;
//    c = _c;
    
    
    
    
//  }


//  void draw() {
//    totalIndex = 0;
//    fill(255);
    
//    for (int i = 0; i < facePoints.length-1; i++) {
//      for (int j = 0; j < facePoints[i].length-1; j+=1) {
//        currentVal = features[i][j];
//        nextVert = features[i][j+1];
//        totalIndex++;
//        if (totalIndex == vertToDrawIndex) {
//          text(string, 
//        text("[ ", 808, textY);
//        text("]", 900, textY);
//        text(",", 853, textY);
//        fill(#0029F3);
//        text(round(currentVal.x) + "  " + round(currentVal.y), 824, textY);
//        //println(currentVal);
//    } 
        
        
        
//      }
//    }
//  }
  
  
//  void textValues() {
    
    
    
//  }
  
  
  




//}

//for (int i = 0; i < features.length-1; i++) {
//  for (int j = 0; j < features[i].length-1; j+=1) {

    


//    noStroke();
//    noFill();

//    // loop text point values
//    if (totalIndex == vertToDrawIndex) {
//      fill(255);
//      text("[ ", 808, textY);
//      text("]", 900, textY);
//      text(",", 853, textY);
//      fill(#0029F3);
//      text(round(currentVal.x) + "  " + round(currentVal.y), 824, textY);
//      //println(currentVal);
//    } 

//    // draw points and lines
//    if (totalIndex < vertToDrawIndex) {
//      fill(255);
//      ellipse(currentVal.x, currentVal.y, 7, 7);
//      stroke(255);
//      line(currentVal.x, currentVal.y, nextVert.x, nextVert.y);


//      if (j == features[i].length-2) {
//        ellipse(nextVert.x, nextVert.y, 7, 7);
//        if ( i == 4 || i == 9 || i == 10 || i == 5) {
//          line(nextVert.x, nextVert.y, features[i][0].x, features[i][0].y);
//        }
//      }
//    }



//    // blue glow
//    blendMode(DARKEST);
//    fill(#0029F3);
//    noStroke();
//    rect(blendRectX+1, blendRectY+1, boundingWidth-3, boundingHeight/10);
//    blendRectY = blendRectY + 0.2;
//    blendMode(NORMAL);

//    // reset blue glow
//    if (blendRectY >= 483) {
//      blendRectY = 150;
//    }
//  }
//}
