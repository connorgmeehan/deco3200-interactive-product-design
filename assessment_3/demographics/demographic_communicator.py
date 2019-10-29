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
        print("DemographicCommuncator.setup(video_out_dir: {0}, host: {1}, serverport: {2}, clientport: {3})".format(video_out_dir, host, serverport, clientport))
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
            isMale, age = self.demographic_detector.handleNewRoi(im, width, height)
            print("demographic_detector gender: {0}, age: {1}".format(gender, age))
            if(age is not None and isMale is not None):
                self.pass_emotion_to_client(uid, age, isMale)
    
    def pass_emotion_to_client(self, uid, age, isMale):
        print("EmotionCommunicator.pass_demographic_to_client() -> age: {0}, gender(isMale): {1}".format(age, isMale))
        if isMale:
            msg = oscbuildparse.OSCMessage("/display/demographic", ",ifT", [uid, age])
        else:
            msg = oscbuildparse.OSCMessage("/display/demographic", ",ifF", [uid, age])
        osc_send(msg, "demographicclient")