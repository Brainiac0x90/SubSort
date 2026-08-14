#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
PURPLE="\e[95m"
CYAN="\e[36m"
YELLOW="\e[93m"
GREY="\e[90m"
ENDCOLOR="\e[0m"

if [ $# -eq 0 ]
then
echo -e "${RED}[XoX]${ENDCOLOR} Enter a URL & a Hostname."
echo -e "${PURPLE}[?]${ENDCOLOR} ./SubSort.sh www.example.com example"
else
cat art.txt
echo -e "Author: (${GREEN}@Brainiac0x90${ENDCOLOR})"
echo -e "${GREY}SubSort v1.0${ENDCOLOR}"
echo -e "\n"
mkdir $2 && cd $2 && wget $1 2> /dev/null && echo -e "${CYAN}Domain${ENDCOLOR} --> $2\n" && cat index.html | grep -i -oE "([a-z0-9-]+\\.)+$2\\.com" | sort -u | tail -n +2 | tee subd.txt
echo -e "\n"
echo -e "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo -e "\n"
for sub in $(cat subd.txt)
do
if  [[ $(ping -c 1 $sub) ]]
then
echo -e "[${GREEN}*${ENDCOLOR}]$sub ++++++++ ${GREEN}PONG!${ENDCOLOR}"
echo $sub >> valid.txt
else
echo -e "[${RED}*${ENDCOLOR}]${GREY}$sub${ENDCOLOR} -------- ${RED}MISSED:(${ENDCOLOR}"
fi
done
echo -e "\n"
echo -e "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo -e "\n"
for link in $(cat valid.txt)
do
  host "$link" | head -n 1 | tee -a subAliases.txt
done
echo -e "\n"
echo -e "[${GREEN}+${ENDCOLOR}]${CYAN}Resualts are saved.${ENDCOLOR}"
fi
