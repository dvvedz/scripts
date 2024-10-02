#!/bin/bash

Red='\033[0;31m'
Yellow='\033[0;33m'
Green='\033[0;32m'
Rst='\033[0m'
Cm='\xE2\x9C\x94'
Cross='✘'

help() {
   echo "Usage of alt.sh:"
   echo -e "  -file        read apexes from file"
   echo -e "  -resolvers   read apexes from file"
}

while test $# -gt 0; do
   case "$1" in
      -file)
         shift
         file=$1
         shift
         ;;
      -resolvers)
         shift
         resolvers=$1
         shift
         ;;
      *)
         help
         exit 1
         ;;
   esac
done  

if [ -z "$file" ] || [ -z "$resolvers" ]; then
# file="/dev/stdin"
   help 
   exit 1
fi

if ! command -v gotator > /dev/null
then >&2 printf "${Red}[${Cross}] gotator not found, is it installed and in path?${Rst}\n"; fi

# Check if DIR exists

cleanup() {
   echo ""
   echo "Caught Ctrl+C. exiting.."
   pkill -P $$
   exit 1
}

trap cleanup SIGINT

if [[ $file == "~/"* ]] || [[ $file == "$HOME"* ]] ; then
    hosts_file=$file
else
    hosts_file=`pwd`/$file
fi

for apex in `cat subs.test | unfurl apexes | sort -u |  grep -vwE '\{3\}' | sed 's/^\.//' | awk NF`; do
   # echo "running regulator on $apex..."

   for i in {1..3}; do
       pushd ~/Hacking/tools/regulator > /dev/null

       python3 main.py $apex $hosts_file /tmp/$apex.rules

       ./make_brute_list.sh /tmp/$apex.rules /tmp/$apex.brute

       popd > /dev/null

       # cat /tmp/$domain.brute
       # puredns resolve -r $resolvers /tmp/$domain.brute # | anew $outfile | tee /tmp/$domain.valid.new

       # >&2 printf $Green"[$Cm] iteration ($i), found `wc -l /tmp/$domain.valid.new | awk '{print $1}'` new valid domains from regulator$Rst\n"
   done
done
