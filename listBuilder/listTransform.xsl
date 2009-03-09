<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns="http://www.w3.org/1999/xhtml"
 exclude-result-prefixes="default">
 
<xsl:output method="xml" indent="yes" encoding="UTF-8" />
<xsl:strip-space elements="*" />
 
<xsl:template match="/tree">
	<ul id='mainlist'>
		<xsl:apply-templates select="node" />
	</ul>
</xsl:template>
 
<xsl:template match="node">
	<li id="{@t}">
		<xsl:value-of select="@t"/>
		<xsl:if test="node">
			<ul>
				<xsl:apply-templates select="node" />
			</ul>
		</xsl:if>
		<xsl:if test="text()">
			<ul>
				<li id="{text()}"><xsl:value-of select="text()" /></li>
			</ul>
		</xsl:if>
	</li>
</xsl:template>

<!--<xsl:template match="item">
    <li>
      <a href="{url}">
        <xsl:value-of select="name"/>
      </a>
      <xsl:if test="item">
        <ul>
          <xsl:apply-templates select="item"/>
        </ul>
      </xsl:if>
    </li>
  </xsl:template>-->

 
</xsl:stylesheet>
