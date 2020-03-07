#!/bin/bash
nettoyer()
{
	df -m | tr -s " " | cut -f4 -d" " | tail -n +2 > testt.txt

	r=0
	for i in `cat testt.txt`
		do 
			let r=r+$i
		done 
		let r=r/1000
		echo "il reste stockage dans le disque $r gb"
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
	echo "la taille des archives est de  $r2 gb"
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
	echo 	"Diiference de stockage entre les archives et le disque $stockage"
	if [[  $stockage -gt 2 ]] 

	then 
	for i in `ls -t | tail -n $compteur2`
	do
	sudo rm -rf $i
	done
	else echo "pas besoin de nettoyage il ya encore de l'espace"
	fi 
}
