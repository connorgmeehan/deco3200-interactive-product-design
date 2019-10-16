import os
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


def add_new(address, args, uid, width, height):
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
    im = cv2.cvtColor(im, cv2.COLOR_RGB2BGR) # cv2 uses BGR colorspace
    metadata = recogniser.handle_face_detected(im)
    print("metadata: {}".format(metadata))

def clear_all():
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

