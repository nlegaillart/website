	<div id='btn_up'><img alt='Retour en haut' title='Retour en haut' src='/img/jquery_scroll_up_icon.png' width='97' /></div>
	</div>
	</div>
	<footer><div class=footer> - <a href='//legaillart.fr'>Famille Le Gaillart</a> - <a href='https://stats.tourmentine.com/piwik/index.php?module=CoreAdminHome&action=optOut&language=fr' rel='nofollow'>Cookies</a> - </div></footer>
	<br /><br />
        <!-- Piwik -->
        <script>
         var _paq = _paq || [];

         _paq.push([function() { 
                var self = this; 
                function getOriginalVisitorCookieTimeout() { 
                        var now = new Date(), 
                        nowTs = Math.round(now.getTime() / 1000), 
                        visitorInfo = self.getVisitorInfo(); 
                        var createTs = parseInt(visitorInfo[2]); 
                        var cookieTimeout = 33696000; // 13 mois en secondes 
                        var originalTimeout = createTs + cookieTimeout - nowTs; 
                        return originalTimeout; 
                } 
                this.setVisitorCookieTimeout( getOriginalVisitorCookieTimeout() ); 
          }]);
          /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
          _paq.push(['trackPageView']);
          _paq.push(['enableLinkTracking']);
          (function() {
            var u="//stats.tourmentine.com/piwik/";
            _paq.push(['setTrackerUrl', u+'piwik.php']);
            _paq.push(['setSiteId', '9']);
            var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
            g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
          })();
        </script>
        <!-- End Piwik Code -->
</body>
</html>