#/!bin/bash

echo "Benvenuto nello script per la compilazione assistita dell'esame di Sistemi Operativi"
echo "Iniziamo subito!"

scriptPos=`pwd`

#mi posiziono all'interno della cartella creata dal curl
target=/home/`whoami`/Scrivania/studente*	#se la lingua impostata è inglese, sostituire "Scrivania" con "Desktop"
cd $target
target=`pwd`

cd $scriptPos/Componenti_shell

#creo i file FCP.sh e FCR.sh
>$target/FCP.sh
>$target/FCR.sh

#modifico le autorizzazioni per consentire l'esecuzione dei file
chmod a+x $target/FCP.sh $target/FCR.sh

#stampo lo shabang all'interno dei file
echo '#!/bin/sh' >> $target/FCP.sh
echo '#!/bin/sh' >> $target/FCR.sh

#creo un file temporaneo su cui appoggiarmi per copiare e modificare i singoli componenti
>/tmp/fileTemp
>/tmp/lettersTemp

#avvio lo script per la compilazione del case riguardante il numero dei parametri
bash .ctrlPar.sh $target

componente=(*)

i=1

while true
do
	echo "Vuoi inserire un nuovo componente (Y/N)?"
	read D

	case $D in
		S|s|Y|y) echo "Inserire uno tra i seguenti componenti:"
			 j=1
                         for cmp in ${componente[*]}
                         do
                                echo -n "$j.$cmp "
                                j=`expr $j + 1`
                         done
                         echo ""

                         read C

                         C=`expr $C - 1`

			 case $C in
			 *[!0-9]*) echo "$C non numero o non corretto"
				   continue ;;
			 *) if [ ${#componente[*]} -lt $C ]
			    then
				  echo "$C non disponibile"
				  continue
			    fi ;;
			 esac

                         bash ${componente["$C"]} $i $target

                         if [ $? -ne 0 ]
                         then
                                continue
                         fi

                         i=`expr $i + 1` ;;
		N|n) break ;;
	esac
done

echo " " >> $target/FCP.sh

while [ $i -ne 1 ]
do
	echo "shift" >> $target/FCP.sh
	i=`expr $i - 1`
done

echo "Vuoi inserire il controllo delle gerarchie (Y/N)?"
read G

case $G in
	S|s|Y|y) bash .ctrlGer.sh $target ;;
	N|n) ;;
esac

val=`grep -c "{exit num}" $target/FCP.sh`
val=`expr $val + 1`

j=1

while true
do
        if [ $j -eq $val ]
        then
                break
        fi
        sed -i -e "0,/{exit num}/ s/{exit num}/exit $j/" $target/FCP.sh
        j=`expr $j + 1`
done

cat .path >> $target/FCP.sh
bash .call.sh $target

cat .ricor >> $target/FCR.sh

echo " " >> $target/FCP.sh
echo '#Ricorda di rimuovere eventuali file temporanei e chiamare la parte C' >> $target/FCP.sh

rm /tmp/fileTemp
rm /tmp/lettersTemp

#CORREZIONE: controllare il valore del range nel caso 2 del ctrlNum
