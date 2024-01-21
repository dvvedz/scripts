#!/bin/bash

while read -r line; do
  result=$(echo "$line" | sed 's/\(.*\)\.[^.]*\.[^.]*$/\1/')
 
  echo $result
done < /dev/stdin | sort -u
