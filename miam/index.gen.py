#!/usr/bin/env python
# -*- coding: utf8 -*-

import os
import datetime
import re
import sys
from pyatom import AtomFeed
from PIL import Image
from HTMLParser import HTMLParser
reload(sys)
sys.setdefaultencoding('utf8')
htmlparser = HTMLParser()

''' create navigation links '''
def navlinks(currentpage):
	navbar = "\t\t<nav>\n"

	if (currentpage > 0):
		navbar += "\t\t&nbsp;<a href='/miam/%s' title='pr&eacute;c&eacute;dent'>&laquo;&nbsp;</a>&nbsp;\n" % (currentpage - 1)
	if (nbpages - currentpage) > 1:
		navbar += "\t\t&nbsp;<a href='/miam/%s' title='suivant'>&nbsp;&raquo;</a>&nbsp;\n" % (currentpage + 1)

	return navbar + "\t\t</nav>\n\t\t<br /><br />\n"

''' return page footer code '''
def footer():
	return open('footer.inc', 'r').read()

''' if caption file exists, get its content '''
def getcaption(file):
        captionfile = "t/" + file.replace("jpg","txt")
        if os.path.isfile(captionfile):
                with open(captionfile, 'r') as captionfilecontent:
                   caption = captionfilecontent.read().replace("'","&#39;").strip()
        else:
                caption = ''
		
	return caption

''' create a list of images to display '''
dirList = os.listdir("b/")
imagelist = []
for fname in dirList:
	if fname.endswith(".jpg"):
    		imagelist.append(fname)
imagelist.sort(reverse=True)

feed = AtomFeed(title="Une petite faim ?",
                subtitle=htmlparser.unescape("C'est pas tr&egrave;s joli, mais en tout cas c'est bon"),
                feed_url="http://nicolas.legaillart.fr/miam/feed",
                url="http://nicolas.legaillart.fr/miam",
                author="Nicolas")

print("creating index (lazyload) page")
h = open('header.inc', 'r').read()
f = open('index.html', 'w')
m = h.replace('</head>','\t<!-- if javascript is not supported, redirect to static navigation -->\n\t<noscript><meta HTTP-EQUIV="REFRESH" content="0; url=http://nicolas.legaillart.fr/miam/0"></noscript>\n</head>')
f.write(m)
f.write("\t<noscript>/!\ Note: JavaScript semble ne pas fonctionner ou a &eacute;t&eacute; d&eacute;sactiv&eacute;; Cliquez <a href='http://nicolas.legaillart.fr/miam/0'>ici</a> pour basculer sur une navigation classique. /!\<br /><br /></noscript>\n")

for item in imagelist:
	''' build HTML structure '''
	imageline = "\t\t<figure>\n\t\t\t<a href='/miam/b/%s' data-lightbox='lightbox'" % item
	caption = getcaption(item)
	if caption:
		imageline += " title='%s'" % caption
	imageline += ">\n\t\t\t\t<img class='lazyload' alt='%s' src='/img/loader.gif' data-src='/miam/s/%s' onload='this.style.opacity=1;' /><noscript><img alt='%s' src='/miam/s/%s' /></noscript>\n\t\t\t</a>" % (caption, item, caption, item)

	if caption:
		imageline += "\n\t\t\t<br />\n\t\t\t<figcaption>%s</figcaption>" % caption
	imageline += "\n\t\t</figure>\n\t\t<br /><br />\n"

	f.write(imageline)
f.write(footer())

f.close()

''' classic navigation pages '''

''' 10 items or less per page '''
lists = [imagelist[i:i+10] for i in range(0, len(imagelist), 10)]
nbpages = len(imagelist)/10
if len(imagelist)%10 != 0:
	nbpages += 1 

for page in range(nbpages):
 	print("creating static page %s/%s"%(page+1,nbpages))
	h = open('header.inc', 'r').read()
	f = open('%s.html' % page, 'w')
	#m = h.replace('</head>','\t<!-- if javascript is supported, redirect to lazyload navigation -->\n\t<script type="text/javascript">$(location).attr("href","http://nicolas.legaillart.fr/miam");</script>\n</head>')
	f.write(h)
	f.write(navlinks(page))
	for item in lists[page]:

		''' if thumbnail does not exist, create it (require py-imaging, aka PIL) '''
		if not os.path.isfile("s/" + item):
			print "creating thumbnail for %s" % item
			size = 400, 400
			try:
				im = Image.open("b/%s" % item)
				im.thumbnail(size, Image.ANTIALIAS)
				im.save("s/%s" % item, "JPEG")
			except IOError:
				print "cannot create thumbnail for", item
			#os.system("mogrify -path s/ -thumbnail 400x400 b/%s" % item)

		''' build HTML structure '''
		imageline = "\t\t<figure>\n\t\t\t<a href='/miam/b/%s' data-lightbox='lightbox'" % item
		caption = getcaption(item)
		if caption:
			imageline += " title='%s'" % caption
		imageline += ">\n\t\t\t\t<img src='/miam/s/%s' />\n\t\t\t</a>" % item

		if caption:
			    imageline += "\n\t\t\t<br />\n\t\t\t<figcaption>%s</figcaption>" % caption
		imageline += "\n\t\t</figure>\n\t\t<br /><br />\n"

		f.write(imageline)

		''' put first page's items in the XML feed '''
		if page == 0:
			m = re.search('(\d{4})(\d{2})(\d{2})_(\d{2})(\d{2})(\d{2}).*',item)
			itemdate=datetime.datetime(int(m.group(1)),
                                      		int(m.group(2)),
                                      		int(m.group(3)),
                                      		int(m.group(4)),
                                      		int(m.group(5)),
                                      		int(m.group(6)))
		
			feed.add(title=htmlparser.unescape(caption),
			         content="<![CDATA[ <a href='https://nicolas.legaillart.fr/miam/b/%s'><img alt='%s' src='https://nicolas.legaillart.fr/miam/b/%s' /></a>]]>" % (item,htmlparser.unescape(caption),item),
		         	 content_type="html",
		           	 author="Nicolas",
	            		 url="http://nicolas.legaillart.fr/miam/b/%s" % item,
				 updated=itemdate)

	f.write(navlinks(page))
	f.write(footer())
	f.close()

f = open('feed.html', 'w')
f.write(feed.to_string())
f.close()
