#!/bin/bash

# Before running:
# export WHOXY_API_KEY=<your api key>

set -eo pipefail

# Function to show help
function help {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "-n, --name <name>         Registrant name"
    echo "-e, --email <email>       Registrant email"
    echo "-c, --company <company>   Registrant company"
    echo "-k, --keyword <keyword>   Keyword contained in the domain name"
    exit 1
}

# Check if no arguments are provided
if [[ $# -eq 0 ]]; then
    help
fi

# Check if the API key is set
if [[ ! "$WHOXY_API_KEY" ]]; then
    echo "WHOXY_API_KEY is not set"
    exit 1
fi

KEY=""
VALUE=""
MODE="micro"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -n|--name)
        KEY="name"
        VALUE="$2"
        shift
        shift
        ;;
        -e|--email)
        KEY="email"
        VALUE="$2"
        shift
        shift
        ;;
        -c|--company)
        KEY="company"
        VALUE="$2"
        shift
        shift
        ;;
        -k|--keyword)
        KEY="keyword"
        VALUE="$2"
        MODE="domains"
        shift
        shift
        ;;
        *)
        help
        ;;
    esac
done

if [[ -z "$KEY" ]]; then
    echo "No argumnet provided"
    exit 1
fi

# URL-encode query
VALUE=$(printf %s "$VALUE" | jq -sRr @uri)

# Get the pages of results
page=1
while : ; do
    response=$(curl -s "https://api.whoxy.com/?key=$WHOXY_API_KEY&reverse=whois&$KEY=$VALUE&mode=$MODE&page=$page")

    if [[ "$MODE" == "domains" ]]; then
        if ! echo "$response" | jq -r '.domain_names' 2>/dev/null | sed 's/, /\n/g'; then
            break
        fi
    else
        if ! echo "$response" | jq -r '.search_result[] .domain_name' 2>/dev/null; then
            break
        fi
    fi

    total_pages=$(echo "$response" | jq -r '.total_pages')
    if [[ $page -ge $total_pages ]]; then
        break
    fi
    page=$((page+1))
done