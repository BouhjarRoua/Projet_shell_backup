#! /bin/bash
source archivage.sh
source restauration.sh
source taillelibre.sh
source nettoyage.sh

action=$(yad --width 300 --entry --title "bienvenue à notre application shell" \
    --image=gnome-shutdown \
--center --on-top \
   --button="gtk-ok:0" --button="gtk-close:1" \
   --text "Choose action:" \
    --entry-text \
    "archivage" "restauration" "taillelibre" "nettoyage" "aide")
ret=$?

[[ $ret -eq 1 ]] && exit 0



case $action in
	
     
  archivage*) choix=4
until [[ $choix -le 3 && $choix -ge 1 ]]
do
echo -e "1) BZ2"
echo -e "2) GZ"
echo -e "3) XZ"
read choix
done
if [[ $choix == 1 ]];then
name=`cat /etc/passwd | grep $USER | cut -f1 -d:`
 		
		cd /
		cd home	
		 sudo tar -cvjf  "$name"\_"$(date '+%Y-%m-%d').tar.bz2" $name/
		sudo mkdir backup
		sudo mv "$name"\_"$(date '+%Y-%m-%d').tar.bz2" backup	
		yad --info --center --text "<span color=\"pink\" font=\"30\"><b>Done</b></span>"

elif [[ $choix == 2 ]]
then
name=`cat /etc/passwd | grep $USER | cut -f1 -d:`
 		
		cd /
		cd home	
		 sudo tar -zcvf  "$name"\_"$(date '+%Y-%m-%d').tar.gz" $name/
		sudo mkdir backup
		sudo mv "$name"\_"$(date '+%Y-%m-%d').tar.gz" backup
		yad --info --center --text "<span color=\"pink\" font=\"30\"><b>Done</b></span>"
elif [[ $choix == 3 ]]
then
name=`cat /etc/passwd | grep $USER | cut -f1 -d:`
 		
		cd /
		cd home	
		 sudo tar -Jcvf  "$name"\_"$(date '+%Y-%m-%d').tar.xz" $name/
		sudo mkdir backup
		sudo mv "$name"\_"$(date '+%Y-%m-%d').tar.xz" backup
		yad --info --center --text "<span color=\"pink\" font=\"30\"><b>Done</b></span>"
fi


		
		;;
restauration*) 
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

	;;

taillelibre*) df -m | tr -s " " | cut -f4 -d" " | tail -n +2 > testt.txt

r=0
for i in `cat testt.txt`
	do 
		let r=r+$i
	done 
	let r=r/1000
	echo "il reste stockage $r gb"
	
;;
nettoyage*)
df -m | tr -s " " | cut -f4 -d" " | tail -n +2 > testt.txt

	r=0
	for i in `cat testt.txt`
		do 
			let r=r+$i
		done 
		let r=r/1000
		#echo "il reste stockage dans le disque $r gb"
		
	cd /
	cd home
	cd backup

	for i in *
	do
	if [[ ! -d "$i" ]]
	then
	a=`sudo du -m "$i"`
	sudo echo "$a" >> ~/taille.txt
	fi
	done
	sort ~/taille.txt | uniq |tr -s " "| cut -f1 > ~/taille2.txt
	r2=0
	r3=1
	for i in `cat ~/taille2.txt`
		do 
			let r2=r2+$i
		done
	let r2=r2/1000
	#echo "la taille des archives est de  $r2 gb"
	compteur=0
	for i in `ls -t`
	do
	let compteur++
	done
	#let compteur=compteur-1
	echo "compteur egal  $compteur "
	let compteur2=compteur-1
	stockage=0
	let stockage=r-r2
	#echo 	"Diiference de stockage entre les archives et le disque $stockage"
	yad --width=600 --center --info --text "<span color=\"pink\" font=\"20\"><b>il reste stockage dans le disque $r gb,la taille des archives est de  $r2 gb,Diiference de stockage entre les archives et le disque $stockage </b></span>"
	if [[  $stockage -gt 2 ]] 

	then 
	for i in `ls -t | tail -n $compteur2`
	do
	sudo rm -rf $i
	done
	yad --info --center --text "<span color=\"pink\" font=\"30\"><b>Done</b></span>"
	else #echo "pas besoin de nettoyage il ya encore de l'espace"
		yad --info --center --text "<span color=\"pink\" font=\"30\"><b>pas besoin de nettoyage il ya encore de l'espace</b></span>"
	fi 

;;
aide*) yad --form --center --width=500 --title="aide" --text="
ar-creer une archive compressee 
re- restaurer les documents 
sa- savoir la taille du disque
clean- nettoyer touts les archives compressee si la difference entre la taille des archives et l'espace libre du disque n'excede pas 2GO (tout en gardant la derniere archive)"\

;;

 
     
esac
