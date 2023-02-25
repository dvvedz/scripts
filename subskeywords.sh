#!/bin/bash

while read -r line; do
  echo $line | awk -F "." '{print $1}' | awk -F '-' '{print $0"\n"$1"\n"$2"\n"$3"\n"$4"\n"$5}' 
done < /dev/stdin | sort -u | tail -n +2

