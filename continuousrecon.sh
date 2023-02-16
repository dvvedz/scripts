#!/bin/bash
Red='\033[0;31m'
Yellow='\033[0;33m'
Green='\033[0;32m'
Rst='\033[0m'
Cm='\xE2\x9C\x94'
Cross='✘'

if ! command -v notify >/dev/null; then
    >&2 printf "${Red}\t[${Cross}] notify not found, is it installed and in path?${Rst}\n"
    exit 1 
fi


while getopts 'hd:o:p' opt; do
    case $opt in
        h) print_help; exit 1 ;;
        d) domain=$OPTARG ;;
        o) outdir=$OPTARG ;;
        p) portscan="true" ;;
    esac
done

shift $(( OPTIND - 1 ))

if [ -z "$domain" ] || [ -z "$outdir" ]; then
    echo 'Missing -d or -o' >&2
    echo ''
    exit 1
fi

mkdir -p $outdir
mkdir -p $outdir/tmp

pushd $outdir > /dev/null
# Run subdomain discovery
subsh -d $domain | anew all.subs
puredns resolve all.subs -q -r ~/Hacking/wordlists/resolvers.txt | anew alive.subs | tee tmp/alive-new.subs

# run alts

altsh -d $domain -f `pwd`/all.subs -o alive.subs | tee tmp/alts-new.subs

# run portscanning
if [[ $portscan == "true" ]]; then
    naabu -list alive.subs -p - -exclude-ports 21,22,25,80,443 | anew all.ports | tee tmp/new.ports
fi

httpx -list alive.subs -title -td -sc -ip -srd outres | anew all.httpx | tee tmp/new.httpx

# Alert all new subdomains found

# REPORT
echo "=== REPORT ===" > report.txt
echo "=== New Alive Subdomains (`wc -l alive-new.subs | awk '{print $1}'`) ===" >> report.txt
cat tmp/alive-new.subs >> report.txt
echo "" >> report.txt

echo "=== New alive subdomains - alts (`wc -l alts-new.subs | awk '{print $1}'`) ===" >> report.txt
cat tmp/alts-new.subs >> report.txt
echo "" >> report.txt

echo "=== New alive ports (`wc -l new.ports | awk '{print $1}'`) ===" >> report.txt
cat tmp/new.ports >> report.txt
echo "" >> report.txt

echo "=== New probed hosts (`wc -l new.httpx | awk '{print $1}'`) ===" >> report.txt
cat tmp/new.httpx >> report.txt


notify -data report.txt -bulk

popd > /dev/null

# REPORT FILE TEMPLATE
# === New alive subdomains (3) ===
# sub1.target.com
# sub2.target.com
# sub3.target.com
 
# === New alive subdomains alts (2) ===
# admin-sub1.target.com
# panelsub1.target.com
 
# === New alive ports found (3) ===
# target.com:8088
# target.com:3000
# target.com:3444
 
# === New probed subdomains (8) ===
# https://target.com:8088 [title] [tech detect] [status code] [IP]
# https://target.com:3000 [title] [tech detect] [status code] [IP]
# https://target.com:3444 [title] [tech detect] [status code] [IP]
# https://admin-sub1.target.com [title] [tech detect] [status code] [IP]
# https://panelsub1.target.com [title] [tech detect] [status code] [IP]
# https://sub1.target.com [title] [tech detect] [status code] [IP]
# https://sub2.target.com [title] [tech detect] [status code] [IP]
# https://sub3.target.com [title] [tech detect] [status code] [IP]
# 
