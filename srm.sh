#!/bin/bash

## function: safe trash
## author : Asaad W. Daadouch
## last update: 23/9/2022


if [ ! -d "/home/trash" ]			
        then
                mkdir /home/trash		
                touch /home/trash/.srm		
                chmod a+rwx /home/trash/.srm	
        fi


case "$1" in  					
"-c") 
	Current_Time=$(date +%s);				 
	for file in /home/trash/*
	do
		if [ ! -e $file ]			
                then
                        echo "trash is empty"
                        break;
                fi

	        Modified_Time=$(date -r $file +%s);		
	        days=$((($Current_Time-$Modified_Time)/86400));	
		if [ "$days" -ge 60 ]
		then
			rm $file;
			grep -wv "$file" /home/trash/.srm > Log
                	cat Log > /home/trash/.srm
                	rm Log
		fi
	done;
	
	for i in ${@:2}
        do
		if [ ! -e $i ]
                then
                        echo "$i not exists"
                        continue;
                fi

                if echo "$i" | grep "/home" >> "/home/trash/.srm"
                then
                        touch -m -c "$i";    
                        mv $i /home/trash;
                else
                        echo "$PWD/$i" >> /home/trash/.srm               
                        touch -m -c "$i";    
                        mv $i home/trash;
                fi
        done;;
"-l")				
	ls "/home/trash";;	 

"-r")				
		if [ "$2" == "file*" ]        
	then
			for file in /home/trash/*
		do
			if [ ! -e $file ]  
                	then
                        	echo "trash is empty"
                        	break;		
                	fi
        	        file=$(echo $file | cut -d '/' -f 5-)
			n=2
        	        DIR=$(cat /home/trash/.srm | grep "$file")
        	        PA=$(echo $DIR | cut -d '/' -f -$n)
        	        while [ -d $PA ]
               		do
                		n=$(($n+1))
                	        PATH=$(echo $DIR | cut -d '/' -f -$n)
               		done	
               	 	PA=$(echo $DIR | cut -d '/' -f -$(($n-1)))
               		mv /home/trash/$file $PA
			
			grep -wv "$PA" /home/trash/.srm > Log
                        cat Log > /home/trash/.srm
                        rm Log
        	done	
	else		
		for i in ${@:2}
		do
			if [ ! -e /home/trash/$i ]  
                	then
                        	echo "$i not found"    
                        	continue;
                	fi

			n=2
			DIR=$(cat /home/trash/.srm | grep "$i")
			PA=$(echo $DIR | cut -d '/' -f -$n)
		
			while [ -d $PA ]
			do
        			n=$(($n+1))
        			PA=$(echo $DIR | cut -d '/' -f -$n)
			done
			PA=$(echo $DIR | cut -d '/' -f -$(($n-1)))
			mv /home/trash/$i $PA
			
			grep -wv "$PA" /home/trash/.srm > Log
                        cat Log > /home/trash/.srm
                        rm Log
		done
	fi
	;;

"-h")
        if [ "$2" == "file*" ]
        then
		if [ ! -e $file ]
                then
                	echo "trash is empty"
                        break;
                fi
        	mv "/home/trash/*" $PWD
	else
                for i in ${@:2}
                do
			if [ ! -e "/home/trash/$i" ]
                        then
                                echo "$i not exists"
                                continue;
                        fi

                	mv "/home/trash/$i" $PWD
                done
        fi
        ;;

*)
	for file in $*
	do
		if [ ! -e "$file" ]
                then
                        echo "$file not exists"
                	break;
                fi

		if echo "$file" | grep "/home" >> "/home/trash/.srm"
		then
                        touch -m -c "$file";	
			mv $file "/home/trash";
		else
			echo "$PWD/$file" >> "/home/trash/.srm"
                        touch -m -c "$file";	
			mv $file "/home/trash";
		fi
	done;;
esac
