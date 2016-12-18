<?php
require_once 'facebook.php';

$appapikey = '410437db3a1752a53acc133c13df57dd';
$appsecret = '30b3c377fdd2a275d78204b5dab5bf9d';
$facebook = new Facebook($appapikey, $appsecret);
$user = $facebook->require_login();

//[todo: change the following url to your callback url]
$appcallbackurl = 'http://nicolas.legaillart.fr/fb/currentlypracticing/';

//catch the exception that gets thrown if the cookie has an invalid session_key in it
try {
  if (!$facebook->api_client->users_isAppAdded()) {
    $facebook->redirect($facebook->get_add_url());
  }
} catch (Exception $ex) {
  //this will clear cookies for your application and redirect them to a login prompt
  $facebook->set_user(null, null);
  $facebook->redirect($appcallbackurl);
}
