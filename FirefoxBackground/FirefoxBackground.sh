#!/bin/bash

# firefox "about:blank" &
sleep 5
WAITFOR="$(whoami) Mozilla Firefox"

findFirefox(){
    ps aux | grep firefox
    wmctrl -lp
    pid=$(wmctrl -lp | grep "${WAITFOR}" | head -1 | awk '{print $1}')
}

findFirefox
while [ -z "$pid" ]; do
    sleep 1
    findFirefox
done
echo $pid
xdotool windowunmap $pid
