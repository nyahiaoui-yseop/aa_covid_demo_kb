<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:y="http://www.yseop.com/engine/3" xmlns:yt="http://www.yseop.com/text/2">
    <xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes" media-type="application/json"/>

    <xsl:template match="@*|node()">
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>

    <!-- Build the intention API output. It should already be JSON. -->
    <xsl:template match="y:txt[@id='intentionApi']">
        <xsl:call-template name="mapJson"/>
    </xsl:template>

    <!-- Construct the resulting object -->
    <xsl:template match="y:output">
        <!-- Initializing the root JSON object -->
        <xsl:text>{</xsl:text>

        <xsl:choose>
            <!-- Returns the intention API if the element exists -->
            <xsl:when test="y:results/y:texts/y:txt[@id='intentionApi']">
                <xsl:text>"intentionApi":</xsl:text>
                <xsl:apply-templates select="y:results/y:texts/y:txt[@id='intentionApi']"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Add each text in the 'generatedTexts' string -->
                <xsl:text>"generatedTexts":"</xsl:text>
                <xsl:for-each select="y:results/y:texts/y:txt/yt:section//yt:paragraph//.">
                    <!-- Map yt:paragraph as string -->
                    <xsl:call-template name="mapText"/>
                </xsl:for-each>
                <xsl:text>"</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

        <!-- Add each log in the 'logs' array -->
        <xsl:text>,"logs":[</xsl:text>
        <xsl:for-each select="y:data-end/y:logging/y:log">
            <!-- Map y:log as JSON object -->
            <xsl:call-template name="mapLog"/>

            <!-- Add comma if not the last -->
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>]</xsl:text>

        <!-- Closing the root JSON object -->
        <xsl:text>}</xsl:text>
    </xsl:template>

    <!-- In case of text that is already JSON, nothing special to do. -->
    <xsl:template name="mapJson">
        <xsl:if test="string(.) != '' or descendant-or-self::*/@*[string(.)]">
            <xsl:for-each select="text()">
                <xsl:if test="normalize-space(.) != ''">
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <!-- A text is composed of multiple sentences separated by <p> tags -->
    <xsl:template name="mapText">
        <xsl:if test="string(.) != '' or descendant-or-self::*/@*[string(.)]">
            <!-- Retrieve each sentences (separated by <yt:par/> elements)> -->
            <xsl:for-each select="text()">
                <xsl:if test="normalize-space(.) != ''">
                    <!-- Put the sentence between html <p> elements -->
                    <xsl:text>&lt;p&gt;</xsl:text>

                    <!-- Escaping double quotes characters -->
                    <xsl:value-of select="replace(replace(normalize-space(.), '\\', '\\\\'), '&quot;', '\\&quot;')"/>

                    <xsl:text>&lt;/p&gt;</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <!-- This template is used to create JSON objects as representation of y:log elements -->
    <xsl:template name="mapLog">
        <xsl:text>{"level":"</xsl:text>

        <!-- Print y:log's level attribute -->
        <xsl:value-of select="@level"/>

        <xsl:text>","message":"</xsl:text>

        <!-- Print y:log/y:message content -->
        <xsl:value-of select="replace(replace(normalize-space(./y:message), '\\', '\\\\'), '&quot;', '\\&quot;')"/>

        <xsl:text>"}</xsl:text>
    </xsl:template>
</xsl:stylesheet>
