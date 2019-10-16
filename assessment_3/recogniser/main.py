import os

from user_recogniser import UserRecogniser
import face_recognition

from pythonosc import dispatcher
from pythonosc import osc_server

host = "localhost"
port = int(os.environ.get("RECOGNISER_PORT"))

print("host = {}".format(host))
print("port = {}".format(port))

def add_new(address, args, buffer, uid, width, height):
  print(args)
  try:
    print("____________________")
    print("|{0}\t|{1}\t|{2}\t|lenght|".format(args[1], args[2], args[3]))
    print("|{0}\t|{1}\t|{2}\t|{3}".format(uid, width, height, len(buffer)))
  except ValueError: pass
  except IndexError:
    print("Index error on add_new, are you sending the osc params successfully?")
    pass

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

# # dataset_dir = "../assessment_3/bin/data/faces"
# dataset_dir = "./data/training_faces"

# recogniser = UserRecogniser()
# recogniser.load_known_faces()
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

