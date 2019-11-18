import FacePoints from './displays/FacePointsDisplay';
import SexDisplay from './displays/SexDisplay';

document.addEventListener('DOMContentLoaded', function () {
    console.log(`loading ${window.location.pathname}`);
    switch (window.location.pathname) {
    case '/face_points.html':
        window.currentDisplay = new FacePoints();
        break;
    case '/sex.html':
        window.currentDisplay = new SexDisplay();
        break;
    default:
        break;
    }
});
