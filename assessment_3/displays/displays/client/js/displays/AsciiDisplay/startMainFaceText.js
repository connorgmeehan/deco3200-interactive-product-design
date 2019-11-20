import typer from 'typer-js';

const startMainFaceText = (duration, mainFaceString) => {
  const faceTyper = typer('.AsciiDisplay_MainFace', { duration: duration })
    .cursor({block: true, blink: 'hard', color: '#6BFF2D'});

  mainFaceString.forEach(line => {
    console.log(line);
    faceTyper.line(line);
  });
};

export default startMainFaceText;