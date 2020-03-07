#!/bin/bash
archiver()
{
choix="ll"
until [[ $choix = "-arbz2" || $choix = "-argz" || $choix = "-arxz" ]]
do
echo -e "-arbz2) archiver en BZ2"
echo -e "-argz) archiver en GZ"
echo -e "-arxz) archiver en XZ"
read choix
done
if [[ $choix == "-arbz2" ]];then

name=`cat /etc/passwd | grep $USER | cut -f1 -d:`
 		
		cd /
		cd home	
		 sudo tar -cvjf  "$name"\_"$(date '+%Y-%m-%d').tar.bz2" $name/
		sudo mkdir backup
		sudo mv "$name"\_"$(date '+%Y-%m-%d').tar.bz2" backup	
		

elif [[ $choix == "-argz" ]]
then
name=`cat /etc/passwd | grep $USER | cut -f1 -d:`
 		
		cd /
		cd home	
		 sudo tar -zcvf  "$name"\_"$(date '+%Y-%m-%d').tar.gz" $name/
		sudo mkdir backup
		sudo mv "$name"\_"$(date '+%Y-%m-%d').tar.gz" backup
elif [[ $choix == "-arxz" ]]
then
name=`cat /etc/passwd | grep $USER | cut -f1 -d:`
 		
		cd /
		cd home	
		 sudo tar -Jcvf  "$name"\_"$(date '+%Y-%m-%d').tar.xz" $name/
		sudo mkdir backup
		sudo mv "$name"\_"$(date '+%Y-%m-%d').tar.xz" backup
fi

		
}


