# Core
from statistics import mode
from datetime import datetime, timedelta
# Libs
import cv2
import numpy as np
import face_recognition

class Recogniser:
  def __init__(self, threshold = 0.3):
    print("Recogniser()")
    self.threshold = threshold
    self.known_face_encodings = []
    self.known_face_metadatas = []

    self.current_uid = None
    self.current_encodings = []
    self.current_metadatas = []

  def search_from_encoding(self, encoding):
    print("Recogniser.search_from_encoding()")
    metadata = None
    # If we havn't saved any return None
    if len(self.known_face_encodings) == 0:
      return metadata
    # Find the closest match
    face_distances = face_recognition.face_distance(self.known_face_encodings, encoding)
    best_match_index = np.argmin(face_distances)
    # If it's within the array bounds and passes the threshold, return it
    if len(face_distances) > best_match_index and face_distances[best_match_index] < self.threshold:
      metadata = self.known_face_metadatas[best_match_index]
      encoding
    return metadata

  def try_find_face(self, roi):
    print("Recogniser.try_find_face()")
    metadata = None
    encoding = None
    # TODO: See if we can remove the need to look for faces as we've already done that
    face_locations = face_recognition.face_locations(roi)
    face_encodings = face_recognition.face_encodings(roi, face_locations)
    # Loops through encodings, if we get a match it stops the loop
    for face_encoding in face_encodings:
      metadata = self.search_from_encoding(face_encoding)
      encoding = face_encoding
      if metadata is not None:
        continue
    # And returns it
    return metadata, encoding

  def save_stored_encodings(self):
    self.save_encodings(self.current_uid, self.current_encodings)

  def save_encodings(self, uid, encodings):
    print("Recogniser.save_encodings()")
    # Loop through each encoding
    for encoding in encodings:
      # Save the unique id and time
      self.known_face_metadatas.append({
        "uid": uid,
        "first_seen": datetime.now(),
      })
      self.known_face_encodings.append(encoding)

  def handle_new_roi(self, uid, roi):
    print("Recogniser.handle_new_roi()")
    # If the UID is different we consider this a new user and clear our stored data
    if self.current_uid != uid:
      self.clear()
      self.current_uid = uid
    # Search to see if a match exists, if not it will return None, None
    metadata, encoding = self.try_find_face(roi)
    # Store the results
    self.current_encodings.append(encoding)
    self.current_metadatas.append(metadata)

  def ready_to_decide(self):
    length = len(self.current_metadatas)
    print("Recogniser.ready_to_decide() -> has enough rois: {0} (length: {1})".format(length >= 3, length))
    return length >= 3

  def handle_is_new_decision(self):
    print("Recogniser.handle_is_new_decision")
    results = []
    for encoding in self.current_encodings:
      results.append(self.search_from_encoding(encoding))
    print("\tresults: {}".format(results))
    return results

    
  def clear(self):
    print("Recogniser.clear")
    self.current_encodings.clear()
    self.current_metadatas.clear()
    self.current_uid = None

