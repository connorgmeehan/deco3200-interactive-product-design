import os

import osc_manager

host = "localhost"
port = int(os.environ.get("RECOGNISER_PORT"))
video_out_dir = os.environ.get('VID_OUT_DIR')

osc_manager = osc_manager.OscManager(video_out_dir, host, port, 8999)