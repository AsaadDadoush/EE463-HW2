#!/bin/bash

## function: making an telephone list
## author: Asaad W. Daadouch
## Last update: 9/23/2022

if [ ! -d "/home/phonelist" ]
	then
		touch "/home/phonelist"
		chmod a+rwx "/home/phonelist"
fi

if [ $# -ge 1 ]
then
case "$1" in
"-a")
	if [ $# -ge 3 ]
	then
		echo "$2 $3" >> "/home/phonelist"
	fi;;
"-f")
	if [ $# -ge 2 ]
	then 
		grep -i "$2" "/home/phonelist"
	fi;;
"-r")

	if [ $# -ge 3 ]
	then
		grep -wv "$2" "/home/phonelist" > Value1 && grep -w "$2" "/home/phonelist" > Value2 
                sed -i "s/$2/$3/g" Value2
		cat Value1 > "/home/phonelist" && cat Value2 >> "/home/phonelist"
		rm Value1 Value2
    	fi;;
"-d")
	if [ $# -eq 3 ]
	then 
		grep -wv "$2 $3" "/home/phonelist" > Value
		cat Value > "/home/phonelist"
		rm Value

	elif [ $# -eq 2  ]
	then
		grep -wv "$2" "/home/phonelist" > Value
		cat Value > "/home/phonelist"
		rm Value
	fi;;
"-s")
	cat "/home/phonelist";;
esac
else cat "/home/phonelist"
fi
