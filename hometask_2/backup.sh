#!/usr/bin/env bash
source_dir='.'
backup_dir='.'/backup/backup_$(date +\%Y-\%m-\%d)
echo "Backup begin"
mkdir -p '.'/backup/backup_$(date +\%Y-\%m-\%d)  
find $source_dir -type f -mtime -1 -ls -exec cp -a "{}" $backup_dir \;
echo "Backup complited"