<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:y="http://www.yseop.com/engine/3"
    xmlns:yt="http://www.yseop.com/text/2">
    <xsl:output method="html" encoding="UTF-8" doctype-public="html" doctype-system="html"/>

    <!--
        This file comes from this libSharedXsl repository. https://github.com/yseop/libSharedXsl.
        All rules that divert from this common file must be surrounded by "CUSTOM" comments
        in order to easily retrieve them and simplify updates.
    -->

    <!-- Common XSL Yseop -->
    <xsl:include href="sharedXsl/html/commun-yseop-yt.xsl"/>
    <xsl:include href="sharedXsl/html/commun-yseop-log.xsl"/>
    <xsl:include href="sharedXsl/html/commun-helpers.xsl"/>

    <!-- GENERAL -->
    <xsl:template match="/">
        <html>
            <head>
                <title>My generated report</title>
            </head>
            <body>
                <xsl:call-template name="finalDocument" />
                <xsl:call-template name="log" />
            </body>
        </html>
    </xsl:template>

    <!-- CUSTOM: Remove y:txt element from the output -->
    <xsl:template match="y:txt">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- /CUSTOM-->

</xsl:stylesheet>
