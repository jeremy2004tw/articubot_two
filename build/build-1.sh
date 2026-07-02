
mkdir dev_ws
cd dev_ws
mkdir src
cd src

git clone https://github.com/jeremy2004tw/articubot_two.git
cd ..
colcon build --symlink-install
