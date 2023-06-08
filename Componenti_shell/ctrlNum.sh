#!/bin/sh

while true
do
	echo "Quale versione ti serve?"
	read V

	echo 1. Numero intero strettamente positivo
	echo 2. Numero compreso in un range

	case $V in
		1)
		2) echo "Inserisci il numero minimo accettato"
		   read L
		   #sostituire nel file ctrlRng il valore affianco a -lt con L
		*) echo "$V non numero o non corretto"
	esac
done
