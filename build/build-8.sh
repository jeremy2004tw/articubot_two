
# SLAM with slam_toolbox
sudo apt install ros-jazzy-slam-toolbox

# Slam_toolbox comes with some launch and params files to help us with this. We’re going to start by copying the online async params file to our own directory so we can modify it.
cp /opt/ros/jazzy/share/slam_toolbox/config/mapper_params_online_async.yaml src/articubot_two/config/

cd dev_ws
colcon build --symlink-install
source install/setup.bash
ros2 launch articubot_two launch_sim.launch.py

ros2 launch slam_toolbox online_async_launch.py use_sim_time:=true params_file:=./src/articubot_one/config/mapper_params_online_async.yaml
ros2 service list

rviz2
# Add Map > Topic: /map
# Fixed Frame: map

# Panels > Add New Panel > SlamToolboxPlugin
# Save Map: my_map_save
# Serialize Map: my_map_serial

ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -p stamped:=true -p use_sim_time:=true

sudo apt install ros-jazzy-navigation2 ros-jazzy-nav2-bringup ros-jazzy-turtlebot3*
ros2 run nav2_map_server map_server --ros-args -p yaml_filename:=my_map_save.yaml -p use_sim_time:=true
ros2 run nav2_util lifecycle_bringup map_server
ros2 run nav2_amcl amcl --ros-args -p use_sim_time:=true
ros2 run nav2_util lifecycle_bringup amcl
