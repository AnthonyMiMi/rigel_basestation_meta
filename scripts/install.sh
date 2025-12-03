#!/bin/bash

set -e

ROS_DISTRO=jazzy

# Pre-configue the system
# update
echo "Updating system"
sudo apt-get update
sudo apt-get upgrade

# setup system
echo "Setting up the system"

sudo apt update && sudo apt install locales curl software-properties-common -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

echo "System setup finished"

# Prerequisite
# install ros jazzy
echo "Installing ROS ${ROS_DISTRO}"

sudo add-apt-repository universe
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb
sudo apt update && sudo apt install ros-dev-tools
sudo apt install ros-${ROS_DISTRO}-desktop -y

source /opt/ros/jazzy/setup.bash
echo "source /opt/ros/jazzy/setup.bash" >> ${HOME}/.bashrc

echo "ROS ${ROS_DISTRO} installed"

# install custom software packages
echo "Installing Rigel basestation software packages"

ROS_WS=${HOME}/rigel/rigel_ws
mkdir -p ${ROS_WS/src
cd ${HOME}/rigel/
git clone -b ${ROS_DISTRO} git@github.com:AnthonyMiMi/rigel_basestation_meta.git

cd ${ROS_WS/src
if ! git clone -b ${ROS_DISTRO} git@github.com:AnthonyMiMi/rigel_basestation_ros.git
then
  echo "Failed to clone git repository. Please check if you have the correct access right to the repositories."
  exit(1)
fi

git clone -b ${ROS_DISTRO} git@github.com:AnthonyMiMi/rigel_description.git
git clone -b ${ROS_DISTRO} git@github.com:AnthonyMiMi/rigel_msgs.git
git clone -b ${ROS_DISTRO} git@github.com:AnthonyMiMi/rigel_teleop.git

# build ros packages
cd ${ROS_WS}
colcon build

echo "source ${ROS_WS}/install/setup.bash" >> ${HOME}/.bashrc

echo "Rigel basestation software packages installed"

# configure system
echo "Configuring system"

# for each step, you need to consider how these changes can be reverted in an uninstall script.
# e.g. if you only need to add a line to some file, use commands such as `sed` and `tee`. This
# means the line can be removed with these commands later on.

# turn off auto update, configure this and that etc.
# add udev rules, set up auto launch, etc..

echo "System configured"
echo "Installation complete!"
