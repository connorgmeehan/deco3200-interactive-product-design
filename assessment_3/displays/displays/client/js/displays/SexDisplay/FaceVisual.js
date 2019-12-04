import Delaunay from './Delauney';

class FaceVisual {
  features = [];
  p5;
  delauney;
  x;
  y;
  width;
  height;
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
  }

  draw() {
    
    const pointsProgress = this.pointState.progress;
    // Face points
    this.p5.noStroke();
    this.p5.fill(255);
    var vertexIndex = 0;
    var pointsLimit = Math.floor(pointsProgress * this.featuresTotalCount);
    for (var i = 0; i < this.features.length; i++) {
      for (var j = 0; j < this.features[i].length; j++) {
        let thisVec = this.features[i][j];
        if (vertexIndex < pointsLimit) {
          this.p5.ellipse(thisVec[0], thisVec[1], 7, 7);
        }
        vertexIndex++;
      }
    }

    const tessProgress = this.tesselateState.progress;

    for (let i = 0; i < this.triangles.length; i += 3) {
      this.p5.beginShape();
      this.p5.fill(255-(i / this.triangles.length)*255, 0, 128);
      this.p5.vertex(this.features[this.triangles[i]][0], this.features[this.triangles[i]][1]);
      this.p5.vertex(this.features[this.triangles[i+1]][0], this.features[this.triangles[i+1]][1]);
      this.p5.vertex(this.features[this.triangles[i+2]][0], this.features[this.triangles[i+2]][1]);
      this.p5.endShape(this.p5.CLOSE);
    }
  }
  
  reset(features) {
    const mappedFeatures = this.mapFeaturesToRect(features, this.x, this.y, this.width, this.height);
    this.features = [].concat(...mappedFeatures);
    this.triangles = Delaunay.triangulate(this.features);
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