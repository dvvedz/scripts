#!/bin/bash

while read -r line; do
  rmTld="${line%.*}"
  echo $rmTld | sed -e 's/\./\n/g' -e 's/\-/\n/g' -e 's/[0-9]*//g'
done < /dev/stdin

