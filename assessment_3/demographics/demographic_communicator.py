from time import sleep

from osc4py3.as_eventloop import *
from osc4py3 import oscmethod as osm
from osc4py3 import oscbuildparse

import fifoutil

import cv2
import demographic_detector

import logging

class DemographicCommunicator:
    def __init__(self, video_out_dir, host, serverport, clientport):
        self.demographic_detector = demographic_detector.DemographicDetector()
        self.video_out_dir = video_out_dir

        # logging.basicConfig(format='%(asctime)s - %(threadName)s ø %(name)s - '
        # '%(levelname)s - %(message)s')
        # logger = logging.getLogger("osc")
        # logger.setLevel(logging.DEBUG)
        # osc_startup(logger=logger)

        osc_startup()
        osc_udp_client(host, clientport, "demographicclient")
        osc_udp_server(host, serverport, "demographicserver")
        self.map_handlers()

        finished = False
        while not finished:
            osc_process()    
        osc_terminate()

    def map_handlers(self):
        osc_method("/algorithm/demographic", self.handle_new_roi)

    def handle_new_roi(self, uid, width, height):
        print("\demographicCommunicator.handle_new_roi(uid: {0}, width: {1}, height: {2})".format(uid, width, height))        
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
            age, gender = self.demographic_detector.handleNewRoi(im)
            self.pass_emotion_to_client(age, gender)
    
    def pass_emotion_to_client(self, age, gender):
        print("EmotionCommunicator.pass_demographic_to_client() -> age: {0}, gender: {1}".format(age, gender))
        msg = oscbuildparse.OSCMessage("/display/emotion", ",sf", [age, gender])
        osc_send(msg, "demographic")