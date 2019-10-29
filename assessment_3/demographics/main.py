import os

import demographic_communicator

host = "127.0.0.1"
serverport = int(os.environ.get("DEMOGRAPHIC_SERVER_PORT"))
clientport = int(os.environ.get("CONTROL_CENTRE_RECIEVER_PORT"))
video_out_dir = os.environ.get('VID_OUT_DIR')

demographic_communicator = demographic_communicator.DemographicCommunicator(video_out_dir, host, serverport, clientport)
