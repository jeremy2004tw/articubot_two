
sudo apt install ros-jazzy-xacro ros-jazzy-joint-state-publisher-gui

cd dev_ws
colcon build --symlink-install
source install/setup.bash
ros2 launch articubot_two rsp.launch.py
rviz2

# Fixed Frame: base_link
# Add > TF > Show Names
# Add > RobotModel > Description Topic: /robot_description
#     > RobotModel > Visual Enabled > Collision Enabled

ros2 run joint_state_publisher_gui joint_state_publisher_gui
# Adjust the sliders to move the robot's joints and see the changes in RViz2

rviz2 -d ./src/articubot_two/config/view_bot.rviz
