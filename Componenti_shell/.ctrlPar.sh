#/!bin/bash

#definisco shorcut per i colori e i font
#togliere 60 ai valori superiori al 90 per impostare i colori a basso contrasto
def='\033[0m'
orange='\033[33m\033[1m'
green='\033[32m\033[1m'
cyan='\033[96m\033[1m'
red='\033[31m\033[1m'

target=$1

while true
do
        #leggo da standard input il numero di parametri richiesto dall'utente
        echo -e "${orange}Quanti sono i parametri minimi richiesti?${cyan}"
        read P
        
        case $P in
        *[!0-9]*) echo -e "${red}$P non numero o non corretto"
		  continue ;;
	*) break ;;
	esac
done

#creo un file temporaneo ulteriore dove inserire il numero di parametri da inserire nel case
>/tmp/modTemp

#stampo all'interno di modtemp, senza andare a capo, 0 in quanto i parametri minimi non sono mai 0
echo -n "0" >> /tmp/modTemp

#copio il contenuto del file componente "ctrlPar" dentro filetemp così da poterlo modificare
cat .ctrlPar > /tmp/fileTemp

i=1

#eseguo un ciclo che inserisca dentro il primo caso del case il numero corretto di numeri
while true
do
        if [ $i -eq $P ]
        then
                sed -i s/{parametri}/`cat /tmp/modTemp`/g /tmp/fileTemp
                cat /tmp/fileTemp >> $target/FCP.sh
                break
        fi
        echo -n "|$i" >> /tmp/modTemp
        i=`expr $i + 1`
done

#rimuovo il file temporaneo
rm /tmp/modTemp
