class FakeIdDisplayer {
  constructor(parent) {
    this.parent = parent;
    const el = document.createElement('div');
    el.classList.add('FakeId');
    this.parent.append(el);
    this.element = el;
  }

  drawId(fakeId, duration) {
    
  }

  clear() {
    
  }
}

export default FakeIdDisplayer;