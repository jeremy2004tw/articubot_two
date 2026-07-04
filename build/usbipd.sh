
# Dowload and install
# PlayStation®Accessories
# https://controller.dl.playstation.net/controller/lang/en/2100004.html

# Alternatively, you can also install the usbipd-win project using Windows Package Manager (winget). If you have already installed winget, just use the command: 
winget install --interactive --exact dorssel.usbipd-win
#  to install usbipd-win. If you leave out --interactive, winget may immediately restart your computer if that is required to install the drivers.
winget uninstall --interactive --exact dorssel.usbipd-win

# ps_ros2_common
# https://github.com/Ar-Ray-code/ps_ros2_common
# modify src/example_joy.cpp
#define JOY_VERSION PS5

# Connect USB devices
# https://learn.microsoft.com/en-us/windows/wsl/connect-usb
# not able to detect via bluetooth, so use USB-C cable to connect PS5 controller

# Attach a USB device
# PowerShell (Admin)
usbipd list

# BUSID  VID:PID    DEVICE                                                        STATE
# 2-5    054c:0ce6  DualSense Wireless Controller, USB Input Device               Not shared

usbipd bind --busid 2-5

# BUSID  VID:PID    DEVICE                                                        STATE
# 2-5    054c:0ce6  DualSense Wireless Controller, USB Input Device               Shared

# Now the device is shared

# To attach the USB device
usbipd attach --wsl --busid 2-5
# Note that as long as the USB device is attached to WSL, it cannot be used by Windows. Once attached to WSL

# WSL
sudo apt install usbutils
lsusb

# PowerShell
# Once you are done using the device in WSL, you can either physically disconnect the USB device or run this command from PowerShell
usbipd detach --busid 2-5


# ros2 launch teleop_twist_joy teleop-launch.py joy_config:='ps5' joy_dev:='/dev/input/js0' 


cd dev_ws/src
git clone https://github.com/Ar-Ray-code/ps_ros2_common.git
