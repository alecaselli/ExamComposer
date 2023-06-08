#/!bin/sh

echo "Benvenuto nello script per la compilazione assistita dell'esame di Sistemi Operativi"
echo "Iniziamo subito!"

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

#leggo da standard input il numero di parametri richiesto dall'utente
P=0
echo "Quanti sono i parametri minimi richiesti?"
read P

#creo due file temporanei necessari per la gestione della sezione sul controllo del numero dei parametri
>/tmp/filetemp
>/tmp/modtemp

#stampo all'interno di modtemp, senza andare a capo, 0 in quanto i parametri non possono mai essere nulli
echo -n "0" >> /tmp/modtemp

#copio il contenuto del file componente "ctrlPar" dentro filetemp così da poterci lavorare senza rovinare l'originale
cat /home/cas/SO/ShellComposer/Componenti_shell/ctrlPar > /tmp/filetemp

i=1

#eseguo un ciclo che inserisca dentro il primo caso del case il numero corretto di parametri
while true
do
	if [ $i -eq $P ]
	then
		sed -i s/{parametri}/`cat /tmp/modtemp`/g /tmp/filetemp
		cat /tmp/filetemp >> FCP.sh
		break
	fi
	echo -n "|$i" >> /tmp/modtemp
	i=`expr $i + 1`
done

rm /tmp/modtemp

i=1
C=S

while true
do
	echo "Vuoi inserire un nuovo componente (Y/N)?"
	read C

	case $C in
		S|s|Y|y) echo "Inserire uno tra i seguenti componenti:"
			 cd /home/cas/SO/ShellComposer/Componenti_shell
			 ls
			 read C
			 if [ ! -f $C ]
			 then
				echo "$C non componente o scritto sbagliato"
				continue
			 fi
			 cat `pwd`/$C > /tmp/filetemp
			 sed -i s/{num}/'$'$i/g /tmp/filetemp
			 cd $target
			 cat < /tmp/filetemp >> FCP.sh
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
		 cat /home/cas/SO/ShellComposer/Componenti_shell/ctrlGer > /tmp/filetemp
		 sed -i s/{lettera}/$L/g /tmp/filetemp
		 cat < /tmp/filetemp >> FCP.sh
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

cat /home/cas/SO/ShellComposer/Componenti_shell/path >> FCP.sh
cat /home/cas/SO/ShellComposer/Componenti_shell/ricor >> FCR.sh

echo " " >> FCP.sh
echo '#Ricorda di rimuovere eventuali file temporanei e chiamare la parte C' >> FCP.sh

rm /tmp/filetemp

#cose da aggiungere
#nella parte del controllo del numero il range
#in ciascuna parte deve venire chiesta la lettera della prova
#rendere control par, path, ricor, invisibili con il . all'inizio
#aggiungere chiamata al file ricorsivo in base ai parametri inseriti

#CORREZIONE: gli shift sono necessari solo per i valori che si salvano

#IDEA: invece di copiare in happend dei file di testo creare degli script secondari che elaborino
#il loro specifico settore così da inserire lì direttamente la richiesta riguardo le lettere etc
