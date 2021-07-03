#!/bin/bash




 

<<<<<<< HEAD
echo "Press 1 for create a directory" 
echo "press 2 for create a file"
echo "press 3 for install a package"
echo "press 4 for reboot your system"
echo "press 5 for Current Date and Time "
echo "press 6 for create user "  	
select data in 1 2 3 4 5 6 7
do
	echo "inside select" 
	if [ "$data" == 1 ]
=======
echo "Press 1 for create the directory"  	
select data in 1 
do 
	if [ "$data" == 1 ];
>>>>>>> b94e825a7f85ae158ed3058b0e342e1968513262
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
	break
	fi 
	
	if [ "$data" == 2 ]
	then 
		echo "Enter the file name: "
		read filename

		if [ ! -f "$filename" ]
		then
   			echo "File doesn't exist. Creating now"
  			touch ./$filename
 			echo "File created"
		else
   			echo "File exists"
		fi
	break
	fi
	
	if [ "$data" == 3 ]
	then
		read -p "Enter the package name: " pname
		if ! rpm -qa | grep -qw $pname$;
		then							
    		sudo yum install $pname
	else
   	        echo "package does'nt exist"	 
		fi
	break
	fi
	
	if [ $data == 4 ]
        then
                echo "Rebooting System"
                /sbin/shutdown -r now
	break
        fi



	if [ "$data" == 5 ]
	then
		echo "Current Date and Time is: "
	        date
	break	 
	fi
	if [ $data == 6 ]
        then
                read -p "Search: " sname
                googler $sname
               
	break
        fi

	if [ $data == 7 ]
	then
		if [ $(id -u) -eq 0 ] 
		then
			read -p "Enter username : " username
			read -s -p "Enter password : " password
			egrep "^$username" /etc/passwd >/dev/null
				if [ $? -eq 0 ]
				then
					echo
			
					echo "$username exists!"
	        	
				else
					echo
					pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
					sudo useradd -m -p "$pass" "$username"
					[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
				fi
				break
		fi
	else
	echo 	"Only root may add a user to the system."
	
	break
	fi
	        
done
	

 
