#!/bin/bash 

#alacritty --working-directory "/home/ge/docs/Android/AndroidStudioProjects" --class lf -e lfrun &
kitty -d "/home/ge/docs/Android/AndroidStudioProjects" --class lf -e lfrun &
sleep 0.5
/home/ge/docs/Android/Sdk/emulator/emulator -avd android_7 

