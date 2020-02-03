#!/usr/bin/env bash
echo "Port scanning:"
for ip in 192.168.0.{0..255}
do
nc -z -w 1 -v $ip 80 2>&1 | grep succeeded
nc -z -w 1 -v $ip 443 2>&1 | grep succeeded
done
