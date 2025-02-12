#!/bin/bash

# Set the log file name with a timestamp
log_file="memory_usage_$(date +"%Y-%m-%d").log"

# Get memory usage details and append to log file
echo "===== Memory Usage Report - $(date +"%Y-%m-%d %H:%M:%S") =====" >> $log_file
free -h >> $log_file
echo "" >> $log_file

# Print message to the user
echo "Memory usage report saved to $log_file in $(pwd)"
