#!/bin/bash

# Time and file name
time=$(date +"%Y.%m.%d-%H:%M:%S")
file="Report_${time}.txt"

# Two variables for file invocation
partition=$1

# Writing available disks to the file
echo "Available disks" > $file
lsblk -o NAME,SIZE,TYPE | grep 'disk' >> $file

# Writing available space on the user-specified partition to the file
echo -e >> $file
echo -e "Available space on partition $1" >> $file
df -h $1 >> $file

# Displaying a message in the console that the file has been saved in the current location
echo "A file named $file has been saved in $(pwd)"

