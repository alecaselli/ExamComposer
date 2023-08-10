#!/bin/bash

#definisco shorcut per i colori e i font
#togliere 60 ai valori superiori al 90 per impostare i colori a basso contrasto
def='\033[0m'
orange='\033[33m\033[1m'
green='\033[32m\033[1m'
cyan='\033[96m\033[1m'
red='\033[31m\033[1m'

target=$1

echo -e "${orange}Che lettera vuoi utilizzare?${cyan}"
read L

cat .ctrlGer > /tmp/fileTemp
sed -i s/{lettera}/$L/g /tmp/fileTemp
cat < /tmp/fileTemp >> $target/FCP.sh

echo -e "${green}Controllo delle gerarchie inserito correttamente"

