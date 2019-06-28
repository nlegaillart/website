<?php

include "header.php";

?>

<body>
<div class="main">
<div class="main-inside">
<nav><p class='header'><a href='/'>Accueil</a> | <a href='/contact'>Coordonn&eacute;es</a> | <a href='/cv'>CV</a> | Livres | <a href='/fortunes'>Citations</a> | <a href='links'>Liens</a> | <a href='/miam'>Cuisine</a></p></nav>

<?php
$FileName = "foirolivres.csv";

$fp = fopen($FileName,"r");

$Cpt = 0;
while ($data = fgetcsv($fp, 1000, ","))
{
        if ($data[0][0] != "#")
        {
                $author[$Cpt] = $data[0];
                $title[$Cpt] = stripcslashes($data[1]);
                $format[$Cpt] = stripcslashes($data[2]);
                $booked[$Cpt] = stripcslashes($data[3]);
		if ($data[3] != "1")
		{
                $Cpt++;
		}
        }
}
fclose($fp);
$Max = $Cpt;
/*
$csvData = file_get_contents($fileName);
$csvNumColumns = 4;
$csvDelim = ",";
$data = array_chunk(str_getcsv($csvData, $csvDelim), $csvNumColumns); 
*/
echo "<h1>Foire aux livres</h1>";
?>
<p>Je lis de plus en plus de livres &eacute;lectroniques. Et comme je sais que la plupart des gens kiffent encore le &quot;papier&quot;, cette technologie du moyen-&acirc;ge qui assassine nos amis les arbres, je leur pardonne et leur en fait profiter en faisant don des quelques exemplaires auxquels j'ai trouv&eacute; un &eacute;quivalent num&eacute;rique.</p>

<p>Voila donc le principe: vous choisissez le(s) livre(s) que vous voulez, et vous me le(s) demandez par mail (le lien &quot;r&eacute;server&quot; devrait en principe le remplir &agrave; votre place), en indiquant si possible le lieu et la date du don, l'id&eacute;al &eacute;tant que cela se fasse autour d'un verre/d&eacute;j/diner/whatever, bref de fa&ccedil;on conviviale. Premier arriv&eacute;, premier servi; offre r&eacute;serv&eacute;e &agrave; Paris ou r&eacute;gion parisienne, ou alors il faudra &ecirc;tre TR&Egrave;S gentil pour que je vous l'envoie par la poste :)</p>
<?php
if ($Max == 0)
	$dispo = "Il n'y a malheureusmement plus aucun livre";
elseif ($Max == 1)
	$dispo = "Il y a actuellement un livre";
else
	$dispo = "Il y a actuellement $Max livres";
?>
<p><?php echo $dispo; ?> &agrave; donner, mais n'h&eacute;sitez pas &agrave; revenir, cette liste &eacute;tant appel&eacute;e &agrave; s'&eacute;toffer.</p>
<!--<p>Il y a actuellement <?php echo $Max; ?> livres &agrave; donner, mais n'h&eacute;sitez pas &agrave; revenir, cette liste &eacute;tant appel&eacute;e &agrave; s'&eacute;toffer.</p>-->
<br />
<?php
if ($Max>0)
{
echo "<table>\n";
echo "<tr><td class='header'>Auteur</td><td class='header'>Titre</td><td class='header'>Format</td><td></td></tr>\n";
for($Cpt=0; $Cpt<$Max; $Cpt++)
{
	if ($format[$Cpt] == "")
	{
		$format[$Cpt] = "poche";
	}
	if ($booked[$Cpt] != 1)
	{
              echo "<tr itemscope itemtype =\"http://schema.org/Book\" onmouseover=\"this.style.backgroundColor='#D5E5ED';\" onmouseout=\"this.style.backgroundColor='#FFFFFF';\">\n\t<td itemprop='author'>".$author[$Cpt]."</td>\n\t<td itemprop='name'>".$title[$Cpt]."</td>\n\t<td>".$format[$Cpt]."</td>\n\t<td><a class='mailto' href='mailto:nicolas@legaillart.fr?subject=salut,%20j%27peux%20avoir%20%22".rawurlencode(htmlspecialchars($title[$Cpt],ENT_QUOTES))."%22%20%3f&body=on%20peut%20se%20donner%20rendez-vous%20le%20(remplir%20date)%20ici:%20(remplir%20lieu)%20pour%20que%20tu%20me%20le%20files.%0d%0a%0d%0a%0D%0Det%20comme%20j%27aime%20abuser,%20je%20voudrais%20bien%20ceux-la%20aussi:%0d%0a%0d%0a%0d%0a%0D%0DPS:%20j%27aime%20beaucoup%20ce%20que%20vous%20faites,%20et%20je%20vous%20trouve%20très%20beau'>r&eacute;server</a></td>\n</tr>\n";
	}
}
echo "<tr><td class='header'>Auteur</td><td class='header'>Titre</td><td class='header'>Format</td><td></td></tr>\n";
echo "</table>\n";
}
include "../inc/footer.inc";

?>

