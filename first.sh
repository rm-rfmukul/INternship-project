#!/bin/bash




clear 

echo "Press 1 for create the directory"  	
select data in 1 
do 
	if [ "$data" == 1 ];
	then

	echo "Enter directory name"
	read dirname

	if [ ! -d "$dirname" ]
	then
    		echo "Directory doesn't exist. Creating now"
    		mkdir ./$dirname
    		echo "Directory created"
	else
   		 echo "Directory exists"
		 
	fi
	fi 
	
done
 
