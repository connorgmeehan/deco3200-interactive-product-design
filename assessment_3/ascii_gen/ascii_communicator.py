
from osc4py3.as_eventloop import *
from osc4py3 import oscmethod as osm
from osc4py3 import oscbuildparse

import fifoutil

from pyasciigen.asciigen import from_image
import cv2 as cv
from PIL import Image

from normalize_array import normalize

class AsciiCommunicator:
  def __init__(self, video_out_dir, host, serverport, clientport):
    print("AsciiCommunicator(video_out_dir: {0}, host: {1}, serverport: {2}, clientport: {3})".format(video_out_dir, host, serverport, clientport))
    print("Server running on {0}:{1}, sending results back to {0}:{2}".format(host, serverport, clientport))
    self.lastUid = -1
    self.video_out_dir = video_out_dir

    osc_startup()
    osc_udp_client(host, clientport, "asciiclient")
    osc_udp_server(host, serverport, "asciiserver")
    self.map_handlers()
    finished = False
    while not finished:
      osc_process()
    osc_terminate()


  def map_handlers(self):
    osc_method("/algorithm/ascii", self.handle_new_roi)
    osc_method("/*", self.default_handler)
    osc_method("/*/*", self.default_handler)

  def handle_new_roi(self, uid, width, height):
    print("\nAsciiCommunicator.handle_new_roi()")
    self.lastUid = uid
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
      im = cv.normalize(im,None,0,255,cv.NORM_MINMAX)
      pil_image = Image.fromarray(im)
      ascii_string = from_image(pil_image, 100, brightness=None, contrast=3) 
      self.pass_result_to_client(ascii_string)

  def pass_result_to_client(self, ascii_string):
    msg = oscbuildparse.OSCMessage("/control/ascii", ",is", [self.lastUid, ascii_string])
    osc_send(msg, "asciiclient")

  def default_handler(self, address, args):
    print("AsciiCommunicator.default_handler(address: {0}, args: {1})".format(address, args))