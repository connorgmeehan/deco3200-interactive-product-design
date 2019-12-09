import { segmentStringArray } from "../../helpers/utils";
import LineWriter from "../components/Linewriter";

class FaceSegmentDisplay {
  id;
  parent;
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
  constructor(parent, faceStrings, id, width, height) {
    if (!faceStrings || faceStrings.length == 0) {
      throw ('Error: Did not pass in face strings');
    }
    this.id = id;
    this.parent = parent;
    const container = document.createElement('div');
    container.classList.add('EmotionDisplay_FaceSegment_Container');
    this.container = container;
    this.element = document.createElement('div');
    this.element.classList.add('EmotionDisplay_FaceSegment');
    this.container.appendChild(this.element);
    parent.appendChild(this.container);
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
  }

  startDraw(duration, completedCallback = null) {
    console.debug(`FaceSegmentDisplay.startDraw(duration: ${duration}), id: ${this.id}`);
    this.element.classList.add('EmotionDisplay_FaceSegment__Active');
    
    this.lineWriter = new LineWriter(this.element, {duration}, this.faceStrings);
    if (completedCallback) {
      this.lineWriter.addCompletedCallback(completedCallback);
    }
    this.lineWriter.start(); 
    const idTag = document.createElement('div');
    idTag.classList.add('EmotionDisplay_IdTag');
    idTag.innerText = `P${this.id}`;
    this.container.appendChild(idTag);
  }

  startScanAnimation(duration) {
    this.lineWriter.applyClass('u--color-green', duration, () => {
      this.lineWriter.flashClass('u--color-white');
    })
  }

  startDrawAfter(duration, delay, completedCallback = null) {
    this.timeout = setTimeout(() => {
      this.startDraw(duration, completedCallback);
    }, delay * 1000);
  }

  kill() {
    this.lineWriter && this.lineWriter.kill();
    this.element.innerHTML = '';
    clearTimeout(this.timeout);
  }
}

export default FaceSegmentDisplay;