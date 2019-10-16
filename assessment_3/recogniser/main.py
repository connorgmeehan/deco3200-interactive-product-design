import os
from statistics import mode
from pythonosc import dispatcher
from pythonosc import osc_server

host = "localhost"
port = int(os.environ.get("RECOGNISER_PORT"))
print("host = {}".format(host))
print("port = {}".format(port))

import fifoutil
video_out_dir = os.environ.get('VID_OUT_DIR')

from user_recogniser import UserRecogniser
import face_recognition
import cv2
recogniser = UserRecogniser()
recogniser.load_known_faces()

session_uid = None
session_metadata_list = []
session_encodings_list = []

def extract_uid_from_metdata(metadata):
  print(metadata)
  return 0

def handle_completed_list():
  print("handle_completed_list()")
  metadata_hashmap = map(extract_uid_from_metdata, session_metadata_list)
  most_common = mode(metadata_hashmap)
  print("most_common uid: {}".format(most_common))

  if most_common == 0 or most_common == None:
    recogniser.learn_faces(session_uid, session_encodings_list)

def handle_new_face(roi, uid):
  print("handle_new_face(roi: {0}, uid: {1})".format(roi, uid))

  # Add new metadata to list
  metadata, encoding = recogniser.lookup_face_from_roi(roi)
  print(metadata)
  session_metadata_list.append(metadata)
  session_encodings_list.append(encoding)
  print("metadata_list size = {}/3".format(len(session_metadata_list)))

  if len(session_metadata_list) >= 3:
    print("metadata_list:")
    print(session_metadata_list)
    handle_completed_list()

def add_new(address, args, uid, width, height):
  global session_uid
  try:
    print("\n")
    print("OSC -> /roi/add_new (uid: {0}, width: {1}, height: {2})".format(uid, width, height))
  except ValueError: pass
  im = None
  try:
    im = fifoutil.read_array(video_out_dir) # read data as image from pipe
  except FileNotFoundError:
    print("FileNotFoundError when trying to read {}".format(video_out_dir))
    pass
  if im is not None:
    print("\tgot image, handling face detection")

    # if we're sent a new uid, you can consider it a new session/face to analyse
    if session_uid is not uid:
      clear_all()
      session_uid = uid

    im = cv2.cvtColor(im, cv2.COLOR_RGB2BGR) # cv2 uses BGR colorspace
    handle_new_face(im, uid)

def clear_all():
  session_metadata_list.clear()
  session_encodings_list.clear()
  session_uid = None
  print("clear_all")

if __name__ == "__main__":
  dispatcher = dispatcher.Dispatcher()
  dispatcher.map("/roi/add_new", add_new, "uid", "width", "height")
  dispatcher.map("/roi/clear_all", clear_all)

  server = osc_server.ThreadingOSCUDPServer(
    (host, port), dispatcher)
  
  print("Serving on {}".format(server.server_address))
  server.serve_forever()

# dataset_dir = "../assessment_3/bin/data/faces"
# dataset_dir = "./data/training_faces"

# # recogniser.train_from_folder(dataset_dir)
# # recogniser.save_known_faces()

# # image = Image.open("data/testing_faces/algore1.png")
# image = face_recognition.load_image_file("data/testing_faces/Al_Gore_0004.jpg")
# metadata = recogniser.handle_face_detected(image)
# print("Al Gore duplicate of training data (4)")
# print(metadata)

# image = face_recognition.load_image_file("data/testing_faces/Al_Gore_0005.jpg")
# metadata = recogniser.handle_face_detected(image)
# print("Al Gore duplicate of training data (5)")
# print(metadata)

# image = face_recognition.load_image_file("data/testing_faces/Al_Gore_2.jpg")
# metadata = recogniser.handle_face_detected(image)
# print("Al Gore new picture")
# print(metadata)

# image = face_recognition.load_image_file("data/testing_faces/angelina_jolie.jpeg")
# metadata = recogniser.handle_face_detected(image)
# print("Angelina Jolie")
# print(metadata)

