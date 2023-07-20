#!/bin/bash
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

HELP_MESSAGE="Usage: `echo $0 | rev | awk -F '/' '{print $1}' | rev` -d [domain] -a [optional, skip amass] | anew all.subs\n"

function print_help()
{
    echo $HELP_MESSAGE 
    printf "\tFlags:\n"
    printf "\t-h Help Menu\n"
    printf "\t-d takes a domain name\t(required)\n"
    printf "\t-s skip amass\t\t(optional)\n"
}

while getopts 'hsd:' opt; do
    case $opt in
        d) domain=$OPTARG ;;
        h) print_help; exit ;;
        s) long="false" ;;
        ?) print_help; exit 1 ;;
        *) print_help; exit 1 ;;
    esac
done

shift $(( OPTIND - 1 ))

if [ -z "$domain" ]; then
    echo 'Missing -d'
    print_help
    exit 1
fi

if [[ $long != "false" ]]; then 
    github-subdomains -d $domain -raw -o /tmp/$domain-github-subdomains || >&2 echo -e "$Cross github-subdomains failed"\
    & amass enum -d $domain --passive --silent || >&2 echo -e "$Cross amass failed" \
    & subfinder -d $domain -all -recursive -silent || >&2 echo -e "$Cross subfinder failed" \
    & bbot -t $domain -f subdomain-enum -rf passive -c modules.massdns.max_resolvers=5000 --output-module json --yes -s | jq -r 'select(.type=="DNS_NAME") | .data'
    #& oneforall --target $domain --alive False --brute False --req False --fmt json --path /tmp/$domain-oneforall.json run &> /dev/null && wait && cat /tmp/$domain-oneforall.json | jq -r '.[] .subdomain' | awk '!a[$0]++'
else
    github-subdomains -d $domain -raw -o /tmp/$domain-github-subdomains || >&2 echo -e "$Cross github-subdomains failed" \
    & subfinder -d $domain -all -recursive -silent || >&2 echo "$Cross github-subdomains failed" \
    #& oneforall --target $domain --alive False --brute False --req False --fmt json --path /tmp/$domain-oneforall.json run &> /dev/null && wait && cat /tmp/$domain-oneforall.json | jq -r '.[] .subdomain' | awk '!a[$0]++'
fi
#wait $!