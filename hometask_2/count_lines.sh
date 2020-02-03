#!/usr/bin/env bash
file="versions.txt"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "$file not found. Downloading..."
    wget 'http://yoko.ukrtux.com:8899/versions.txt'
fi
echo "Most repeated lines:"
sort versions.txt | uniq -c | sort -rn | head -n 1