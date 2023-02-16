#!/bin/bash
trap "pkill -P $$"  EXIT
Cross='\xE2\x9D\x8C'

HELP_MESSAGE="Usage: $0 -d [domain] -a [optional, skip amass] | anew all.subs\n"
if [ -z "$1" ]; then
    echo -e $HELP_MESSAGE
    echo ""
    echo -e "${Cross}\tmissing domain argument at postion \$1"
    exit 1
fi

while getopts 'had:' opt; do
    case $opt in
        d) domain=$OPTARG ;;
        h) echo -e $HELP_MESSAGE; exit ;;
        a) amass="false" ;;
        ?) $HELP_MESSAGE; exit 1 ;;
        *) $HELP_MESSAGE; exit 1 ;;
    esac
done
shift $(( OPTIND - 1 ))

if [ -z "$domain" ]; then
    echo 'Missing -d' >&2
    echo ''
    echo $HELP_MESSAGE 
    exit 1
fi

if [[ $amass != "false" ]]; then 
    github-subdomains -d $domain -raw -o /tmp/$domain-github-subdomains \
    & amass enum -d $domain --passive --silent \
    & subfinder -d $domain -all -recursive -silent \
    & oneforall --target $domain --alive False --brute False --req False --fmt json --path /tmp/$domain-oneforall.json run &> /dev/null && wait && cat /tmp/$domain-oneforall.json | jq -r '.[] .subdomain' | uniq

else
    github-subdomains -d $domain -raw -o /tmp/$domain-github-subdomains \
    & subfinder -d $domain -all -recursive -silent \
    & oneforall --target $domain --alive False --brute False --req False --fmt json --path /tmp/$domain-oneforall.json run &> /dev/null && wait && cat /tmp/$domain-oneforall.json | jq -r '.[] .subdomain' | uniq
fi
