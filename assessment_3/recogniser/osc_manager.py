from time import sleep

from osc4py3.as_eventloop import *
from osc4py3 import oscmethod as osm
from osc4py3 import oscbuildparse

import fifoutil

import cv2
import recogniser


class OscManager:
  def __init__(self, video_out_dir, host, serverport, clientport):
    print("OscManager(video_out_dir: {0}, host: {1}, serverport: {2}, clientport{3})".format(video_out_dir, host, serverport, clientport))
    self.recogniser = recogniser.Recogniser()
    self.video_out_dir = video_out_dir

    osc_startup()
    osc_udp_client(host, clientport, "recogniserclient")
    osc_udp_server(host, serverport, "recogniserserver")
    self.map_handlers()

    finished = False
    while not finished:
      sleep(0.002)
      osc_process()    
    osc_terminate()

  def map_handlers(self):
    osc_method("/algorithm/roi", self.handle_new_roi)
    osc_method("/algorithm/clear_all", self.clear_all_rois)

  def handle_new_roi(self, uid, width, height):
    print("\nOscManager.handle_new_roi(uid: {0}, width: {1}, height: {2})".format(uid, width, height))
    im = None
    # Try to read the image
    try:
      sleep(0.05)
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
      # Pass to Recogniser
      self.recogniser.handle_new_roi(uid, im)

      if self.recogniser.ready_to_decide():
        coresponding_uid = self.handle_decision(self.recogniser.handle_is_new_decision())        
        if coresponding_uid is None:
          self.recogniser.save_stored_encodings()
          self.pass_decision_to_client(None)
        else:
          self.pass_decision_to_client(coresponding_uid)
          print("\tAlready seen user with uid: {}".format(coresponding_uid))
        self.clear_all_rois()
  
  def handle_decision(self, results):
    print("OscManager.handle_decision(results: {})".format(results))
    # If 2/3 of the images are not recognised, it's a new face
    results = list(filter(None.__ne__, results))
    if len(results) <= 1:
      return None 
    # Build a key value dictionary of each result and its frequency
    results_frequency = {}
    for res in results:
      if 'uid' in res:
        if res['uid'] not in results_frequency:
          results_frequency[res['uid']] = 0
        else:
          results_frequency[res['uid']] = results_frequency[res['uid']] + 1
      else:
        print("\tNo 'uid' in res({})".format(res))
    print("\tresults_frequency: {}.".format(results_frequency))
    # Find the value that was most frequent
    max_uid = None
    for uid, frequency in zip(results_frequency.keys(), results_frequency.values()):
      # Defaults to the first value
      if max_uid == None:
        max_uid = uid

      if frequency > results_frequency[max_uid]:
        max_uid = uid
    # Return it
    return max_uid

  def pass_decision_to_client(self, retrieved_uid):
    print("\nOscManager.pass_decision_to_client()")
    msg = None
    if retrieved_uid is None:
      retrieved_uid = -1
      msg = oscbuildparse.OSCMessage("/control/detected", ",iT", [retrieved_uid, True])
    else:
      msg = oscbuildparse.OSCMessage("/control/detected", ",iF", [retrieved_uid, False])

    # Override decision for testing purposes
    msg = oscbuildparse.OSCMessage("/control/detected", ",iT", [retrieved_uid, True])
    osc_send(msg, "recogniserclient")


  def clear_all_rois(self):
    print("\nOscManager.clear_all_rois()")
    self.recogniser.clear()
