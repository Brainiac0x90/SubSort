#!/bin/bash
RD="\e[31m"
GRN="\e[38;5;46m"
BL="\e[34m"
PPL="\e[95m"
CYN="\e[36m"
YLW="\e[93m"
GRY="\e[90m"
ENDC="\e[0m"

if [ $# -eq 0 ]
  then
    echo -e "${RD}[X_X]${ENDC} Enter a URL..."
    echo -e "${PPL}[?]${ENDC} ./SubSort.sh www.example.com"
  else
    Domain=$(printf '%s\n' "$1" | awk -F. '{print $2}')
    TLD=$(printf '%s\n' "$1" | awk -F. '{print $3}')
    cat art.txt
    echo -e "Author: (${GRN}@Brainiac0x90${ENDC})"
    echo -e "${GRY}Version: SubSort v2.0${ENDC}"
    echo -e "\n"
    mkdir -p "$Domain" &&
    cd "$Domain" || exit 1

    wget -q "$1" -O index.html 2>/dev/null || exit 1

    echo -e "${CYN}Domain${ENDC} --> $Domain\n"
    
    echo -e "[${CYN}*${ENDC}] Searching in Homepage..."
    
    grep -a -i -oE "([a-z0-9-]+\.)+${Domain}\.$TLD" index.html | sort -u > subd.txt

   echo -e "[${CYN}*${ENDC}] Searching in Certkit..."

   curl -s "https://ct.certkit.io/search?domain=${Domain}.${TLD}" \
     | jq -r '.results[]?.dnsNames[]?' \
     | grep -oE "([a-zA-Z0-9-]+\.)+${Domain}\.$TLD" \
     | sort -u >> subd.txt
     
    sort -u subd.txt -o subd.txt
    cat subd.txt
    
    echo -e "\n"
    echo -e "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
    echo -e "\n"
  for sub in $(cat subd.txt)
    do
      if  [[ $(ping -c 1 $sub) ]]
        then
          echo -e "[${GRN}*${ENDC}]$sub ++++++++ ${GRN}PONG!${ENDC}"
          echo $sub >> valid.txt
      else
        echo -e "[${RD}*${ENDC}]${GRY}$sub${ENDC} -------- ${RD}MISSED:(${ENDC}"
      fi
  done
  echo -e "\n"
  echo -e "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
  echo -e "\n"
  for link in $(cat valid.txt)
    do
      host "$link" | head -n 1 | tee -a subhosts.txt
  done
  echo -e "\n"
  echo -e "[${GRN}+${ENDC}]${CYN}Resualts are saved.${ENDC}"
fi
