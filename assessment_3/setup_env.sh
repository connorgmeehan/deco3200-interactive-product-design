
# Run this with the command:
# source ./setup_env.sh
# to set the correct environment variables for the project.

SCRIPT_DIR=$(dirname $(readlink -f $0))

echo "Setting environment variables..."

# Port number for control_centre
export CONTROL_CENTRE_RECIEVER_PORT=8001
echo "\tCONTROL_CENTRE_RECIEVER_PORT=$CONTROL_CENTRE_RECIEVER_PORT"
export RECOGNISER_SERVER_PORT=8002
echo "\tRECOGNISER_SERVER_PORT=$RECOGNISER_SERVER_PORT"
export RECOGNISER_CLIENT_PORT=8003
echo "\tRECOGNISER_CLIENT_PORT=$RECOGNISER_CLIENT_PORT"
export ASCII_SERVER_PORT=8004
echo "\ASCII_SERVER_PORT=$ASCII_SERVER_PORT"
export ASCII_CLIENT_PORT=8005
echo "\ASCII_CLIENT_PORT=$ASCII_CLIENT_PORT"
export EMOTION_SERVER_PORT=8006
echo "\tEMOTION_SERVER_PORT=$EMOTION_SERVER_PORT"
export DEMOGRAPHIC_SERVER_PORT=8007
echo "\tDEMOGRAPHIC_SERVER_PORT=$EMOTION_SERVER_PORT"


# This is the path of the FIFO pipe
export VID_OUT_DIR=$SCRIPT_DIR/webcam_out
echo "\tVID_OUT_DIR=$VID_OUT_DIR"
