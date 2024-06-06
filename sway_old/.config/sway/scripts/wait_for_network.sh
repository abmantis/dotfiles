#!/bin/bash

while true
do
    ping -c 1 google.com &> /dev/null && break
    sleep 1
done
sleep 2
exit 0
