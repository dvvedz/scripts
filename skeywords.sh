#!/bin/bash

while read -r line; do
  echo $line | sed -e 's/\./\n/g' -e 's/\-/\n/g' -e 's/[0-9]*//g'
done < /dev/stdin | sort -u 

