#!/bin/bash
# trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

set -eo pipefail

HELP_MESSAGE="Usage: `echo $0 | rev | awk -F '/' '{print $1}' | rev` -d [domain] -a [optional, skip amass] | anew all.subs\n"

# Check if tools are installed
function check_tools()
{
    if ! command -v github-subdomains >/dev/null 2>&1; then
        echo "github-subdomains is not installed"
        exit
    fi
    if ! command -v amass >/dev/null 2>&1; then
        echo "amass is not installed"
        exit
    fi
    if ! command -v subfinder >/dev/null 2>&1; then
        echo "subfinder is not installed"
        exit
    fi
    if ! command -v bbot >/dev/null 2>&1; then
        echo "bbot is not installed"
        exit
    fi
}

check_tools

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
    (
    github-subdomains -d $domain -raw -o /tmp/$domain-github-subdomains || >&2 echo -e "$Cross github-subdomains failed"\
    & amass enum -d $domain --passive --silent || >&2 echo -e "$Cross amass failed" \
    & subfinder -d $domain -all -recursive -silent || >&2 echo -e "$Cross subfinder failed" \
    ; bbot -t $domain -f subdomain-enum -rf passive -c modules.massdns.max_resolvers=5000 --output-module json --yes -s 2>/dev/null | jq -r 'select(.type=="DNS_NAME") | .data'
    )
    #& oneforall --target $domain --alive False --brute False --req False --fmt json --path /tmp/$domain-oneforall.json run &> /dev/null && wait && cat /tmp/$domain-oneforall.json | jq -r '.[] .subdomain' | awk '!a[$0]++'
else
    (
    github-subdomains -d $domain -raw -o /tmp/$domain-github-subdomains || >&2 echo -e "$Cross github-subdomains failed" \
    & subfinder -d $domain -all -recursive -silent || >&2 echo "$Cross github-subdomains failed"
    ; bbot -t $domain -f subdomain-enum -rf passive -c modules.massdns.max_resolvers=5000 --output-module json --yes -s 2>/dev/null | jq -r 'select(.type=="DNS_NAME") | .data'
    )
fi
#wait $!