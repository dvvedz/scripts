#!/bin/bash
if [ -z "$1" ]; then
    printf "missing argument, example ./$0 [domain]\n"
    exit 1
fi

RESOLVERS="~/Hacking/wordlists/resolvers.txt"
curl -s 'https://public-dns.info/nameservers.txt' > $RESOLVERS

puredns resolve $1 -r $RESOLVERS --write-wildcards wildcards.txt -q