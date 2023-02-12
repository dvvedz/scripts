#!/bin/bash
trap "exit" INT TERM 
trap "kill 0" EXIT 

Cross='\xE2\x9D\x8C'

HELP_MESSAGE="Usage: $0 [domain] | anew all.subs"
if [ -z "$1" ]; then
    echo -e $HELP_MESSAGE
    echo ""
    echo -e "${Cross}\tmissing domain argument at postion \$1"
    exit 1
fi

github-subdomains -d $1 -raw -o /tmp/$1-github-subdomains \
& amass enum -d $1 --passive --silent \
& subfinder -d $1 -all -recursive -silent \
& oneforall --target $1 --alive False --brute False --req False --fmt json --path /tmp/$1-oneforall.json run &> /dev/null && wait && cat /tmp/$1-oneforall.json | jq -r '.[] .subdomain' | uniq
