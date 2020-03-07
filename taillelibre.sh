#!/bin/bash
savoir()
{
	df -m | tr -s " " | cut -f4 -d" " | tail -n +2 > testt.txt

r=0
for i in `cat testt.txt`
	do 
		let r=r+$i
	done 
	let r=r/1000
	echo "il reste stockage $r gb"
}
