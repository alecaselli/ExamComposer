
#controllo il numero dei parametri
case $# in
	0|1|2|3|4) echo ERRORE, numero parametri $#, insufficiente
		 {exit num} ;;
	*) echo DEBUG-OK: da qui in poi proseguiamo con $# parametri ;;
esac
