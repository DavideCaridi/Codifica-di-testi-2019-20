<?xml version="1.0" encoding="UTF-8"?>
<!--
    studente: Davide Caridi
    matricola: 559522
    corso: codifica di testi 2019-20
-->
<!-- Modificare opportunamente il file template.xsl aggiungendo variabili, parametri e call template -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/title"/>
                </title>
                <link rel="stylesheet" type="text/css" href="./mycss.css"/>
                <style>
                    h1{
                        color:blue;
                    }
                </style>
            </head>
            <body>
                <div class="index">
                    <h1>INDEX</h1>
                    <ul>
                        <xsl:apply-templates select="//div[@type='chapter']" mode="index"/>
                    </ul>
                </div>
                <div>
                    <xsl:apply-templates select="child::node()"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div" mode="index">
        <ul>
            <xsl:for-each select=".">
                <li>
                    <xsl:value-of select="head"/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template match="s">
		<div class="frase">
			<xsl:attribute name="id"><xsl:value-of select="@n"/></xsl:attribute>
			<xsl:call-template name="sentence_join">
				<xsl:with-param name="id" select="@xml:id"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
    <xsl:template match="titleStmt/title">
        <h2>
            <xsl:value-of select="."/>
        </h2>
    </xsl:template>
    <xsl:template match="div/head">
        <h3>
            <xsl:value-of select="."/>
        </h3>
    </xsl:template>
    <xsl:template match="teiHeader">
        <span>[identificativo del documento: <xsl:value-of select="@xml:id"/>]</span>
    </xsl:template>
    <xsl:template name="sentence_join">
		<xsl:param name="id"/>
		<xsl:for-each select="../../../..//join">
			<xsl:variable name="b" select="substring-before(@target, ' ')"/>
			<xsl:variable name="a" select="substring-after(@target, ' ')"/>
			<xsl:if test="$b=concat('#', $id)">
				<xsl:attribute name="title">
					<xsl:value-of select="../../..//s[@xml:id=translate($a, '#', '')]"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$a=concat('#', $id)">
				<xsl:attribute name="title">
					<xsl:value-of select="../../..//s[@xml:id=translate($b, '#', '')]"/>
				</xsl:attribute>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>