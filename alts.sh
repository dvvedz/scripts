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
    PERMS_PATH="$HOME/Hacking/wordlists/permutations-general.txt"
    
    RESOLVERS_PATH="$HOME/Hacking/wordlists/permutations-general.txt"

    if ! command -v puredns >/dev/null; then
        >&2 printf "${Red}\t[${Cross}] puredns not found, is it installed and in path?${Rst}\n"
    else
        >&2 printf "${Green}\t[${Cm}] puredns\tfound\n"
    fi

    if ! command -v anew >/dev/null; then
        >&2 printf "${Red}\t[${Cross}] anew not found, is it installed and in path?${Rst}\n"
    else
        >&2 printf "${Green}\t[${Cm}] anew\tfound\n"
    fi

    if ! command -v gotator >/dev/null; then 
        >&2 printf "${Red}\t[${Cross}] gotator not found, is it installed and in path?${Rst}\n"
    else
        >&2 printf "${Green}\t[${Cm}] gotator\tfound\n"
    fi

    if [ ! -d $REGULATOR_PATH ]; then 
        >&2 printf "${Red}\t[${Cross}] regulator not found, is it installed at "$REGULATOR_PATH"${Rst}\n"
    else
        >&2 printf "${Green}\t[${Cm}] regulator\tfound${Rst}\n"
    fi

    if [ ! -f $PERMS_PATH ] && [ ! -f $RESOLVERS_PATH ]; then 
        >&2 printf "${Red}\t[${Cross}] files not found:\ncheck that these files exists in the following paths:\
        $PERMS_PATH, $RESOLVERS_PATH{Rst}\n"
    else
        >&2 printf "${Green}\t[${Cm}] files\tfound${Rst}\n"
    fi
    exit 1
}

function print_help()
{
    printf "Usage: `echo $0 | rev | awk -F '/' '{print $1}' | rev` -d [domain] -f [list of sub-domains] -o [save file]\n"
    printf "Flags:\n"
    printf "\t-h Help Menu\n"
    printf "\t-i check if all the necessary tools are installed\n"
    printf "\t-d takes a domain name\t\t(required)\n"
    printf "\t-f takes a list of subdomains\t(required)\n"
    printf "\t-o path to save file at\t\t(required)\n"
}

while getopts 'hid:f:o:' opt; do
    case $opt in
        h) print_help; exit ;;
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

gotator -sub $file -perm $PERMS_PATH -depth 1 -adv > /tmp/$domain-perms.txt
>&2 printf "${Yellow}[i] generated `wc -l /tmp/$domain-perms.txt | awk '{print $1}'` permutations${Rst}\n"

cat /tmp/$domain-perms.txt | puredns resolve -r ~/Hacking/wordlists/resolvers.txt | anew $outfile | tee /tmp/$domain.gotator-new
>&2 printf "${Green}[$Cm] found `wc -l /tmp/$domain.gotator-new | awk '{print $1}'` new valid domains from gotator$Rst\n"


for i in {1..3}; do
    pushd ~/Hacking/tools/regulator > /dev/null
    python3 main.py $domain $file /tmp/$domain.rules

    ./make_brute_list.sh /tmp/$domain.rules /tmp/$domain.brute

    popd > /dev/null

    puredns resolve /tmp/$domain.brute -r ~/Hacking/wordlists/resolvers.txt -q | anew $outfile | tee /tmp/$domain.valid.new

    >&2 printf $Green"[$Cm] iteration ($i), found `wc -l /tmp/$domain.valid.new | awk '{print $1}'` new valid domains from regulator$Rst\n"
done

