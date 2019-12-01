class FaceVisual {
  features = [];
  x;
  y;
  width;
  height;
  stateManager;
  constructor(p5, x, y, width, height) {
    this.p5 = p5;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.stateManager = window.stateManager;
  }

  draw() {
    const lineProgress = this.stateManager.findState('FACE_LINES').progress;
    this.p5.stroke(200);
    this.p5.noFill();
    let lineIndex = 0;
    const lineLimit = Math.floor(lineProgress * this.featuresTotalCount);
    for (var i = 0; i < this.features.length; i++) {
      for (var j = 0; j < this.features[i].length - 1; j++) {
        if (lineIndex < lineLimit) {
          var thisVec = this.features[i][j];
          var nextVec = this.features[i][j + 1];
          this.p5.line(thisVec.x, thisVec.y, nextVec.x, nextVec.y);
        }
        lineIndex++;
      }
    }

    const pointsProgress = this.stateManager.findState('FACE_POINTS').progress;
    // Face points
    this.p5.noStroke();
    this.p5.fill(255);
    var vertexIndex = 0;
    var pointsLimit = Math.floor(pointsProgress * this.featuresTotalCount);
    for (var i = 0; i < this.features.length; i++) {
      for (var j = 0; j < this.features[i].length; j++) {
        let thisVec = this.features[i][j];
        if (vertexIndex < pointsLimit) {
          this.p5.ellipse(thisVec.x, thisVec.y, 7, 7);
        }
        vertexIndex++;
      }
    }
  }

  reset(features) {
    this.features = this.mapFeaturesToRect(features, this.x, this.y, this.width, this.height);
    this.featuresTotalCount = this.getFeatureCount(features);
  }

  getFeatureCount(features) {
    var count = 0;
    for (let i = 0; i < features.length; i++) {
      count += features[i].length;
    }
    return count;
  }
    
  mapFeaturesToRect(vects, x, y, width, height) {
    var minY = 10000,
      maxY = 0,
      minX = 10000,
      maxX = 0;
    for (let i = 0; i < vects.length; i++) {
      for (let j = 0; j < vects[i].length; j++) {
        var currentVal = vects[i][j];
        minY = this.p5.constrain(currentVal.y, 0.0, minY);
        maxY = this.p5.constrain(currentVal.y, maxY, 10000);
        minX = this.p5.constrain(currentVal.x, 0.0, minX);
        maxX = this.p5.constrain(currentVal.x, maxX, 10000);
      }
    }
    
    let newX, newY;
    // map face
    for (var i = 0; i < vects.length; i++) {
      for (var j = 0; j < vects[i].length; j++) {
        let currentVal = vects[i][j];
        newX = this.p5.map(currentVal.x, minX, maxX, x, x + width);
        newY = this.p5.map(currentVal.y, minY, maxY, y, y + height);
        vects[i][j] = this.p5.createVector(newX, newY);
      }
    }
        
    return vects;
  }
}

export default FaceVisual;