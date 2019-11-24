
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

/**
 * Splits string into chunks of len's length
 * @param {String} str
 * @param {Number} len
 * @returns {Array<String}
 */
export const splitSubstring = (str, len) => {
  var ret = [ ];
  for (var offset = 0, strLen = str.length; offset < strLen; offset += len) {
    ret.push(str.substring(offset, offset + len));
  }
  return ret;
};

export const escapeHtml = (unsafe) => {
  return unsafe
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
};

/**
 * Cuts out a square segment of a string array
 *
 * @param {Array<String>} stringArray
 * @param {Number} left - Distance from left ranging from [0,1]
 * @param {Number} top - Distance from top ranging from [0,1]
 * @param {Number} right - Distance from right ranging from [0,1]
 * @param {Number} bottom - Distance from bottom ranging from [0,1]
 */
export const segmentStringArray = (stringArray, left, top, right, bottom) => {
  console.debug(left, top, right, bottom);
  if ([left, top, right, bottom].find(val => val < 0 || val > 1)) {
    throw ('Error: segmentStringArray - Input is less than 0 or greater than 1');
  }

  const startRow = Math.floor(stringArray.length * top);
  const endRow = Math.floor(stringArray.length * bottom);
  
  let newStringArray = stringArray.slice(startRow, endRow).map( line => {
    const startCol = Math.floor(line.length * left);
    const endCol = Math.floor(line.length * right);

    return line.slice(startCol, endCol);
  });
  return newStringArray;
};

export default {
  getStringArrayTotalLength,
  getLinePauseOfStringArray,
  splitSubstring,
  escapeHtml,
  segmentStringArray
};