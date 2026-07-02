
cd dev_ws
colcon build --symlink-install
source install/setup.bash
ros2 launch articubot_two launch_sim.launch.py
# Add an Image Display from the 3 dots menu in the top right to get a preview of what our camera is seeing

# Testing control
ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -p stamped:=true -p use_sim_time:=true

rviz2
# add an Image section. Set the topic to /camera/image_raw and make sure the Fixed Frame is set to something on your robot (e.g. base_link, or if that doesn't work, camera_link).

# [Optional] Need a real camera
# Setting up the real camera
sudo apt install v4l-utils ros-jazzy-image-transport-plugins ros-jazzy-rqt-image-view
# Also, use the groups command to confirm you are already in the video group (to allow camera access). If not, run sudo usermod -aG video $USER (this requires log out/restart to take effect).

# USB Webcam
# install the driver node
sudo apt install ros-jazzy-usb-cam
ros2 run usb_cam usb_cam_node_exe

# If you are trying to run a USB webcam at the same time as a Pi camera you may find the Pi camera takes over the default video device and you need to override it with the video_device parameter. To find the correct device you can run the following command (for me it was /dev/video8). You may need to install v4l-utils if you haven't already.
v4l2-ctl --list-devices

ros2 run rqt_image_view rqt_image_view

# Install libcamera Dependencies
sudo apt install -y libboost-dev libgnutls28-dev openssl libtiff-dev pybind11-dev qtbase5-dev libqt5core5a meson cmake python3-yaml python3-ply libglib2.0-dev libgstreamer-plugins-base1.0-dev

# Compile libcamera and camera_ros
# Make sure you have sourced your ROS installation first!!
# Enter workspace source directory - if your workspace is elsewhere you can change accordingly
cd dev_ws/src
# Install colcon meson support
sudo apt -y install python3-colcon-meson
# Clone libcamera (raspberrypi fork)
git clone https://github.com/raspberrypi/libcamera.git
# Clone camera_ros
git clone https://github.com/christianrauch/camera_ros.git
# Resolve dependencies
cd ..
rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO --skip-keys=libcamera
# Build! (If you have a modified build command you usually use, run that instead)
colcon build --symlink-install 

# Run the camera_ros node
source install/setup.bash
ros2 run camera_ros camera_node

# Decompressing and republishing image data
# first check which plugins image_transport has installed
ros2 run image_transport list_transports

# Then, to republish a topic we need to specify the type of the input, then the type of the output. We also need to remap some topics, which are in the format {in/out}/{type} (with no type for uncompressed/raw). For example, to remap from a compressed input topic to a raw output topic we use:
ros2 run image_transport republish compressed raw --ros-args -r in/compressed:=/camera/image_raw/compressed -r out:=/camera/my_uncompressed_image
