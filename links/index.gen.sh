#!/usr/bin/env sh

# /!\ copy config.sh.dist to config.sh and customize vars /!\
. config.sh

$FETCHCMD -o $TMPFEED $FEEDSRC 2>/dev/null

cat header.inc > index.html

echo -e "\t<ul>" >> index.html
xsltproc rss2table.xsl $TMPFEED | head | \
while IFS="|" read link title; 
do 
	echo -e "\t\t<li><a href='$link'>$title</a></li>" >> index.html
done
echo -e "\t</ul>" >> index.html

cat footer.inc >> index.html
