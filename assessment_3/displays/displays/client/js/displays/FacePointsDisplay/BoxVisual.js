class BoxVisual {
  points = [];
  width;
  height;
  sideLength = 1;

  constructor(p5, x, y, width, height) {
    this.p5 = p5;
    this.points.push(p5.createVector(x, y));
    this.points.push(p5.createVector(x+width, y));
    this.points.push(p5.createVector(x+width, y + height));
    this.points.push(p5.createVector(x, y+height));
    this.width = width;
    this.height = height;
  }

  setGap(gapRatio) {
    this.sideLength = (1 - gapRatio) / 2;
  }

  draw() {
    this.p5.stroke(255);
    this.p5.strokeWeight(1);
    const p = this.points;
    this.p5.line(p[0].x, p[0].y, p[0].x + this.width * this.sideLength, p[0].y);
    this.p5.line(p[1].x, p[1].y, p[1].x - this.width * this.sideLength, p[1].y);
    
    // Right
    this.p5.line(p[1].x, p[1].y, p[1].x, p[1].y + this.height * this.sideLength);
    this.p5.line(p[2].x, p[2].y, p[2].x, p[2].y - this.height * this.sideLength);

    // Botom
    this.p5.line(p[2].x, p[2].y, p[2].x - this.width * this.sideLength, p[2].y);
    this.p5.line(p[3].x, p[3].y, p[3].x + this.width * this.sideLength, p[3].y);

    // Left
    this.p5.line(p[0].x, p[0].y, p[0].x, p[0].y + this.height * this.sideLength);
    this.p5.line(p[3].x, p[3].y, p[3].x, p[3].y - this.height * this.sideLength);

  }
}

export default BoxVisual;