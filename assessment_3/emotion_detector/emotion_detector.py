from keras.models import load_model
import numpy as np

class EmotionDetector:
    def __init__(self, modelpath="emotion_model.hdf5"):
        self.emotion_classifier = load_model(modelpath, compile=False)
        self.emotions = ["angry", "disgust", "scared", "happy", "sad", "suprised", "neutral"]
    
    def handleNewRoi(self, roi):
        print("EmotionDetector::handleNewRoi()")
        predictions = self.emotion_classifier.predict(roi)[0]
        emotional_probability = np.max(predictions)
        label = self.emotions[predictions.argmax()]
        print("Chosen emotion: {}".format(label))

        for (i, (emotion, probability)) in enumerate(zip(self.emotions, emotional_probability)):
            print("\temotion: {0}, emotional_probability: {1}".format(emotion, probability))
        
        return label, predictions.argmax()