import { segmentStringArray } from "../../helpers/utils";
import LineWriter from "../../helpers/Linewriter";

class FaceSegmentDisplay {
  container; // Stores container element of all face segments
  element; // Stores HTML element of component
  timeout; // Stores timout from startDrawAfter
  faceStrings; // Stores array of strings of segment to draw
  /**
   *Creates an instance of FaceSegmentDisplay.
   * @param {HTMLElement} container
   * @param {String<Array>} faceStrings
   * @param {Number} id
   * @param {Number} width
   * @param {Number} height
   * @memberof FaceSegmentDisplay
   */
  constructor(container, faceStrings, id, width, height) {
    if (!faceStrings || faceStrings.length == 0) {
      throw ('Error: Did not pass in face strings');
    }
    this.container = container;
    this.element = document.createElement('div');
    this.element.classList.add('EmotionDisplay_FaceSegment');
    this.container.appendChild(this.element);

    const ratioWidth = width / faceStrings[0].length;
    const ratioHeight = height / faceStrings.length;
    const leftOffset = Math.random() * (1.0 - ratioWidth);
    const topOffset = Math.random() * (1.0 - ratioHeight);

    console.debug(`FaceSegmentDisplay.constructor() ->
      ratioWidth: ${ratioWidth},
      ratioHeight ${ratioHeight},
      leftOffset: ${leftOffset},
      topOffset: ${topOffset}`);

    this.id = id;
    this.faceStrings = segmentStringArray(faceStrings, leftOffset, topOffset, leftOffset + ratioWidth, topOffset + ratioHeight);
    console.log(`Segmented string array -> ${this.faceStrings}`);
  }

  startDraw(duration) {
    console.log(`FaceSegmentDisplay.startDraw(duration: ${duration}), id: ${this.id}`);
    this.element.classList.add('EmotionDisplay_FaceSegment__Active');
    
    this.lineWriter = new LineWriter(this.element, {duration}, this.faceStrings);
    this.lineWriter.start(); 
  }

  startDrawAfter(duration, delay) {
    this.timeout = setTimeout(() => {
      this.startDraw(duration);
    }, delay * 1000);
  }

  kill() {
    this.lineWriter.kill();
    this.element.innerHTML = '';
    clearTimeout(this.timeout);
  }
}

export default FaceSegmentDisplay;