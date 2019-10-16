"""
Modified from https://raw.githubusercontent.com/ageitgey/face_recognition/master/examples/face_recognition_knn.py
Original code from Adam Geitgey | https://github.com/ageitgey

This is an example of using the k-nearest-neighbors (KNN) algorithm for face recognition.

When should I use this example?
This example is useful when you wish to recognize a large set of known people,
and make a prediction for an unknown person in a feasible computation time.

Algorithm Description:
The knn classifier is first trained on a set of labeled (known) faces and can then predict the person
in an unknown image by finding the k most similar faces (images with closet face-features under eucledian distance)
in its training set, and performing a majority vote (possibly weighted) on their label.

For example, if k=3, and the three closest face images to the given image in the training set are one image of Biden
and two images of Obama, The result would be 'Obama'.

* This implementation uses a weighted vote, such that the votes of closer-neighbors are weighted more heavily.

Usage:

1. Prepare a set of images of the known people you want to recognize. Organize the images in a single directory
   with a sub-directory for each known person.

2. Then, call the 'train' function with the appropriate parameters. Make sure to pass in the 'model_save_path' if you
   want to save the model to disk so you can re-use the model without having to re-train it.

3. Call 'predict' and pass in your trained model to recognize the people in an unknown image.

NOTE: This example requires scikit-learn to be installed! You can install it with pip:

$ pip3 install scikit-learn

"""
import os
import os.path

import cv2
import numpy as np
import platform
import pickle
from datetime import datetime, timedelta
import face_recognition
from face_recognition.face_recognition_cli import image_files_in_folder


ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

class UserRecogniser:
    def __init__(self, model_save_path="model.dat", threshhold=0.3):
        self.model_save_path = model_save_path
        self.known_face_encodings = []
        self.known_face_metadata = []
        self.number_of_faces_since_save = 0
        self.number_of_faces_save_limit = 10
        self.threshold = threshhold
    
    def train_from_folder(self, train_dir):
        print("FaceRecogniser::train_from_folder({})".format(train_dir))
        for class_dir in os.listdir(train_dir):
            if not os.path.isdir(os.path.join(train_dir, class_dir)):
                continue
            
            print("\tLearning faces for {}".format(class_dir))
            for img_path in image_files_in_folder(os.path.join(train_dir, class_dir)):
                image = face_recognition.load_image_file(img_path)
                face_bounding_boxes = face_recognition.face_locations(image)

                if not len(face_bounding_boxes) != 1:
                    self.known_face_encodings.append(face_recognition.face_encodings(image, known_face_locations=face_bounding_boxes)[0])
                    self.known_face_metadata.append([{
                        "id": class_dir,
                        "first_seen": datetime.now()
                    }])
        print("Finished learning faces")        


    def save_known_faces(self):
        with open(self.model_save_path, "wb") as face_data_file:
                face_data = [self.known_face_encodings, self.known_face_metadata]
                pickle.dump(face_data, face_data_file)
                print("Known faces saved to disk")

    def load_known_faces(self):
        try:
            with open(self.model_save_path, "rb") as face_data_file:
                self.known_face_encodings, self.known_face_metadata = pickle.load(face_data_file)
                print("Known faces loaded from disk")
        except FileNotFoundError:
            print("No previous face data found - starting from previous list")
            pass

    def register_new_face(self, face_encoding, uid):
        self.known_face_encodings.append(face_encoding)
        self.known_face_metadata.append({
            "first_seen": datetime.now(),
            "uid": uid
        })

    def lookup_known_face(self, *face_encoding):
        metadata = {None}

        if len(self.known_face_encodings) == 0:
            return metadata

        face_distances = face_recognition.face_distance(self.known_face_encodings, face_encoding)
        best_match_index = np.argmin(face_distances)
        print("\t\tbest match index is {0} with a distance of {1}".format(best_match_index, face_distances[best_match_index]))
        print("\t\tface_distances length = {}".format(len(face_distances)))
        if len(face_distances) > best_match_index and face_distances[best_match_index] < self.threshold:
            metadata = self.known_face_metadata[best_match_index]

        return metadata

    def lookup_face_from_roi(self, roi):
        print("FaceRecogniser::lookup_face_from_roi(image)")
        metadata = None

        face_locations = face_recognition.face_locations(roi)
        face_encodings = face_recognition.face_encodings(roi, face_locations)
        encoding = None

        for face_encoding in face_encodings:
            metadata = self.lookup_known_face(face_encoding)
            encoding = face_encoding

        return metadata, encoding

    def learn_faces(uid, *rois):
        for roi in rois:
            face_locations = face_recognition.face_locations(roi)
            face_encodings = face_recognition.face_encodings(roi, face_locations)
            for encoding in face_encodings:
                self.register_new_face(encoding, uid)


    def handle_face_detected(self, image, uid):
        print("FaceRecogniser::handle_face_detect(image)")
        metadata = None

        face_locations = face_recognition.face_locations(image)
        face_encodings = face_recognition.face_encodings(image, face_locations)

        for face_encoding in face_encodings:
            print("\tFace found, checking if seen before...")
            self.number_of_faces_since_save += 1
            
            metadata = self.lookup_known_face(face_encoding)
            
            if metadata is None:
                print("\t\tFace is new, saving...")
                self.register_new_face(face_encoding, uid)
        
        if(self.number_of_faces_since_save > self.number_of_faces_save_limit):
            print("\tHas seen {} faces since last save, saving...".format(self.number_of_faces_save_limit))
            self.save_known_faces()
            self.number_of_faces_since_save = 0

        if metadata is None:
            print("\tFace has not been detected before, returning None...")
            return {}
        return metadata