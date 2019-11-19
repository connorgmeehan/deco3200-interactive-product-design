const sketch = (p5) => {
    
  const canvasWidth = p5.windowWidth;
  const canvasHeight = p5.windowHeight;
    
  window.p5 = p5; 
    
  let features;
  let featuresTotalCount;
  let boxX;
  let boxY;
  let boxW;
  let boxH;
  let v1, v2, v3, v4;
  let sideLength;
  const BLUE = "#0029F3";
    
  p5.setup = () => {
    p5.createCanvas(canvasWidth, canvasHeight);
        
    features = [
      [
        p5.createVector(172.973, 216.573),
        p5.createVector(180.438, 212.994),
        p5.createVector(189.012, 213.277),
        p5.createVector(196.711, 216.161),
      ],
      [
        p5.createVector(247.247, 217.378),
        p5.createVector(255.447, 214.366),
        p5.createVector(264.464, 215.362),
        p5.createVector(272.456, 219.341),
      ],
      [
        p5.createVector(160.456, 190.877),
        p5.createVector(169.024, 183.201),
        p5.createVector(179.743, 180.384),
        p5.createVector(190.659, 180.993),
        p5.createVector(200.803, 184.091),
      ],
      [
        p5.createVector(239.469, 184.125),
        p5.createVector(254.244, 181.191),
        p5.createVector(269.342, 181.642),
        p5.createVector(283.515, 187.349),
        p5.createVector(294.273, 198.521),
      ],
      [
        p5.createVector(172.973, 216.573),
        p5.createVector(180.438, 212.994),
        p5.createVector(189.012, 213.277),
        p5.createVector(196.711, 216.161),
        p5.createVector(188.864, 218.61),
        p5.createVector(180.586, 218.921),
      ],
      [
        p5.createVector(247.247, 217.378),
        p5.createVector(255.447, 214.366),
        p5.createVector(264.464, 215.362),
        p5.createVector(272.456, 219.341),
        p5.createVector(264.092, 221.01),
        p5.createVector(255.299, 220.306),
      ],
      // [
      //  p5.createVector(148.722, 226.08), 
      //  p5.createVector(145.94, 247.269), 
      //  p5.createVector(144.959, 268.674), 
      //  p5.createVector(145.226, 289.062), 
      //  p5.createVector(148.168, 308.349), 
      //  p5.createVector(156.501, 325.313), 
      //  p5.createVector(171.138, 338.341), 
      //  p5.createVector(189.429, 347.332), 
      //  p5.createVector(209.997, 350.262), 
      // ], 
      // [
      //  p5.createVector(209.997, 350.262), 
      //  p5.createVector(235.006, 351.803), 
      //  p5.createVector(259.716, 348.29), 
      //  p5.createVector(282.818, 340.176), 
      //  p5.createVector(300.841, 325.679), 
      //  p5.createVector(310.976, 305.173), 
      //  p5.createVector(316.669, 281.271), 
      //  p5.createVector(319.88, 255.894), 
      //  p5.createVector(322.124, 230.515), 
      // ], 
      [
        p5.createVector(148.722, 226.08),
        p5.createVector(145.94, 247.269),
        p5.createVector(144.959, 268.674),
        p5.createVector(145.226, 289.062),
        p5.createVector(148.168, 308.349),
        p5.createVector(156.501, 325.313),
        p5.createVector(171.138, 338.341),
        p5.createVector(189.429, 347.332),
        p5.createVector(209.997, 350.262),
        p5.createVector(235.006, 351.803),
        p5.createVector(259.716, 348.29),
        p5.createVector(282.818, 340.176),
        p5.createVector(300.841, 325.679),
        p5.createVector(310.976, 305.173),
        p5.createVector(316.669, 281.271),
        p5.createVector(319.88, 255.894),
        p5.createVector(322.124, 230.515),
      ],
      [
        p5.createVector(185.785, 294.669),
        p5.createVector(193.352, 286.588),
        p5.createVector(202.278, 280.625),
        p5.createVector(212.08, 281.312),
        p5.createVector(224.065, 281.449),
        p5.createVector(234.939, 288.39),
        p5.createVector(245.342, 296.589),
        p5.createVector(234.619, 300.676),
        p5.createVector(222.964, 302.043),
        p5.createVector(211.362, 301.549),
        p5.createVector(201.865, 301.498),
        p5.createVector(192.905, 299.556),
      ],
      [
        p5.createVector(185.785, 294.669),
        p5.createVector(201.857, 290.901),
        p5.createVector(211.8, 290.136),
        p5.createVector(224.331, 291.473),
        p5.createVector(245.342, 296.589),
        p5.createVector(224.181, 292.023),
        p5.createVector(211.744, 290.61),
        p5.createVector(201.855, 291.354),
      ],
      [
        p5.createVector(216.372, 208.94),
        p5.createVector(214.538, 219.339),
        p5.createVector(212.642, 229.554),
        p5.createVector(210.739, 239.685),
      ],
      [
        p5.createVector(200.68, 258.08),
        p5.createVector(206.032, 259.167),
        p5.createVector(211.576, 259.429),
        p5.createVector(219.248, 259.587),
        p5.createVector(226.865, 258.964),
      ],
      [
        p5.createVector(160.456, 190.877),
        p5.createVector(169.024, 183.201),
        p5.createVector(179.743, 180.384),
        p5.createVector(190.659, 180.993),
        p5.createVector(200.803, 184.091),
        p5.createVector(239.469, 184.125),
        p5.createVector(254.244, 181.191),
        p5.createVector(269.342, 181.642),
        p5.createVector(283.515, 187.349),
        p5.createVector(294.273, 198.521),
        p5.createVector(322.124, 230.515),
        p5.createVector(319.88, 255.894),
        p5.createVector(316.669, 281.271),
        p5.createVector(310.976, 305.173),
        p5.createVector(300.841, 325.679),
        p5.createVector(282.818, 340.176),
        p5.createVector(259.716, 348.29),
        p5.createVector(235.006, 351.803),
        p5.createVector(209.997, 350.262),
        p5.createVector(189.429, 347.332),
        p5.createVector(171.138, 338.341),
        p5.createVector(156.501, 325.313),
        p5.createVector(148.168, 308.349),
        p5.createVector(145.226, 289.062),
        p5.createVector(144.959, 268.674),
        p5.createVector(145.94, 247.269),
        p5.createVector(148.722, 226.08),
      ],
    ];
        
    features = mapVectorsToRect(features, 170, 120, 500, 500);
    featuresTotalCount = getVectorCount(features);
    boxX = 50;
    boxY = 50;
    boxW = 700;
    boxH = 700;
    v1 = p5.createVector(boxX, boxY);
    v2 = p5.createVector(boxX + boxW, boxY);
    v3 = p5.createVector(boxX + boxW, boxY + boxH);
    v4 = p5.createVector(boxX, boxY + boxH);
    sideLength = (1.0 - (1.0 * 0.5))/2.0;
        
  };
    
  p5.draw = () => {
    p5.background(0);
        
    // Box visual
    p5.stroke(255);
    // Top
    p5.line(v1.x, v1.y, v1.x + canvasWidth * sideLength, v1.y);
    p5.line(v2.x, v2.y, v2.x - canvasWidth * sideLength, v2.y);
    // Right
    p5.line(v2.x, v2.y, v2.x, v2.y + canvasHeight * sideLength);
    p5.line(v3.x, v3.y, v3.x, v3.y - canvasHeight * sideLength);
    // Bottom
    p5.line(v3.x, v3.y, v3.x - canvasWidth * sideLength, v3.y );
    p5.line(v4.x, v4.y, v4.x + canvasWidth * sideLength, v4.y );
    // Left
    p5.line(v1.x, v1.y, v1.x, v1.y + canvasHeight * sideLength);
    p5.line(v4.x, v4.y, v4.x, v4.y - canvasHeight * sideLength);
        
    // Face lines
    p5.stroke(200);
    p5.noFill();
    var lineIndex = 0;
    for (var i = 0; i < features.length; i++) {
      for (var j = 0; j < features[i].length - 1; j++) {
        if (lineIndex < featuresTotalCount) {
          var thisVec = features[i][j];
          var nextVec = features[i][j + 1];
          p5.line(thisVec.x, thisVec.y, nextVec.x, nextVec.y);
        }
        lineIndex++;
      }
    }
        
    // Face points
    p5.noStroke();
    p5.fill(255);
    var vertexIndex = 0;
    var drawingPointsIndex = featuresTotalCount;
    let curVector = new p5.createVector(0, 0);
    for (var i = 0; i < features.length; i++) {
      for (var j = 0; j < features[i].length; j++) {
        let thisVec = features[i][j];
        if (vertexIndex < drawingPointsIndex) {
          p5.ellipse(thisVec.x, thisVec.y, 7, 7);
        }
                
        if (vertexIndex == drawingPointsIndex) {
          curVector = thisVec;
        }
        vertexIndex++;
      }
    }
        
        
    // Scan blue
    p5.blendMode(p5.MULTIPLY);
    p5.fill(BLUE);
    p5.rect(50, 200, 800, 100);
    p5.blendMode(p5.BLEND);
  };
    
  function getVectorCount(vects) {
    var count = 0;
    for (let i = 0; i < vects.length; i++) {
      count += vects[i].length;
    }
    return count;
  }
    
  function mapVectorsToRect(vects, x, y, width, height) {
    var minY = width,
      maxY = 0,
      minX = height,
      maxX = 0;
    for (let i = 0; i < vects.length; i++) {
      for (let j = 0; j < vects[i].length; j++) {
        var currentVal = vects[i][j];
        minY = p5.constrain(currentVal.y, 0.0, minY);
        maxY = p5.constrain(currentVal.y, maxY, height);
        minX = p5.constrain(currentVal.x, 0.0, minX);
        maxX = p5.constrain(currentVal.x, maxX, width);
      }
    }
    
    let newX, newY;
    // map face
    for (var i = 0; i < vects.length; i++) {
      for (var j = 0; j < vects[i].length; j++) {
        let currentVal = vects[i][j];
        newX = p5.map(currentVal.x, minX, maxX, x, x + width);
        newY = p5.map(currentVal.y, minY, maxY, y, y + height);
        vects[i][j] = p5.createVector(newX, newY);
      }
    }
        
    return vects;
  }
};

export default sketch;