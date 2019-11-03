import dlib
import numpy as np
import tensorflow as tf
from keras import backend as K
from model.mobilenetv2 import AgenderNetMobileNetV2
import cv2 as cv

class DemographicDetector:
  def __init__(self):
    self.model = AgenderNetMobileNetV2()
    self.model.load_weights(
      'model/weight/mobilenetv2/model.10-3.8290-0.8965-6.9498.h5')
    print("DemographicDetector() -> __init__ complete!")

  def handleNewRoi(self, roi, width, height):
    roi = cv.resize(roi, (96, 96))
    images = np.array([roi])
    images = AgenderNetMobileNetV2.prep_image(images)
    prediction = self.model.predict(images)
    genders, ages = AgenderNetMobileNetV2.decode_prediction(prediction)
    print(genders, ages)
    if len(genders) > 0:
      return genders[0], ages[0]
    return None, None