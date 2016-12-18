<?php
require_once 'appinclude.php';

//echo "<p>hello $user</p>";
//echo "<center><img src='http://didier.arlabosse.free.fr/balles/figures/mills3.gif' /><br /><b>The Mill's Mess!</b></center>";

//echo "<p>hello $user</p>";
//
//if (isset($_REQUEST['profiletext'])) {
  //$facebook->api_client->profile_setFBML("<center><img src='http://didier.arlabosse.free.fr/balles/figures/3mills.gif' /><br /><b><a href='http://didier.arlabosse.free.fr/balles/debmills.html'>The Mill's Mess!</a></b></center>", $user);
  $facebook->api_client->profile_setFBML("<center><img src='http://nicolas.legaillart.fr/fb/currentlypracticing/green_powerball_top_web.jpg' /><br /><b><a href='http://www.powerballs.com/'>The Powerball!</a></b></center>", $user);
  $facebook->redirect($facebook->get_facebook_url() . '/profile.php');
//}
//
//echo '<form action="" method="get">';
//echo '<input name="profiletext" type="text" size="30" value=""><br>';
//echo '<input name="submit" type="submit" value="Display text on profile">';
//echo '</form>';
?>
