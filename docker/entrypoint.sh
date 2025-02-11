#!/bin/bash

# Source the ROS setup
source /opt/ros/noetic/setup.bash

# Set the parameter
Pelican_No=${1:-1}
ROS_MASTER_IP=${2:-$(hostname -I | awk '{print $1}')}
ROS_IP=${3:-$ROS_MASTER_IP}

# Pull the latest updates from the repositories
cd /root/catkin_ws/src
if [ -d "cf_cbf" ]; then
    cd cf_cbf && git pull && cd ..
else
    git clone https://github.com/viswans2132/cf_cbf.git
    git clone https://github.com/viswans2132/ss_workshop.git
    git clone https://github.com/ethz-asl/mav_comm.git
fi

# Build the workspace
cd /root/catkin_ws/
catkin_make

# Source the workspace
source /root/catkin_ws/devel/setup.bash

# Export ROS_MASTER_URI and ROS_IP
export ROS_MASTER_URI=http://"$ROS_MASTER_IP":11311
export ROS_IP="$ROS_IP"

# Execute the provided command
roslaunch cf_cbf tro_docker_cf_cont.launch namespace:="dcf"$Pelican_No""