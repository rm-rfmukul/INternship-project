#!/bin/bash




 

echo "Press 1 for create a directory" 
echo "press 2 for create a file"
echo "press 3 for install a package"
echo "press 4 for reboot your system"
echo "press 5 for Current Date and Time "
echo "press 6 for seach on google"
echo "press 7 for create user and password"
echo "press 8 for play song in current OS player"
echo "press 9 to google search to get top 5 url"  	
select data in 1 2 3 4 5 6 7 8 9
do
	#for create the directory
	echo "inside select" 
	if [ "$data" == 1 ]
	then

		echo "Enter directory name"
		read dirname
		if [ ! -d "$dirname" ] #check the directory existance in current directory
		then
    			echo "Directory doesn't exist. Creating now"
    			mkdir ./$dirname
    			echo "Directory created"
		
		else
  			echo "Directory exists"
		 
		fi
	break
	fi 
	#for create the file 
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
	#else
   	       # echo "package does'nt exist"	 
		fi
	break
	fi
	
	if [ "$data" == 4 ]
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
	if [ "$data" == 6 ]
        then
		if [ rpm -qa | grep -i googler = googler-4.3.1-1.el7.x86_64 ]
		then	
			   read -p "Search: " sname
		 	   googler $sname
			
                else
			   echo "installing package"
			   sudo curl -o /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v4.3.2/googler && sudo chmod +x /usr/local/bin/googler
			   if [ $(id -u) -eq 0 ] 
			   then
				read -p "Search: " sname
			        googler $sname
               		   fi
		break
		fi
	break
        
	fi

	if [ "$data" == 7 ]
	then
		#if [ $(id -u) -eq 0 ] 
		#then
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
				
		break
		fi
	
	#else
	#echo 	"something went wrong."
	
	break

	fi
	

	if [ "$data" == 8 ]
	then  	
		
		
	        if [[ $(rpm -qa | grep -i ffmpeg-3.4 ) != 'ffmpeg-3.4.8-1.el7.x86_64' ]]
		then
			 yum install epel-release
			yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
			yum install ffmpeg ffmpeg-devel


		break
		fi

        		echo "give the name of the song: "
                        read sname
			if [ ! -f "${sname}.wav" ]
                        then
                        ffmpeg -i "${sname}.mp3" "${sname}.wav" &> /dev/null
                        fi

         play "${sname}.wav" &> /dev/null
	break
	fi
	     


	if [ $data == 9 ]
	then
                if [[ $(rpm -qa | grep -i googler ) == 'googler-4.3.2-1.el7.x86_64' ]]
                then

		#	echo "A"
           	#	[ $? -eq 0 ]
                        
                        read -p "Search: " sname
                        googler -n 5 $sname
                        

		else
			sudo yum update -y
			sudo rpm -ivh https://github.com/jarun/googler/releases/download/v4.3.2/googler-4.3.2-1.el7.7.centos.x86_64.rpm
			if [ $? -eq 0 ]
                        then
                                read -p "Search: " sname
                                googler -n 5 $sname
                fi

                    #       read -p "Search: " sname
                     #      googler $sname

                #else
                 #          echo "installing package"
                 #          sudo curl -o /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v4.3.2/googler && sudo chmod +x /usr/local/bin/googler
                  #         if [ $(id -u) -eq 0 ]
                   #        then
                    #            read -p "Search: " sname
                     #           googler $sname
                      #     fi
                #break
                fi
       
        fi   
done
	

 
