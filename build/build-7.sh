
# ros2_control on the real robot
# https://articulatedrobotics.xyz/tutorials/mobile-robot/applications/ros2_control-real

sudo apt install ros-jazzy-twist-mux
sudo apt install joystick jstest-gtk evtest
sudo apt install ros-jazzy-joy ros-jazzy-teleop-twist-joy
sudo apt install ros-jazzy-joy-tester

cd dev_ws
colcon build --symlink-install
source install/setup.bash
ros2 launch articubot_two launch_sim.launch.py

ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -p stamped:=true -r /cmd_vel:=/cmd_vel_keyboard -p frame_id:=base_link -p use_sim_time:=true

ros2 run teleop_twist_joy teleop_node --ros-args -p stamped:=true -r /cmd_vel:=/cmd_vel_keyboard -p frame_id:=base_link -p use_sim_time:=true

# Gamepads
ros2 run joy joy_enumerate_devices
ros2 run joy joy_node # <-- Run in first terminal
ros2 topic echo /joy # <-- Run in second terminal
ros2 run joy_tester test_joy

cd dev_ws
source /opt/ros/jazzy/setup.bash
colcon build --symlink-install
source /opt/ros/jazzy/setup.bash
source install/setup.bash

## Terminal 1
ros2 run joy joy_node

## Terminal 2
ros2 run ps_ros2_common joy_test

## Terminal 3
ros2 topic echo /output
