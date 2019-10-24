
from pythonosc import dispatcher
from pythonosc import osc_server
from pythonosc import udp_client

import fifoutil

from pyasciigen.asciigen import from_image
import cv2 as cv
from PIL import Image

from normalize_array import normalize

class OscManager:
  def __init__(self, video_out_dir, host, serverport, clientport):
    print("OscManager(video_out_dir: {0}, host: {1}, serverport: {2}, clientport: {3})".format(video_out_dir, host, serverport, clientport))
    self.client = udp_client.SimpleUDPClient(host, clientport)
    self.client.send_message("/ping", 0)
    self.lastUid = -1
    self.video_out_dir = video_out_dir
    self.clientport = clientport
    self.dispatcher = dispatcher.Dispatcher()
    self.map_handlers()

    self.server = osc_server.ThreadingOSCUDPServer(
      (host, serverport), self.dispatcher)
    print("Serving on {}".format(self.server.server_address))
    self.server.serve_forever()

  def map_handlers(self):
    self.dispatcher.map("/algorithm/ascii", self.handle_new_roi, "uid", "width", "height")
    self.dispatcher

  def handle_new_roi(self, address, args, uid, width, height):
    print("\nOscManager.handle_new_roi()")
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
      print(ascii_string)
      
  def pass_ascii_to_client(self, retrieved_uid):
    print("\nOscManager.pass_decision_to_client() client.port -> {}".format(self.clientport))
    if retrieved_uid is None:
      retrieved_uid = -1
    self.client.send_message("/user/detected", retrieved_uid)