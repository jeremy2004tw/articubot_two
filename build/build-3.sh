
cd dev_ws
colcon build --symlink-install
source install/setup.bash
ros2 launch articubot_two rsp.launch.py use_sim_time:=true
# check if it worked by opening a new terminal and running
ros2 param get /robot_state_publisher use_sim_time

# install Gazebo
sudo apt install ros-jazzy-ros-gz
# launch Gazebo
ros2 launch ros_gz_sim gz_sim.launch.py gz_args:=empty.sdf
# Spawning our robot
ros2 run ros_gz_sim create -topic robot_description -name my_bot -z 0.1

# Creating a launch file
ros2 launch articubot_two launch_sim.launch.py

# Testing control
ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -p stamped:=true -p use_sim_time:=true

rviz2
# Fixed Frame: odom
# Add > TF > Show Names
# Add > RobotModel > Description Topic: /robot_description
#     > RobotModel > Visual Enabled > Collision Enabled

# Making an Obstacle Course
ros2 launch articubot_two launch_sim.launch.py world:=./src/articubot_two/worlds/my_cool_world.sdf

ros2 topic list
ros2 topic echo /cmd_vel
ros2 topic info /cmd_vel
