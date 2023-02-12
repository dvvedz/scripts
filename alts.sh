#!/bin/bash

Red='\033[0;31m'
Yellow='\033[0;33m'
Green='\033[0;32m'
Rst='\033[0m'
Cm='\xE2\x9C\x94'
Cross='✘'

function checktools()
{
    >&2 echo "[!] Checking Dependencies"
    REGULATOR_PATH="$HOME/Hacking/tools/regulator"

    if ! command -v aneww >/dev/null; then
        >&2 printf "${Red}\t[${Cross}] anew not found, is it installed and in path?${Rst}\n"
    else
        >&2 printf "${Green}\t[${Cm}] anew found\n"
    fi
    if ! command -v gotator >/dev/null; then 
        >&2 printf "${Red}\t[${Cross}] gotator not found, is it installed and in path?${Rst}\n"
    else
        >&2 printf "${Green}\t[${Cm}] gotator found\n"
    fi
    if [ ! -d $REGULATOR_PATH ]; then 
        >&2 printf "${Red}\t[${Cross}] regulator not found, is it installed at "$REGULATOR_PATH"${Rst}\n"
    else
        >&2 printf "${Green}\t[${Cm}] regulator found${Rst}\n"
    fi
    exit 1
}

function print_help()
{
    printf "Usage: `echo $0 | rev | awk -F '/' '{print $1}' | rev` -d [domain] -f [list of sub-domains] -o [save file]\n"
    printf "Flags:\n"
    printf "\t-h\tHelp Menu\n"
    printf "\t-i\tcheck if all the necessary tools are installed\n"
    printf "\t-d\ttakes a domain name (required)\n"
    printf "\t-f\ttakes a list of subdomains (required)\n"
    printf "\t-o\tpath to save file at (required)\n"
}

while getopts 'hid:f:o:' opt; do
    case $opt in
        h) print_help ;;
        i) checktools ;;
        d) domain=$OPTARG ;;
        f) file=$OPTARG ;;
        o) outfile=$OPTARG ;;
        ?) print_help; exit 1 ;;
        *) print_help; exit 1 ;;
    esac
done
shift $(( OPTIND - 1 ))

if [ -z "$domain" ] || [ -z "$file" ] || [ -z "$outfile" ]; then
    echo 'Missing -d or -f or -o' >&2
    echo ''
    print_help
    exit 1
fi

gotator -sub $file -perm ~/Hacking/wordlists/permutations-general.txt -depth 1 -adv > /tmp/$domain-perms.txt
printf "${Yellow}[i] generated `wc -l /tmp/$domain-perms.txt | awk '{print $1}'` permutations${Rst}\n"

cat /tmp/$domain-perms.txt | puredns resolve -r ~/Hacking/wordlists/resolvers.txt | anew $outfile > /tmp/$domain.gotator-new
>&2 printf "${Green}[$Cm] found `wc -l /tmp/$domain.gotator-new | awk '{print $1}'` new valid domains from gotator$Rst\n"

current_dir=`pwd`


for i in {1..3}; do
    pushd ~/Hacking/tools/regulator > /dev/null
    python3 main.py $domain $file /tmp/$domain.rules
    ./make_brute_list.sh /tmp/$domain.rules /tmp/$domain.brute
    popd > /dev/null
    puredns resolve /tmp/$domain.brute -r ~/Hacking/wordlists/resolvers.txt -q | anew $outfile > /tmp/$domain.valid.new

    >&2 printf $Green"[$Cm] iteration ($i), found `wc -l /tmp/$domain.valid.new | awk '{print $1}'` new valid domains from regulator$Rst\n"
done

