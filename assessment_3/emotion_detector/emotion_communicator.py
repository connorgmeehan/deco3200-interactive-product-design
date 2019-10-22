from time import sleep

from pythonosc import dispatcher
from pythonosc import osc_server
from pythonosc import udp_client
import fifoutil

import cv2
import emotion_detector

class EmotionCommunicator:
    def __init__(self, video_out_dir, host, serverport, clientport):
        self.emotion_detector = emotion_detector.EmotionDetector()

        self.video_out_dir = video_out_dir
        self.client = udp_client.SimpleUDPClient(host, clientport)
        self.dispatcher = dispatcher.Dispatcher()
        self.map_handlers()
        self.server = osc_server.ThreadingOSCUDPServer(
            (host, serverport), self.dispatcher)
        print("Serving on {}".format(self.server.server_address))
        self.server.serve_forever()

    def map_handlers(self):
        self.dispatcher.map("/algorithm/emotions", self.handle_new_roi, "uid", "width", "height")

    def handle_new_roi(self, address, args, uid, width, height):
        print("\EmotionCommunicator.handle_new_roi(uid: {0}, width: {1}, height: {2})".format(uid, width, height))        
        im = None
        # Try to read the image
        try:

            im = fifoutil.read_array(self.video_out_dir)
        except FileNotFoundError:
            print("FileNotFoundError when trying to read {}".format(self.video_out_dir))
            pass
        except ValueError:
            print("ValueError when trying to read file, it's probably corrupted")
            pass

        # If successful
        if im is not None:
            # cv2 uses BGR colorspace
            im = cv2.cvtColor(im, cv2.COLOR_RGB2BGR)
            emotion, certainty = self.emotion_detector.handleNewRoi(im)
            self.pass_emotion_to_client(emotion, certainty)
    
    def pass_emotion_to_client(self, emotion, certainty):
        print("EmotionCommunicator.pass_emotion_to_client() -> emotion: {0}, certainty: {1}".format(emotion, certainty))
        self.client.send_message("/display/emotion", [emotion, certainty])
