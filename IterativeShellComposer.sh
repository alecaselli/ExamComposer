#/!bin/sh

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

#avvio lo script per la compilazione del case riguardante il numero dei parametri
sh .ctrlPar.sh $target

i=1
while true
do
	echo "Vuoi inserire un nuovo componente (Y/N)?"
	read C

	case $C in
		S|s|Y|y) echo "Inserire uno tra i seguenti componenti:"
			 ls

			 read C
			 if [ ! -f $C ]
			 then
				echo "$C non componente o scritto sbagliato"
				continue
			 fi

			 sh $C $i $target

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
	S|s|Y|y) sh .ctrlGer.sh $target ;;
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
cat .ricor >> $target/FCR.sh

echo " " >> $target/FCP.sh
echo '#Ricorda di rimuovere eventuali file temporanei e chiamare la parte C' >> $target/FCP.sh

rm /tmp/fileTemp

#cose da aggiungere
#nella parte del controllo del numero il range
#in ciascuna parte deve venire chiesta la lettera della prova
#rendere control par, path, ricor, invisibili con il . all'inizio
#aggiungere chiamata al file ricorsivo in base ai parametri inseriti

#CORREZIONE: gli shift sono necessari solo per i valori che si salvano

#IDEA: invece di copiare in happend dei file di testo creare degli script secondari che elaborino
#il loro specifico settore così da inserire lì direttamente la richiesta riguardo le lettere etc
