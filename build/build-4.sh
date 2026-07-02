
cd dev_ws
colcon build --symlink-install
source install/setup.bash
ros2 launch articubot_two launch_sim.launch.py
# To visualise the lidar beams, click the three dots in the top-right corner and add a Visualize Lidar plugin
# Then click the reload button and select the /scan topic

rviz2
# Add > LaserScan

# Testing control
ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -p stamped:=true -p use_sim_time:=true

# [Optional] Need a real lidar
# Installing the driver
sudo apt install ros-jazzy-rplidar-ros

# Talking to the Lidar
ros2 run rplidar_ros rplidar_composition --ros-args -p serial_port:=/dev/ttyUSB0 -p frame_id:=laser_frame -p angle_compensate:=true -p scan_mode:=Standard
# -p serial_port:=/dev/ttyUSB0 - The serial port the lidar is on (more on this later!)
# -p frame_id:=laser_frame - The transform frame for our lidar
# -p angle_compensate:=true - We just want this setting to be on. If you don’t set it, it says it’s on but it doesn’t actually work properly
# -p scan_mode:=Standard - Which scan mode the lidar is in, which controls how many points there are and stuff. I’ll set mine to standard but you can check the manual and find an option that works for you.

# Starting/stopping the motor
ros2 service call /stop_motor std_msgs/Empty {}

# Killing the node
killall rplidar_composition
