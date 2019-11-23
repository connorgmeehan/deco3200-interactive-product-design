/**
 * @typedef LineWriterOptions
 * @property {Number} duration - Duration of total animation in seconds, takes precence over speed
 * @property {Number} speed - Duration of delay between each line in microseconds
 */

class LineWriter {
  speed = 50;
  timeouts = [];
  /**
   *Creates an instance of LineWriter.
   * @param {String|HTMLElement} selector - HTML element or string selector of element
   * @param {LineWriterOptions} options 
   * @param {Array<String>} [html=[]] - Array of html to linewrite
   * @memberof LineWriter
   */
  constructor(selector, options, html = []) {
    this.element = typeof(selector) == typeof('')
      ? document.querySelector(selector)
      : selector;

    if (!this.element) {
      throw ('LineWriter selector did not find matching html element');
    }
    const {duration, speed} = options;
    this.duration = duration * 1000;
    this.speed = speed;
    this.html = html;
  }

  line(htmlLine) {
    this.html.push(htmlLine);
  }

  start() {
    this.kill();

    const interval = this.duration != false
      ? this.duration / this.html.length
      : this.speed;

    this.html.forEach((htmlLine, i) => {
      this.timeouts.push(
        setTimeout(() => {
          const newElement = document.createElement('div');
          newElement.innerHTML = htmlLine;
          this.element.appendChild(newElement);
        }, i * interval)
      );
    });
  }

  kill() {
    this.timeouts.forEach(timeout => clearTimeout(timeout));
    this.timeouts = [];
  }
}

export default LineWriter;