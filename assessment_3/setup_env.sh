
# Run this with the command:
# source ./setup_env.sh
# to set the correct environment variables for the project.

echo "Setting environment variables..."

# Port number for control_centre
export CONTROL_CENTRE_RECIEVER_PORT=8001
export RECOGNISER_PORT=8002
echo "\tCONTROL_CENTRE_RECIEVER_PORT=$CONTROL_CENTRE_RECIEVER_PORT"
echo "\tRECOGNISER_PORT=$RECOGNISER_PORT"

# This is the path of the FIFO pipe
export VID_OUT_DIR=$(pwd)/webcam_out
echo "\tVID_OUT_DIR=$VID_OUT_DIR"
