
# Navigation with Nav2
sudo apt install ros-jazzy-navigation2 ros-jazzy-nav2-bringup ros-jazzy-turtlebot3*

cd dev_ws
cp /opt/ros/jazzy/share/nav2_bringup/params/nav2_params.yaml  ./src/articubot_two/config/
colcon build --symlink-install
source install/setup.bash
ros2 launch articubot_two launch_sim.launch.py

# Running in sim
ros2 launch slam_toolbox online_async_launch.py params_file:=src/articubot_two/config/mapper_params_online_async.yaml use_sim_time:=true
ros2 launch nav2_bringup navigation_launch.py params_file:=src/articubot_two/config/nav2_params.yaml use_sim_time:=true
rviz2 --ros-args -p use_sim_time:=true

# Add > Map > Topic: /global_costmap/costmap
# Color Scheme: costmap
# 2D Goal Pose > click map

# Panels > Add New Panel > Navigation 2
# Add Tool > Goal Tool
# Waypoint

# Running on the real robot
ros2 launch nav2_bringup navigation_launch.py use_sim_time:=false

# AMCL Localisation
cp /opt/ros/jazzy/share/nav2_bringup/launch/localization_launch.py  ./src/articubot_two/launch/
# change nav2_bringup to articubot_two
# change params to config
cp /opt/ros/jazzy/share/nav2_bringup/launch/navigation_launch.py  ./src/articubot_two/launch/
# change nav2_bringup to articubot_two
# change params to config

ros2 launch articubot_two localization_launch.py map:=./my_map_save.yaml use_sim_time:=true
ros2 launch articubot_two navigation_launch.py use_sim_time:=true map_subscribe_transient_local:=true

cp /opt/ros/jazzy/share/slam_toolbox/launch/online_async_launch.py  ./src/articubot_two/launch/
# change nav2_bringup to articubot_two
# cp /opt/ros/jazzy/share/slam_toolbox/launch/localization_launch.py  ./src/articubot_two/launch/
# may conflict with nav2 if copy over
