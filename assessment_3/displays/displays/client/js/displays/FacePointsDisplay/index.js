import GenericDisplay from '../GenericDisplay';

class FacePointsDisplay extends GenericDisplay {
  type = 'face-points';
  constructor() {
    super();
    console.log('face points display');
    const facePoints = document.getElementById(this.type);
    facePoints.classList.add('Display__Active');
  }

  reset(...args) {
    console.log(args);
  }
}

export default FacePointsDisplay;
