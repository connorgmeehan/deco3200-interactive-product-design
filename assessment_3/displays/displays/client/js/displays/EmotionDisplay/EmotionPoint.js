class EmotionPoint {
  static lineLength = 5;
  static gapLength = 5;
  
  p5;
  font;
  
  x;
  y;
  radius;
  color;
  id;
  drawString;

  constructor(p5, x, y, radius, color) {
    console.log(`EmotionPoint.constructor(x: ${x}, y: ${y}, radius: ${radius}, color: ${color})`);
    this.p5 = p5;
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.color = color;
  }

  draw() {
    if (!this.p5 && this.font) {
      return;
    }
    this.p5.push();
    this.p5.noFill();
    this.p5.drawingContext.setLineDash([5, 12]);
    this.p5.strokeWeight(4);
    this.p5.stroke(this.color);
    this.p5.ellipse(this.x, this.y, this.radius, this.radius);
    this.p5.pop();

    this.p5.textAlign(this.p5.CENTER);
    this.p5.textSize(15);
    this.p5.noStroke();
    this.p5.fill(255, 0, 0);
    this.p5.textFont(this.font);
    this.p5.text(this.drawString, this.x, this.textY);
  }

  setFont(font) {
    this.font = font;
  }

  setText(id, drawTextBelow = true) {
    this.drawString = `P${id}`;
    this.textY = drawTextBelow
      ? this.y - this.radius
      : this.y + this.radius;
  }
  static setLineDash(lineLength = 5, gapLength = 5) {
    this.lineLength = lineLength;
    this.gapLength = gapLength;
  }
}

export default EmotionPoint;