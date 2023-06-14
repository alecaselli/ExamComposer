#!/bin/bash

target=$1

echo "Che lettera vuoi utilizzare?"
read L

cat .ctrlGer > /tmp/fileTemp
sed -i s/{lettera}/$L/g /tmp/fileTemp
cat < /tmp/fileTemp >> $target/FCP.sh

echo "Controllo delle gerarchie inserito correttamente"

