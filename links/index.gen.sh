#!/usr/bin/env sh

# /!\ copy config.sh.dist to config.sh and customize vars /!\
. ./config.sh

$FETCHCMD -o $TMPFEED $FEEDSRC 2>/dev/null

cat header.inc > index.html
cat header.gmi > links.gmi

PARSED_DATA=$(cat "$TMPFEED" | sed -n '/<entry>/,\/entry/p' | \
    grep -o '<title>.*</title>\|<link[^>]*href="[^"]*"' | \
    sed -e 's/<title>\(.*\)<\/title>/\1/' -e 's/.*href="\([^"]*\)".*/\1/')

echo -e "\t<ul>" >> index.html
echo "$PARSED_DATA" | awk '{ getline link; gsub(/&/, "&amp;", link); title=$0; if (title == "") { title=link }; printf "\t\t<li><a href=\"%s\">%s</a></li>\n", link, title }' | head -n 10 >> index.html
echo "$PARSED_DATA" | awk '{ getline link; title=$0; if (title == "") { title=link }; printf "=> %s %s\n", link, title }' | head -n 10 >> links.gmi
echo -e "\t</ul>" >> index.html
echo -e "" >> links.gmi

cat ../inc/footer.inc >> index.html
