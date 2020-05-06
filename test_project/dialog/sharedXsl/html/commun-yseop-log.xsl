<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:yt="http://www.yseop.com/text/2"
    xmlns:y="http://www.yseop.com/engine/3">
    <!-- Force a clean indentation of outputs -->
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:strip-space elements="*"/>

    <!--
        This file comes from this libSharedXsl repository. https://github.com/yseop/libSharedXsl.
        All rules that divert from this common file must be surrounded by "CUSTOM" comments
        in order to easily retrieve them and simplify updates.
    -->

    <!-- CUSTOM -->
    <xsl:template name="log">
        <xsl:element name="ul">
            <xsl:attribute name="id">log</xsl:attribute>
            <xsl:apply-templates select="//y:logging/y:log"/>
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <xsl:template match="y:log">
        <xsl:element name="li">
            <xsl:attribute name="class">
                <xsl:value-of select="@level"/>
            </xsl:attribute>
            <xsl:value-of select="y:message"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
