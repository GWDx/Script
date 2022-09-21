#!/bin/bash
while true
do
    echo x | sudo -S /usr/sbin/ntpdate time.ustc.edu.cn
    if [ $? -eq 0 ]
    then
        break
    fi
    sleep 10
done
