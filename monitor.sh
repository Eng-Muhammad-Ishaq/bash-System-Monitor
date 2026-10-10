#!/bin/bash

# Linux System Health Monitor
# My First Bash DevOps Project

echo "================================"
echo "    SYSTEM HEALTH MONITOR"
echo "================================"

# Display current date
echo "Date: $(date)"
echo ""

# Check CPU usage using two samples
cpu=$(top -bn2 -d 1 | grep '%Cpu(s)' | tail -1 | awk '{print int(100 - $8)}')

# Check RAM usage
ram=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

# Check disk usage
disk=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

# Display results
echo "CPU Usage: $cpu%"
echo "RAM Usage: $ram%"
echo "Disk Usage: $disk%"
echo ""

# Check system health
if [ "$cpu" -gt 80 ]; then
    echo "WARNING: High CPU Usage!"
else
    echo "CPU Status: OK"
fi

if [ "$ram" -gt 85 ]; then
    echo "WARNING: High RAM Usage!"
else
    echo "RAM Status: OK"
fi

if [ "$disk" -gt 90 ]; then
    echo "WARNING: Disk Almost Full!"
else
    echo "Disk Status: OK"
fi

echo "================================"

# Save report to a log file
{
    echo "Date: $(date)"
    echo "CPU: $cpu% | RAM: $ram% | Disk: $disk%"
    echo "--------------------------------"
} >> system_health.log

echo "Report saved to system_health.log"
