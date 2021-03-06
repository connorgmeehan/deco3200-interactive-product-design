from time import sleep

from osc4py3.as_eventloop import *
from osc4py3 import oscmethod as osm
from osc4py3 import oscbuildparse

import fifoutil

import cv2 as cv
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
            sleep(0.002)
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
        except Exception:
            print("Other Exception")
            pass

        # If successful
        if im is not None:
            # cv2 uses BGR colorspace
            # im = cv2.cvtColor(im, cv2.COLOR_RGB2BGR)
            grey = cv.cvtColor(im, cv.COLOR_RGB2GRAY)
            emotion, certainty = self.emotion_detector.handleNewRoi(grey)
            self.pass_emotion_to_client(uid, emotion, certainty)
    
    def pass_emotion_to_client(self, uid, emotion, certainty):
        print("EmotionCommunicator.pass_emotion_to_client() -> uid: {0}, emotion: {1}, certainty: {2}".format(uid, emotion, certainty))
        msg = oscbuildparse.OSCMessage("/control/emotion", ",isf", [uid, emotion, certainty])
        osc_send(msg, "emotionclient")