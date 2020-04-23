#!/bin/sh

pages="/ /contact /cv /fortunes /links /miam"
names="Accueil Coordonn&eacute;es CV Citations Liens Cuisine"
max=`echo $names | wc -w`

echo "Generating navbars..."

for page in $pages
do
	# counter for names
	nb=1
	menuname=`echo $page | cut -f 2 -d "/"`
	if [ -z $menuname ]
	then
		menuname="index"
	fi
	menufile="inc/${menuname}_navbar.inc"
	echo " * $menufile"
	for allpages in $pages
	do
		name=`echo $names | cut -f $nb -d " "`
		if [ $allpages = $page ]
		then
			echo -n "$name" >> $menufile
		else
		
			echo -n "<a href='$allpages'>$name</a>" >> $menufile
		fi
		if [ $nb -lt $max ]
		then
			echo -n " | "  >> $menufile
		fi
		nb=$(($nb + 1))
	done
done
