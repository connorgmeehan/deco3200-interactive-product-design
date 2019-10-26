import os
import ascii_communicator

import logging

logging.basicConfig(level=logging.DEBUG, format='[%(levelname)s] (%(threadName)-10s) %(message)s')

host = "127.0.0.1"
serverport = int(os.environ.get("ASCII_SERVER_PORT"))
clientport = int(os.environ.get("CONTROL_CENTRE_RECIEVER_PORT"))
video_out_dir = os.environ.get('VID_OUT_DIR')

ascii_communicator = ascii_communicator.AsciiCommunicator(video_out_dir, host, serverport, clientport)