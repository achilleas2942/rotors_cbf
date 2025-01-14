#!/bin/bash
set -e

# Source the ROS setup
source /opt/ros/noetic/setup.bash

# Pull the latest updates from the repositories
cd /root/catkin_ws/src
if [ -d "cf_cbf" ]; then
    cd cf_cbf && git pull && cd ..
else
    git clone git@github.com:viswans2132/cf_cbf.git
    git clone git@github.com:achilleas2942/summer_school_controller.git
fi

# Build the workspace
cd /root/catkin_ws/
catkin_make

# Source the workspace
source /root/catkin_ws/devel/setup.bash

# Export ROS_MASTER_URI
export ROS_MASTER_URI=http://130.240.96.104:11311

# Automatically detect and export the host IP for ROS_IP
export ROS_IP=$(ip route | grep default | awk '{print $3}')

# Execute the provided command
exec "$@"
