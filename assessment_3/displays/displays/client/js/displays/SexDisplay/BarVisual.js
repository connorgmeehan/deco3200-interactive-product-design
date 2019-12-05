class BarVisual {
  state = 'inactive';
  barSegments = 10;
  gapRatio = 0.5;
  barLength = 0.0;

  constructor(p5, x, y, width, height) {
    this.p5 = p5;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;

    this.barSegmentWidth = (width / this.barSegments) * this.gapRatio;
    this.barSegmentSpacing = (width / this.barSegments);

    this.font = this.p5.loadFont('/fonts/IBMPlexMono-SemiBold.ttf');
  }

  setSegmentColor(color) {
    this.barSegmentColor = color;
    return this;
  }

  setBarLoadingColor(color) {
    this.barLoadingColor = color;
    return this;
  }

  setBarColor(color) {
    this.barColor = color;
    return this;
  }

  draw() {
    this.p5.noStroke();
    this.p5.fill(this.barSegmentColor);
    for (let i = 0; i < this.barSegments; i++) {
      this.p5.rect(this.x + i * this.barSegmentSpacing, this.y, this.barSegmentWidth, this.height);
    }

    if (this.state == 'active') {
      this.p5.fill(this.barLoadingColor);
      this.barLength = this.p5.noise(this.curTime() * 5, this.y);
    } else {
      this.p5.fill(this.barColor);
    }
    this.p5.textAlign(this.p5.LEFT);
    this.p5.textSize(12);
    this.p5.text(Math.floor(this.barLength*100), this.x, this.y - 10);
    this.p5.rect(this.x, this.y, this.width * this.barLength, this.height);
  }

  setState(state) {
    this.state = state;
    return this;
  }

  curTime() {
    return new Date().getTime()/1000;
  }

  reset() {
    this.state = 'inactive';
  }
}

export default BarVisual;