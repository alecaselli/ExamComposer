#/!bin/bash

target=$1

#creo un file temporaneo ulteriore dove inserire il numero di parametri da inserire nel case
>/tmp/modTemp

#leggo da standard input il numero di parametri richiesto dall'utente
echo "Quanti sono i parametri minimi richiesti?"
read P

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
