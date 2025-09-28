#!/bin/bash

# Threshold values
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

LOGFILE="system_health.log"


# --- CPU Usage ---
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU=${CPU%.*}  

echo "CPU Usage: $CPU%"

if [ "$CPU" -gt "$CPU_THRESHOLD" ]; then
    echo "ALERT: High CPU usage - $CPU%" | tee -a "$LOGFILE"
fi

# --- Memory Usage ---
MEM=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100.0}')

echo "Memory Usage: $MEM%"

if [ "$MEM" -gt "$MEM_THRESHOLD" ]; then
    echo "ALERT: High Memory usage - $MEM%" | tee -a "$LOGFILE"
fi

# --- Disk Usage ---
DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Disk Usage: $DISK%"

if [ "$DISK" -gt "$DISK_THRESHOLD" ]; then
    echo "ALERT: High Disk usage - $DISK%" | tee -a "$LOGFILE"
fi

# --- Top 5 Processes by Memory ---
echo "Top 5 processes by memory:" | tee -a "$LOGFILE"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | tee -a "$LOGFILE"


