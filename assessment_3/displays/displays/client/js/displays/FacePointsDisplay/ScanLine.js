class ScanLine {
  p5;
  x;
  y;
  width;
  height;
  offsetY;
  color;
  theta;
  constructor(p5, x, y, width, height, maxY) {
    this.p5 = p5;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.offsetY = maxY - height;
  }

  setColor(color) {
    this.color = color;
    return this;
  }

  setTheta(theta) {
    this.theta = theta;
    return this;
  }

  draw() {
    this.p5.blendMode(this.p5.MULTIPLY);
    this.p5.fill(this.color);
    const currentY = this.y + Math.sin(this.theta) * this.offsetY;
    this.p5.rect(this.x, currentY, this.width, this.height);
    this.p5.blendMode(this.p5.BLEND);
  }
}

export default ScanLine;