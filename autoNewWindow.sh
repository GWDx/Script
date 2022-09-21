#!/bin/bash

# ./autoWindow.sh firefox --new-window www.baidu.com

application=$1
arguments=${@:2}

currentDesktopIndex=$(wmctrl -d | rg '\*' | awk '{print $1}')
windowsOnCurrentDesktop=$(wmctrl -l | rg -i "$application" | rg " $currentDesktopIndex ")

echo "$application $arguments $currentDesktopIndex" >> ~/文档/Code/Script/autoWindow.log

# if not empty, directly run
if [ -n "$windowsOnCurrentDesktop" ]; then
    $application "$arguments"
else
    $application --new-window "$arguments"
fi
