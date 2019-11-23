
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

export default {
  getStringArrayTotalLength,
  getLinePauseOfStringArray
};