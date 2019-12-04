import Delaunay from './Delauney';

class FaceVisual {
  features = [];
  triangles = [];
  p5;
  delauney;

  x;
  y;
  width;
  height;
  
  pointColor;
  lineColor;
  scanColor;
  
  pointState;
  tesselateState;

  constructor(p5, x, y, width, height) {
    this.p5 = p5;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;

    const stateManager = window.stateManager;
    this.pointState = stateManager.findState('INITIAL_POINTS');
    this.tesselateState = stateManager.findState('TESSELATION');
    this.scanState = stateManager.findState('SCAN');
  }

  draw() {
    const isScanState = this.scanState.started && !this.scanState.ended;
    let scanIndex = Number.NEGATIVE_INFINITY;
    if (isScanState) {
      scanIndex = 10 + Math.floor(Math.random() * 10);
    }

    this.p5.noFill();
    this.p5.stroke(this.lineColor);
    for (let i = 0; i < this.triangles.length; i += 3) {
      if (i % scanIndex == 0) {
        this.p5.fill(this.scanColor);
      }
      this.p5.beginShape();
      this.p5.vertex(this.features[this.triangles[i]][0], this.features[this.triangles[i]][1]);
      this.p5.vertex(this.features[this.triangles[i+1]][0], this.features[this.triangles[i+1]][1]);
      this.p5.vertex(this.features[this.triangles[i+2]][0], this.features[this.triangles[i+2]][1]);
      this.p5.endShape(this.p5.CLOSE);
      if (i % scanIndex == 0) {
        this.p5.noFill();
      }
    }

    const pointsProgress = this.pointState.progress;
    // Face points
    this.p5.noStroke();
    this.p5.fill(this.pointColor);
    var vertexIndex = 0;
    var pointsLimit = Math.floor(pointsProgress * this.features.length);
    for (var i = 0; i < this.features.length; i++) {
      let thisVec = this.features[i];
      if (vertexIndex < pointsLimit) {
        this.p5.ellipse(thisVec[0], thisVec[1], 7, 7);
      }
      vertexIndex++;
    }
  }

  setPointColor(color) {
    this.pointColor = color;
  }

  setLineColor(color) {
    this.lineColor = color;
  }

  setScanColor(color) {
    this.scanColor = color;
  }
  
  reset(features) {
    let formattedFeatures = this.mapFeaturesToRect(features, this.x, this.y, this.width, this.height);
    formattedFeatures = [].concat(...formattedFeatures);
    this.features = formattedFeatures;
    const nFeatures = formattedFeatures.length;
    
    this.tesselateState.clearCallbacks().addCallback(state => {

      formattedFeatures.forEach((el, i) => {
        const {timeout} = state.getInterval(i, nFeatures);
        setTimeout(() => {
          this.triangles = Delaunay.triangulate(this.features.slice(0, i));
        }, timeout * 1000);
      });

    });
  
  }

  mapFeaturesToRect(vects, x, y, width, height) {
    var minY = 10000,
      maxY = 0,
      minX = 10000,
      maxX = 0;
    for (let i = 0; i < vects.length; i++) {
      for (let j = 0; j < vects[i].length; j++) {
        var currentVal = vects[i][j];
        minY = this.p5.constrain(currentVal[1], 0.0, minY);
        maxY = this.p5.constrain(currentVal[1], maxY, 10000);
        minX = this.p5.constrain(currentVal[0], 0.0, minX);
        maxX = this.p5.constrain(currentVal[0], maxX, 10000);
      }
    }
    
    let newX, newY;
    // map face
    for (var i = 0; i < vects.length; i++) {
      for (var j = 0; j < vects[i].length; j++) {
        let currentVal = vects[i][j];
        newX = this.p5.map(currentVal[0], minX, maxX, x, x + width);
        newY = this.p5.map(currentVal[1], minY, maxY, y, y + height);
        vects[i][j] = [newX, newY];
      }
    }
        
    return vects;
  }
}

export default FaceVisual;