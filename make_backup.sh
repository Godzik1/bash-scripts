#!/bin/bash

# Date and file name
date=$(date +"%Y-%m-%d")
file="backup_$date.tar.gz"

files="$@"

# Creating a backup
tar -czf /home/systemy/backup/$file $files

# Checking if the backup was created successfully
if [ $? -eq 0 ]; then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Backup successfully created: $file" >> /home/systemy/backup/backup.log
else
    echo "$(date +"%Y-%m-%d %H:%M:%S") - ERROR during backup creation" >> /home/systemy/backup/backup.log
fi

