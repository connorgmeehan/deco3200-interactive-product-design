import LineWriter from '../../helpers/Linewriter';

const startMainFaceText = (duration, mainFaceString) => {
  const lineWriter = new LineWriter('.AsciiDisplay_MainFace', {duration});
  mainFaceString.forEach(line => {
    lineWriter.line(line);
  });
  lineWriter.start();
};

export default startMainFaceText;