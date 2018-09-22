<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:feedburner="http://rssnamespace.org/feedburner/ext/1.0"
   xmlns:atom="http://www.w3.org/2005/Atom">
<xsl:output method="text" encoding="utf-8"/>

<xsl:variable name="rem" select="'|&#10;&lt;&gt;'"/>
<xsl:variable name="rem2" select="'|&#10;'"/>

<xsl:template match="/">
<xsl:apply-templates select="rss/channel/item"/>
<xsl:apply-templates select="atom:feed/atom:entry"/>
</xsl:template>

<xsl:template match="item">
<xsl:choose><xsl:when test="link"><xsl:value-of select="translate(link,$rem,'')"/></xsl:when><xsl:otherwise><xsl:value-of select="translate(guid,$rem,'')"/></xsl:otherwise></xsl:choose>|<xsl:value-of select="translate(title,$rem,'')"/>
<xsl:text>&#10;</xsl:text>
</xsl:template>

<xsl:template match="atom:entry">
<xsl:choose><xsl:when test="feedburner:origLink"><xsl:value-of select="translate(feedburner:origLink,$rem,'')"/></xsl:when><xsl:when test="atom:link/@href"><xsl:value-of select="translate(atom:link/@href,$rem,'')"/></xsl:when><xsl:otherwise><xsl:value-of select="translate(atom:link,$rem,'')"/></xsl:otherwise></xsl:choose>|<xsl:value-of select="translate(atom:title,$rem,'')"/>
<xsl:text>&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>
