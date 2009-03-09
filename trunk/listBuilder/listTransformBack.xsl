<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns="http://www.w3.org/1999/xhtml">
 
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
<xsl:strip-space elements="*" />
 
<xsl:template match="/ul">
	<tree>
		<xsl:apply-templates select="li" />
	</tree>
</xsl:template>
 
<xsl:template match="li">
	<xsl:choose>
		<xsl:when test="ul">
			<node t='{@id}'>
				<xsl:apply-templates select="ul/li" />
			</node>
		</xsl:when>
		<xsl:when test="text()">
			<xsl:value-of select="text()" />
		</xsl:when>
	</xsl:choose>
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
