from user_recogniser import UserRecogniser
import face_recognition

from flask import Flask, request
app = Flask(__name__)

rois = []

@app.route('/clear_rois', methods=['POST'])
def clear_rois():
  print('info: rois cleared')
  rois.clear()
  return "cleared rois"

@app.route('/add_roi', methods=['POST'])
def add_roi():
  print('info: adding roi')
  print(request.args)
  return "added roi"

app.run(debug=True, host='localhost', port=8001)
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

