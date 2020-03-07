#!/bin/bash
source archivage.sh
source restauration.sh
source taillelibre.sh
source nettoyage.sh
main()
{

case $1 in
"-G") source menu.sh
;;
"-ar") archiver
;;
"-re")  restaurer
;;
"-sa")  savoir
;;
"-clean")  nettoyer
;;
"-help") cat aide.txt
;;
*) echo "rien a ete ,entrez -help pour help"
;;
esac
}
main $1
