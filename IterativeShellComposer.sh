#/!bin/sh

echo "Benvenuto nello script per la compilazione assistita dell'esame di Sistemi Operativi"
echo "Iniziamo subito!"

scriptPos=`pwd`

#mi posiziono all'interno della cartella creata dal curl
target=/home/`whoami`/Scrivania/studente*	#se la lingua impostata è inglese, sostituire "Scrivania" con "Desktop"
cd $target

#creo i file FCP.sh e FCR.sh
>FCP.sh
>FCR.sh

#modifico le autorizzazioni per consentire l'esecuzione dei file
chmod a+x FCP.sh
chmod a+x FCR.sh

#stampo lo shabang all'interno dei file
echo '#!/bin/sh' >> FCP.sh
echo '#!/bin/sh' >> FCR.sh

#creo un file temporaneo su cui appoggiarmi per copiare e modificare i singoli componenti
>/tmp/fileTemp

#avvio lo script per la compilazione del case riguardante il numero dei parametri
sh $scriptPos/Componenti_shell/ctrlPar $scriptPos

i=1
while true
do
	echo "Vuoi inserire un nuovo componente (Y/N)?"
	read C

	case $C in
		S|s|Y|y) echo "Inserire uno tra i seguenti componenti:"
			 cd $scriptPos/Componenti_shell
			 ls
			 read C
			 if [ ! -f $C ]
			 then
				echo "$C non componente o scritto sbagliato"
				continue
			 fi
			 cat `pwd`/$C > /tmp/fileTemp
			 sed -i s/{num}/'$'$i/g /tmp/fileTemp
			 cd $target
			 cat < /tmp/fileTemp >> FCP.sh
			 i=`expr $i + 1`
			 echo "Componente $C inserita correttamente" ;;
		N|n) break ;;
	esac
done

echo " " >> FCP.sh

while [ $i -ne 1 ]
do
	echo "shift" >> FCP.sh
	i=`expr $i - 1`
done

echo "Vuoi inserire il controllo delle gerarchie (Y/N)?"
read C
case $C in
	S|s|Y|y) echo "Che lettera vuoi utilizzare?"
		 read L
		 cat $scriptPos/Componenti_shell/.ctrlGer > /tmp/fileTemp
		 sed -i s/{lettera}/$L/g /tmp/fileTemp
		 cat < /tmp/fileTemp >> FCP.sh
		 echo "Controllo delle gerarchie inserito correttamente" ;;
	N|n) ;;
esac

val=`grep -c "{exit num}" FCP.sh`
val=`expr $val + 1`

j=1

while true
do
        if [ $j -eq $val ]
        then
                break
        fi
        sed -i -e "0,/{exit num}/ s/{exit num}/exit $j/" FCP.sh
        j=`expr $j + 1`
done

cat $scriptPos/Componenti_shell/.path >> FCP.sh
cat $scriptPos/Componenti_shell/.ricor >> FCR.sh

echo " " >> FCP.sh
echo '#Ricorda di rimuovere eventuali file temporanei e chiamare la parte C' >> FCP.sh

rm /tmp/fileTemp

#cose da aggiungere
#nella parte del controllo del numero il range
#in ciascuna parte deve venire chiesta la lettera della prova
#rendere control par, path, ricor, invisibili con il . all'inizio
#aggiungere chiamata al file ricorsivo in base ai parametri inseriti

#CORREZIONE: gli shift sono necessari solo per i valori che si salvano

#IDEA: invece di copiare in happend dei file di testo creare degli script secondari che elaborino
#il loro specifico settore così da inserire lì direttamente la richiesta riguardo le lettere etc
