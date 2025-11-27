#!/bin/bash

SOURCE_DIR="/home/soft/Documents/soft/file"
BACKUP_DIR="/home/soft/Documents/Projects/backups/"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_$DATE.tar.gz"
LOG_FILE=/home/soft/Documents/Projects/backups/system_health.log
RETENTION_DAYS=7

if [ ! -d "$SOURCE_DIR" ]; then

        echo "Error: source directory does not exist: $SOURCE_DIR"
        exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
    #-p create parent directory too if needed
    mkdir -p "$BACKUP_DIR"
    echo "created backup directory: $BACKUP_DIR"
fi

#start backup
echo "starting backup of $SOURCE_DIR"

#compress file #where to save backup  #what to backup
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR" 2>/dev/null

#checking if backup was successful 0 is success 1 is failed
if [ $? -eq 0 ]; then
    echo "Backup completed successfully: $BACKUP_NAME"
    echo "Location: $BACKUP_DIR/$BACKUP_NAME" >> "$LOG_FILE"
else
    echo "Error: Backup failed" >> "$LOG_FILE"
    exit 1
fi
echo "Backup Completed finished"

#remove old backups

echo "cleaning up backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -name "backup_*.tar.gz" -type f -mtime +$RETENTION_DAYS -delete

echo "Backup process finished"






