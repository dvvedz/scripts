#!/bin/bash

HELP_MESSAGE="Usage: $0 [org name] | anew roots.txt"
if [ -z "$1" ]; then
    echo ""
    echo -e $HELP_MESSAGE
    echo -e "${Cross}\tmissing org name argument at postion \$1"
    echo ""
    exit 1
fi

curl -s "https://crt.sh/?O=$1&output=json" | jq -r '.[] .common_name' | uniq | unfurl -u apexes

