#!/bin/bash

target=$1

cat .call > /tmp/fileTemp
sed -i s/{parametri}/"`cat /tmp/lettersTemp`"/i /tmp/fileTemp
cat /tmp/fileTemp >> $target/FCP.sh
