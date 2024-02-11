#!/usr/bin/env sh

# /!\ copy config.sh.dist to config.sh and customize vars /!\
. ./config.sh

$FETCHCMD -o $TMPFEED $FEEDSRC 2>/dev/null

cat header.inc > index.html
cat header.gmi > links.gmi

echo -e "\t<ul>" >> index.html
xsltproc rss2table.xsl $TMPFEED | head | \
while IFS="|" read link title; 
do 
	echo -e "\t\t<li><a href='$link'>$title</a></li>" >> index.html
	echo -e "=> $link $title" >> links.gmi
done
echo -e "\t</ul>" >> index.html
echo -e "" >> links.gmi

cat ../inc/footer.inc >> index.html
