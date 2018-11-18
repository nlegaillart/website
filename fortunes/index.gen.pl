#!/usr/bin/env perl

use strict;
use warnings;

use File::Copy qw(copy);

copy "header.inc","index.html";

open(LIRE,"fortunes");
open(ECRIRE,">>index.html");

print ECRIRE "\t<p>Voici quelques citations que j'aime bien. Vous pouvez télécharger le fichier de <a href='https://fr.wikipedia.org/wiki/Fortune_%28programme%29'>fortunes</a> correspondant <a href='/fortunes/fortunes'>ici</a>, ainsi que son fichier d'index <a href='/fortunes/fortunes.dat'>là</a>.</p>\n\t<br />\n\n\t<div class='quotes'>\n\n\t<p class='smallquotes'>\n";
while (<LIRE>) {
$_ =~ s/\(/\n\t<br\ \/>&nbsp;&nbsp;&nbsp;&nbsp;\(/g;
$_ =~ s/\n$/<br\ \/>/g;
$_ =~ s/%/<\/p>\n\t<p class='smallquotes'>/g;
print ECRIRE "\t".$_;
}
print ECRIRE "</div>\n";
close(LIRE);
#close(ECRIRE);

open(LIRE,"../inc/footer.inc");
#open(ECRIRE,">>index.html");

while (<LIRE>) {
print ECRIRE $_;
}

close(LIRE);
close(ECRIRE);
