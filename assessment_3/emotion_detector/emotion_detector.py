from keras.preprocessing.image import img_to_array
from keras.models import load_model
import numpy as np
import cv2 as cv

class EmotionDetector:
    def __init__(self, modelpath="emotion_model.hdf5"):
        self.emotion_classifier = load_model(modelpath)
        self.emotions = ["angry", "disgust", "scared", "happy", "sad", "suprised", "neutral"]
    
    def handleNewRoi(self, roi):
        print("EmotionDetector::handleNewRoi()")
        roi = cv.resize(roi, (64, 64)) # Resize to required size for model
        roi = roi.astype("float") / 255.0 # Convert to float image
        roi = img_to_array(roi) # Convert to numpy array
        roi = np.expand_dims(roi, axis=0) # Add a new dimension
        predictions = self.emotion_classifier.predict(roi)[0]
        print("Predicted on roi {}".format(predictions))
        emotional_probability = np.max(predictions)
        print("found highest probability {}".format(emotional_probability))
        label = self.emotions[predictions.argmax()]
        print("Chosen emotion: {}".format(label))

        for (i, (emotion, probability)) in enumerate(zip(self.emotions, predictions)):
            print("\temotion: {0}, predictions: {1}".format(emotion, probability))
        
        return label, predictions.argmax()