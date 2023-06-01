#!/bin/bash 
VHOST_BRUTE_LIST="~/Hacking/wordlists/OneListForAll/"
if [[ -p /dev/stdin ]]; then
    echo "stdin is coming from a pipe"
    while IFS= read -r line; do
        ffuf -H "Host: FUZZ.$DOMAIN" -c -w "" -u $URL
    done

elif [[ ! -z $1 ]]; then
    echo "coming from pos 1"
    

else 
    echo "no input"
fi

