#!/bin/bash
restaurer()
{
text=''
cd /home/backup
for i in `ls`
	do 
	text=$(echo $i | cut -d. -f3)
	if [[ $text == "bz2" ]]
then
cd /home/backup
sudo mkdir "res-$text"\_"$(date '+%Y-%m-%d')"
sudo tar -xjvf $i 
sudo mv $USER "res-$text"\_"$(date '+%Y-%m-%d')"
fi
if [[ $text == "gz" ]]
then
cd /home/backup
sudo mkdir "res-$text"\_"$(date '+%Y-%m-%d')"
sudo tar -zxvf $i 
sudo mv $USER "res-$text"\_"$(date '+%Y-%m-%d')"
fi
if [[ $text == "xz" ]]
then
cd /home/backup
sudo mkdir "res-$text"\_"$(date '+%Y-%m-%d')"
sudo tar -Jxvf $i
sudo mv $USER "res-$text"\_"$(date '+%Y-%m-%d')"
fi
done	
}
