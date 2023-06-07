#/!bin/sh

if [ $# -lt 2 ]
then
	echo ERR, necessari almeno 2 parametri
	exit 1
fi

case $1 in
	/*) if [ ! -d $1 -o ! -x $1 ]
	then
		echo ERR, non directory o non traversabile
		exit 2
	fi ;;
	*) echo ERR, non nome assoluto
	exit 3 ;;
esac
D=$1
shift

cd $D

> FCR.sh

echo '#!/bin/sh' >> FCR.sh

for i in $*
do
	cat /home/casos/Componenti_shell/$i >> FCR.sh
done

chmod a+x FCR.sh
