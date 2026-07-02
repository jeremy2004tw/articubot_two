
# Installing dependencies
sudo apt install ros-jazzy-ros2-control ros-jazzy-ros2-controllers ros-jazzy-gz-ros2-control

# Starting the controllers
cd dev_ws
colcon build --symlink-install
source install/setup.bash
ros2 launch articubot_two launch_sim.launch.py

ros2 control list_hardware_interfaces
# ros2 run controller_manager spawner diff_cont --controller-ros-args "-r /diff_cont/cmd_vel:=/cmd_vel"
# ros2 run controller_manager spawner joint_broad
ros2 control list_controllers 

# Testing control
ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -p stamped:=true -p use_sim_time:=true

ros2 launch articubot_two launch_sim.launch.py use_ros2_control:=true #default
ros2 launch articubot_two launch_sim.launch.py use_ros2_control:=false
