#!/bin/bash

## fucntion : template of messages for many users
## last update : 9/23/2022
## autor : Asaad W. Daadouch

if [ ! -e $1 ] 
	then
		echo "Error $1 dosen't exists"
		exit 0;
elif [ ! -e $3 ]
	then 
		echo "Error $3 dosen't exists"
		exit 0;
fi

while read line
do 
	echo -e "from: Asaad \t\t Date: $(date +'%D')" > "letter-to-$line"
	echo -e "To: $line " >> "letter-to-$line"
	cat $1 >> "letter-to-$line"
	sed -i "s/$2/$line/g" "letter-to-$line"

done < "$3"
