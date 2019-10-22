import os
import osc_manager

host = "127.0.0.1"
serverport = int(os.environ.get("ASCII_SERVER_PORT"))
clientport = int(os.environ.get("CONTROL_CENTRE_RECIEVER_PORT"))
video_out_dir = os.environ.get('VID_OUT_DIR')

osc_manager = osc_manager.OscManager(video_out_dir, host, serverport, clientport)