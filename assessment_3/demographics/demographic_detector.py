import dlib

class DemographicDetector:
  def __init__(self):
    self.predictor = dlib.shape_predictor('shape_predictor_5_face_landmarks.dat')


  def handleNewRoi(self, roi):
    shapes = dlib.full_object_detection()
    shapes.append(predictor(roi))