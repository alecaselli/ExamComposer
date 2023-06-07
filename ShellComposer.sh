#/!bin/sh

if [ $# -lt 2 ]
then
	echo "ERRORE, necessari almeno due parametri: 1.Directory di destinazione poi"
	exit 1
fi

case $1 in
	/*) if [ ! -d $1 -o ! -x $1 ]
	then
		echo ERR, $1 non directory o non traversabile
		exit 2
	fi ;;
	*) echo ERR, $1 non nome assoluto
	exit 3 ;;
esac
D=$1
shift

cd $D

> FCP.sh
> tmp

echo '#!/bin/sh' >> FCP.sh

j=1

for i in $*
do
	cat /home/cas/SO/Componenti_shell/$i > tmp
	sed -i s/{num}/'$'$j/g tmp
	cat < tmp >> FCP.sh
	j=`expr $j + 1`
done

val=`grep -c "{exit num}" FCP.sh`
val=`expr $val + 1`

rm tmp
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

echo '#Ricorda di rimuovere eventuali file temporanei e chiamare la parte C' >> FCP.sh

chmod a+x FCP.sh

#cose da aggiungere
#sistema interattivo con S e N
#nella parte del numero variabile di parametri deve chiedere quanti ne vuole
#nella parte del controllo del numero il range
#in ciascuna parte deve venire chiesta la lettera della prova
#da FCPComposer ed FCRComposer a ShellComposer come creazione direttamente di entrambi i file
#e impostazione dei diritti per l'esecuzione
#aggiungere sistema che shifti tante volte quanti i parametri salvati con i nomi richiesti

#BUG: il ciclo per la sostituzione dei $num parte da 2 perché il primo è sempre il conteggio dei parametri
