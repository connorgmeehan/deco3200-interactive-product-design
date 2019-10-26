from time import sleep

from osc4py3.as_eventloop import *
from osc4py3 import oscmethod as osm
from osc4py3 import oscbuildparse

import fifoutil

import cv2
import emotion_detector

import logging

class EmotionCommunicator:
    def __init__(self, video_out_dir, host, serverport, clientport):
        self.emotion_detector = emotion_detector.EmotionDetector()
        self.video_out_dir = video_out_dir

        # logging.basicConfig(format='%(asctime)s - %(threadName)s ø %(name)s - '
        # '%(levelname)s - %(message)s')
        # logger = logging.getLogger("osc")
        # logger.setLevel(logging.DEBUG)
        # osc_startup(logger=logger)

        osc_startup()
        osc_udp_client(host, clientport, "emotionclient")
        osc_udp_server(host, serverport, "emotionserver")
        self.map_handlers()

        finished = False
        while not finished:
            osc_process()    
        osc_terminate()

    def map_handlers(self):
        osc_method("/algorithm/emotion", self.handle_new_roi)

    def handle_new_roi(self, uid, width, height):
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
        msg = oscbuildparse.OSCMessage("/display/emotion", ",sf", [emotion, certainty])
        osc_send(msg, "emotionclient")