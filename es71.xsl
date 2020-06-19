<?xml version="1.0" encoding="UTF-8"?>
<!--
    studente: Davide Caridi
    matricola: 559522
    corso: codifica di testi 2019-20
-->
<!-- Costruire un foglio di stile XSLT con alcune regole di trasformazione e lanciare il comando xsltproc da terminale -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:tei="http://www.tei-c.org/ns/1.0"
xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<xsl:template match="/tei:TEI">
		<html>
			<head>
				<title>Lettera Bellini</title>
			</head>
			<body>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="tei:teiHeader">
		<h1>Informazioni sul documento</h1>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:text/tei:front">
		<h1>Frontespizio</h1>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:text/tei:body">
		<h1>Testo</h1>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:text/tei:back">
		<h1>Appendici</h1>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:div">
		<p><xsl:apply-templates/></p>
	</xsl:template>
	<xsl:template match="tei:term">
		<b><i><xsl:apply-templates/></i></b>
	</xsl:template>
	<xsl:template match="tei:distinct">
		<font FACE="Garamond, Times, serif">
			<xsl:apply-templates/>
		</font>
	</xsl:template>
	<xsl:template match="tei:hi">
		<xsl:choose>
			<xsl:when test="@rend='italic'">
				<i><xsl:apply-templates/></i>
			</xsl:when>
			<xsl:when test="@rend='underline'">
				<u><xsl:apply-templates/></u>
			</xsl:when>
			<xsl:when test="@rend='align(right)'">
				<p align="right"><xsl:apply-templates/></p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tei:lb">
		<br/>
		<xsl:if test="@n">
			<span class="line">
				<xsl:value-of select="@n"/>
			</span>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>