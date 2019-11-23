
/**
 * @param {Array<String>} stringArray
 * @returns {Number} Total length of every string in array
 */
export const getStringArrayTotalLength = (stringArray) => stringArray.reduce((acc = 0, cur) => acc + cur.length, 0);


/**
 *
 * @param {Array<String>} stringArray - String array to calc char speed for
 * @param {Number} duration - Duration of animation in seconds
 * @returns
 */
export const getLinePauseOfStringArray = (stringArray, duration) =>  Math.floor((duration * 1000) / stringArray.length);

export /**
 * Shuffle Array using Fisher-Yates
 * Sourced from https://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
 * @param {Array} array
 * @returns {Array}
 */
const shuffle = (array) => {
  for (var i = array.length - 1; i > 0; i--) {
    var j = Math.floor(Math.random() * (i + 1));
    var temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  return array;
};

export default {
  getStringArrayTotalLength,
  getLinePauseOfStringArray
};