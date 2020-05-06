<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:y="http://www.yseop.com/engine/3"
    xmlns:yt="http://www.yseop.com/text/2">
    <!-- Force a clean indentation of outputs -->
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:strip-space elements="*"/>

    <!-- Common XSL Yseop -->
    <xsl:include href="sharedXsl/html/commun-yseop-yt.xsl"/>
    <xsl:include href="sharedXsl/html/commun-yseop-log.xsl"/>
    <xsl:include href="sharedXsl/html/commun-helpers.xsl"/>

    <!-- GENERAL -->
    <xsl:template match="/">
        <xsl:choose>
            <!-- Display the content of the final document -->
            <xsl:when test="//y:txt[@id='finalDocument']">
                <xsl:call-template name="finalDocument" />
            </xsl:when>

            <!-- Display the logs -->
            <xsl:otherwise>
                <xsl:call-template name="log" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- CUSTOM: Remove y:txt element from the output -->
    <xsl:template match="y:txt">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- /CUSTOM-->

</xsl:stylesheet>
