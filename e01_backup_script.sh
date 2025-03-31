#!/bin/bash

# Usage of the script
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/file.E01"
    exit 1
fi

# Variables
image_path=$1
date=$(date +"%Y-%m-%d_%H:%M:%S")
backup_name="backup_${date}.EO1"
backup_dir="/home/ubuntu/backup/"
backup_file="$backup_dir/$backup_name"
checksum="/home/ubuntu/backup/checksums_${date}.txt"

# Check if the file exists and has an E01 extension
if [[ ! -f "$image_path" || "${image_path##*.}" != "E01" ]]; then
    echo "Error: File does not exist or does not have a .E01 extension"
    exit 1
fi

# Creating a backup of the image
cp $image_path $backup_dir/$backup_name
echo "Successfully created an image backup in ${backup_dir} with name ${backup_name}"

# Creating a checksum file
touch $checksum
echo "Successfully created a checksum file in ${backup_dir}"

# Original file checksums
echo "Checksums for the original file:" >> $checksum
echo "SHA1 - $(sha1sum ${image_path} | awk '{print $1}')" >> $checksum
echo "MD5 - $(md5sum ${image_path} | awk '{print $1}')" >> $checksum

echo -e >> $checksum
# Copied file checksums
echo "Checksums for the copied file:" >> $checksum
echo "SHA1 - $(sha1sum ${backup_file} | awk '{print $1}')" >> $checksum
echo "MD5 - $(md5sum ${backup_file} | awk '{print $1}')" >> $checksum

echo "Checksums saved in ${checksum}"
echo -e
# Comparing checksums
original_sha1=$(sha1sum ${image_path} | awk '{print $1}')
original_md5=$(md5sum ${image_path} | awk '{print $1}')

backup_sha1=$(sha1sum ${backup_file} | awk '{print $1}')
backup_md5=$(md5sum ${backup_file} | awk '{print $1}')

if [[ "$original_sha1" == "$backup_sha1" && "$original_md5" == "$backup_md5" ]]; then
    echo "Backup is valid. Checksums match."
else
    echo "Error: Checksums do not match!"
fi

