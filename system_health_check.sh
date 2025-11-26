#! /bin/bash

#check system health

LOG_FILE=/home/soft/Documents/Projects/backups/system_health.log
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "== system health check : $DATE ==" >> "$LOG_FILE"

     #show the cpu #filter only cpuline #print the second #cut out text section remove % symbol leave only number get the first field
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "CPU Usage: ${CPU_USAGE}%" >> "$LOG_FILE"

                            #FORMAT TO TWO DECIMAL PLACES #used memory/totalmemory * 100= 50.00
MEMORY_USAGE=$(free | grep Mem | awk '{printf("%.2f"), $3/$2 * 100}')
echo "Memory_usage: ${MEMORY_USAGE}%" >> "$LOG_FILE"
                        #ROW number two #print 5th column
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
echo "Disk Usage: $DISK_USAGE" >> "$LOG_FILE"


echo "Check completed successfully" >> "$LOG_FILE"

echo "" >> "$LOG_FILE"





