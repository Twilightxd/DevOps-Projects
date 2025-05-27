#!/bin/bash


#####################################################################
# server-stats.sh - A simple script to analyze server performance
# Description: To monitor essential performance metrics for any Linux System
# Usage: ./server-stats.sh

# Author: iTwili8-Manas
# Date: $(date)
#####################################################################


echo "=================================================="
echo "Server Performance Report"
echo "$(date)"
echo "=================================================="


echo -e "\n CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{print "User: " $2"%, System: "$4"%, Idle: " $8"%"}'

echo -e "\n Memory Usage:"
free -m | awk 'NR==2{printf "Used: %s MB | Free: %s MB | Usage: %.2f%%\n", $3, $4, $3*100/$2 }'

echo -e "\n Disk Usage:"
df -h --total | awk '/total/ {printf "Used: %s | Free: %s | Usage: %s\n", $3. $4, $5}'

echo -e "\n Top 5 processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo -e "\n Top 5 processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6


# Optional --

echo -e "\n OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2

echo -e "\n Uptime:"
uptime -p

echo -e "\n Load Average:"
uptime  | awk -F 'load average:' '{ print $2 }'

echo -e "\n Logged in Users:"
who | wc -l

echo -e "\n Failed Login Attempts:"
journalctl_COMM=sshd | grep "Failed passweord" | wc -l
