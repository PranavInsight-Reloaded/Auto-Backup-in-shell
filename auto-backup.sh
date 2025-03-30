#!/bin/bash

# Ask for the folder to back up
echo "Enter the full path of the folder you want to back up (e.g., /home/user/Documents):"
read -r SOURCE_FOLDER

# Check if the source folder exists
if [ ! -d "$SOURCE_FOLDER" ]; then
    echo "❌ Error: The folder '$SOURCE_FOLDER' does not exist!"
    exit 1
fi

# Ask for the destination folder for the backup
echo "Enter the full path where you want to store the backup (e.g., /home/user/Backups):"
read -r DEST_FOLDER

# Check if the destination folder exists, if not, create it
if [ ! -d "$DEST_FOLDER" ]; then
    echo "❌ The destination folder does not exist. Creating '$DEST_FOLDER'."
    mkdir -p "$DEST_FOLDER"
fi

# Set PC name and formatted date
PC_NAME=$(hostname)
DATE=$(date +'%d-%m-%y')

# Define the backup file name
BACKUP_NAME="$PC_NAME-Backup file $DATE - auto-backup.tar.gz"

# Get the size of the source folder for progress bar
SIZE=$(du -sb "$SOURCE_FOLDER" | awk '{print $1}')

# Show progress while creating the backup
echo "Starting backup of $SOURCE_FOLDER to $DEST_FOLDER/$BACKUP_NAME..."

# Create the backup with progress bar using `tar` and `pv`
tar -cf - "$SOURCE_FOLDER" | pv -s "$SIZE" | gzip > "$DEST_FOLDER/$BACKUP_NAME"

# Confirmation message
echo "✅ Yay! Backup completed and saved as: $DEST_FOLDER/$BACKUP_NAME"
echo "Play it safe! You can use this backup file in any emergency situation..."



