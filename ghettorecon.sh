#!/bin/bash

set -eo pipefail

Red='\033[0;31m'
Yellow='\033[0;33m'
Green='\033[0;32m'
Rst='\033[0m'
Cm='\xE2\x9C\x94'
Cross='✘'

function help {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    exit 1
}

if ! command -v subsh >/dev/null 2>&1; then
    echo "subsh is not installed"
    exit
fi

# Check if no arguments are provided
if [[ -t 0 ]] && [[ -z $1 ]]; then
    echo "no input"
    exit
fi


# Check if a command-line argument is provided
if [[ -n $1 ]]; then
    input="$1"
else
    input="/dev/stdin"
fi

# Loop through each line of the input
TMPFILES=".tmpfiles"
ALLSUBS="all.subs"
RESOLVERS="/tmp/resolvers.txt"
BRUTE_WORDLIST="~/Hacking/wordlists/assetnotes/best-dns-wordlist.txt"

mkdir -p $TMPFILES

##### SUBDOMAIN SCRAPING 

while IFS= read -r line
do
    subsh -d $line -s | anew all.subs
done < "$input"

curl -s 'https://public-dns.info/nameservers.txt' > $RESOLVERS

puredns resolve $ALLSUBS --write $TMPFILES/all.subs-valid \
    --write-wildcards $TMPFILES/wildcards.txt -r $RESOLVERS &> /dev/null

cat $TMPFILES/all.subs-valid | anew all.subs-valid | tee $TMPFILES/subsh-valid-new.subs
cat $TMPFILES/wildcards.txt | anew wildcards.txt | tee $TMPFILES/wildcards-new.txt

# Calculate differences between runs 
printf "$Yellow[i] Found `wc -l $TMPFILES/subsh-valid-new.subs | awk '{print $1}'` more valid unique subdomains using subsh, total: `wc -l all.subs-valid | awk '{print $1}'`$Rst\n" >&2

##### BRUTE FORCE wildcards

for domain in `cat wildcards.txt`; do puredns bruteforce $BRUTE_WORDLIST -r $RESOLVERS $domain; done

##### PORT SCANNING

naabu -list all.subs-valid -p - -exclude-ports 21,22,25,80,443 | anew all.naabu | tee $TMPFILES/new.naabu

printf "$Yellow[i] Found `wc -l $TMPFILES/new.naabu | awk '{print $1}'` new open ports, total: `wc -l all.naabu | awk '{print $1}'`$Rst\n"
