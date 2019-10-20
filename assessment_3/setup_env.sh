
# Run this with the command:
# source ./setup_env.sh
# to set the correct environment variables for the project.

SCRIPT_DIR=$(dirname $(readlink -f $0))

echo "Setting environment variables..."

# Port number for control_centre
export CONTROL_CENTRE_RECIEVER_PORT=8001
export RECOGNISER_SERVER_PORT=8002
export RECOGNISER_CLIENT_PORT=8003
export ASCII_SERVER_PORT=8004
export ASCII_CLIENT_PORT=8005
echo "\tCONTROL_CENTRE_RECIEVER_PORT=$CONTROL_CENTRE_RECIEVER_PORT"
echo "\tRECOGNISER_SERVER_PORT=$RECOGNISER_SERVER_PORT"
echo "\tRECOGNISER_CLIENT_PORT=$RECOGNISER_CLIENT_PORT"
echo "\ASCII_SERVER_PORT=$ASCII_SERVER_PORT"
echo "\ASCII_CLIENT_PORT=$ASCII_CLIENT_PORT"

# This is the path of the FIFO pipe
export VID_OUT_DIR=$SCRIPT_DIR/webcam_out
echo "\tVID_OUT_DIR=$VID_OUT_DIR"
