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

    <!-- CUSTOM: Create a custom template to manage finalDocument -->
    <xsl:template name="finalDocument">
        <xsl:element name="div">
            <xsl:attribute name="id">final-document</xsl:attribute>
            <xsl:apply-templates select="//y:txt[@id='finalDocument']/." />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>

    <!-- CUSTOM: Remove the wrapper around intention paragraphs. -->
    <xsl:template match="intention">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:par">
        <xsl:element name="p">
            <xsl:for-each select="@*">
                <xsl:attribute name="{name()}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:for-each>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:line">
        <xsl:element name="br">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="yt:page-break">
        <xsl:element name="br" />
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:bold">
        <xsl:element name="b">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:italic">
        <xsl:element name="i">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:underline">
        <xsl:element name="u">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:strike">
        <xsl:element name="s">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <xsl:template match="yt:span">
        <xsl:element name="span">
            <xsl:copy-of select="@id|@class|@style" />
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:div">
        <xsl:element name="div">
            <xsl:copy-of select="@*" />
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:label">
        <xsl:element name="label">
            <xsl:copy-of select="@*" />
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:input">
        <xsl:element name="input">
            <xsl:copy-of select="@*" />
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:tab">
        <xsl:text>&#160;</xsl:text>
    </xsl:template>

    <xsl:template match="yt:no-break-space">
        <xsl:text>&#160;</xsl:text>
    </xsl:template>

    <xsl:template match="yt:non-breaking-hyphen">
        <xsl:text>&#x2011;</xsl:text>
    </xsl:template>

    <xsl:template match="yt:soft-hyphen">
        <xsl:text>&#x00AD;</xsl:text>
    </xsl:template>

    <xsl:template match="yt:begin-double-quote">
        <xsl:choose>
            <xsl:when test="@style='en'">
                <xsl:text>&#8220;</xsl:text>
            </xsl:when>
            <xsl:when test="@style='ja'">
                <xsl:text>&#x300C;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#171;&#160;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="yt:end-double-quote">
        <xsl:choose>
            <xsl:when test="@style='en'">
                <xsl:text>&#8221;</xsl:text>
            </xsl:when>
            <xsl:when test="@style='ja'">
                <xsl:text>&#x300D;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#160;&#187;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="yt:begin-title-quote">
        <xsl:choose>
            <xsl:when test="@style='ja'">
                <xsl:text>&#x300E;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text></xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="yt:end-title-quote">
        <xsl:choose>
            <xsl:when test="@style='ja'">
                <xsl:text>&#x300F;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text></xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="yt:begin-simple-quote">
        <xsl:text>&#8216;</xsl:text>
    </xsl:template>
    <xsl:template match="yt:end-simple-quote">
        <xsl:text>&#8217;</xsl:text>
    </xsl:template>

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:superscript">
        <xsl:element name="sup">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:subscript">
        <xsl:element name="sub">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- Table -->
    <xsl:template match="yt:table">
        <xsl:if test="yt:title">
            <xsl:element name="caption">
                <xsl:apply-templates select="yt:title" />
            </xsl:element>
        </xsl:if>
        <xsl:element name="table">
            <xsl:copy-of select="@id|@class|@style|@border" />
            <xsl:apply-templates select="yt:cells" />
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:cells">
        <xsl:apply-templates />
    </xsl:template>

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:row">
        <xsl:element name="tr">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:cell">
        <xsl:element name="td">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:header">
        <xsl:element name="th">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <xsl:template match="yt:div">
        <xsl:element name="div">
            <xsl:copy-of select="@*" />
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:h1">
        <xsl:element name="h1">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="yt:h2">
        <xsl:element name="h2">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="yt:h3">
        <xsl:element name="h3">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="yt:h4">
        <xsl:element name="h4">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="yt:h5">
        <xsl:element name="h5">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="yt:h6">
        <xsl:element name="h6">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:enum">
        <xsl:choose>
            <xsl:when test="@numbering = 'bullet'">
                <!-- CUSTOM: Use <xsl:element> -->
                <xsl:element name="ul">
                    <xsl:copy-of select="@*" />
                    <xsl:apply-templates />
                </xsl:element>
                <!-- /CUSTOM -->
            </xsl:when>
            <xsl:when test="@numbering = 'decimal'">
                <!-- CUSTOM: Use <xsl:element> -->
                <xsl:element name="ol">
                    <xsl:attribute name="type">1</xsl:attribute>
                    <xsl:copy-of select="@*" />
                    <xsl:apply-templates />
                </xsl:element>
                <!-- /CUSTOM -->
            </xsl:when>
            <xsl:when test="@numbering = 'lower-alpha'">
                <!-- CUSTOM: Use <xsl:element> -->
                <xsl:element name="ol">
                    <xsl:attribute name="type">a</xsl:attribute>
                    <xsl:copy-of select="@*" />
                    <xsl:apply-templates />
                </xsl:element>
                <!-- /CUSTOM -->
            </xsl:when>
            <xsl:when test="@numbering = 'lower-roman'">
                <!-- CUSTOM: Use <xsl:element> -->
                <xsl:element name="ol">
                    <xsl:attribute name="type">i</xsl:attribute>
                    <xsl:copy-of select="@*" />
                    <xsl:apply-templates />
                </xsl:element>
                <!-- /CUSTOM -->
            </xsl:when>
            <xsl:when test="@numbering = 'upper-alpha'">
                <!-- CUSTOM: Use <xsl:element> -->
                <xsl:element name="ol">
                    <xsl:attribute name="type">A</xsl:attribute>
                    <xsl:copy-of select="@*" />
                    <xsl:apply-templates />
                </xsl:element>
                <!-- /CUSTOM -->
            </xsl:when>
            <xsl:when test="@numbering = 'upper-roman'">
                <!-- CUSTOM: Use <xsl:element> -->
                <xsl:element name="ol">
                    <xsl:attribute name="type">I</xsl:attribute>
                    <xsl:copy-of select="@*" />
                    <xsl:apply-templates />
                </xsl:element>
                <!-- /CUSTOM -->
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:item">
        <xsl:element name="li">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:picture">
        <xsl:element name="img">
            <xsl:for-each select="@*">
                <xsl:choose>
                    <xsl:when test="name(.)='alternate'">
                        <xsl:attribute name="alt">
                            <xsl:value-of select="." />
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:value-of select="." />
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="." />
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <!-- CUSTOM: Use <xsl:element> -->
    <xsl:template match="yt:hlink">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="yt:src" />
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@target" />
            </xsl:attribute>
            <xsl:value-of select="yt:title" />
        </xsl:element>
    </xsl:template>
    <!-- /CUSTOM -->

    <xsl:template match="yt:text">
        <xsl:element name="div">
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@class">
                <xsl:attribute name="class">
                    <xsl:value-of select="@class"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:text-eval">
        <xsl:element name="yt:text-eval">
            <xsl:copy-of select="@*" />
            <xsl:apply-templates />
            <!-- Do not remove this comment it is required for preview fix YS-737 -->
            <xsl:comment>
                <xsl:value-of select="@id-write" />
            </xsl:comment>
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:section">
        <!-- CUSTOM -->
        <xsl:variable name="level">
            <xsl:choose>
                <!-- Propagate the value of (level + 1) or set it to 1 if no level (root level) -->
                <xsl:when test="@level">
                    <xsl:value-of select="sum(@level + 1)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="grouping" select="@grouping"/>
        <xsl:variable name="numbering" select="@numbering"/>
        <!-- /CUSTOM -->
        <xsl:element name="section">
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <!-- CUSTOM: Get the value of the attribute `yid` and put it in a new `data-yid` attribute. -->
            <xsl:if test="@yid">
                <xsl:attribute name="data-yid">
                    <xsl:value-of select="@yid"/>
                </xsl:attribute>
            </xsl:if>
            <!-- /CUSTOM -->
            <xsl:if test="@class">
                <xsl:attribute name="class">
                    <xsl:value-of select="@class"/>
                </xsl:attribute>
            </xsl:if>
            <!-- Group by tag name -->
            <xsl:for-each-group select="./*" group-adjacent="name()">
                 <xsl:choose>
                    <!-- Group paragraph according $grouping -->
                    <xsl:when test="current-grouping-key()='yt:paragraph'">
                        <xsl:choose>
                            <!-- Group paragraph in a p -->
                            <xsl:when test="$grouping = 'paragraph'">
                                <xsl:element name="p">
                                    <xsl:for-each select="current-group()">
                                        <xsl:element name="span">
                                            <xsl:if test="intention/@yid">
                                                <xsl:attribute name="data-yid" select="intention/@yid"/>
                                            </xsl:if>
                                            <xsl:apply-templates select="." mode="grouping-paragraph"/>
                                        </xsl:element>
                                        <xsl:text>&#32;</xsl:text>
                                    </xsl:for-each>
                                </xsl:element>
                            </xsl:when>
                            <!-- Group paragraph in a ul or ol -->
                            <xsl:when test="$grouping = 'list'">
                                <xsl:call-template name="grouping-list">
                                    <xsl:with-param name="numbering" select="$numbering"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- Do not group paragraph -->
                                <xsl:for-each select="current-group()">
                                    <xsl:apply-templates select=".">
                                        <xsl:with-param name="level" select="$level"/>
                                    </xsl:apply-templates>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="current-group()">
                             <xsl:apply-templates select=".">
                                <xsl:with-param name="level" select="$level"/>
                            </xsl:apply-templates>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each-group>
            <!-- /CUSTOM -->
        </xsl:element>
    </xsl:template>

    <!-- CUSTOM: group by list -->
    <xsl:template name="grouping-list">
        <xsl:param name="numbering"/>
        <!-- Select tag variable -->
        <xsl:variable name="tag">
            <xsl:choose>
                <xsl:when test="$numbering = 'bullet'">ul</xsl:when>
                <xsl:otherwise>ol</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- Select type variable for type attribute -->
        <xsl:variable name="type">
            <xsl:choose>
                <xsl:when test="$numbering = 'lower-alpha'">a</xsl:when>
                <xsl:when test="$numbering = 'lower-roman'">i</xsl:when>
                <xsl:when test="$numbering = 'upper-alpha'">A</xsl:when>
                <xsl:when test="$numbering = 'upper-roman'">I</xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="{$tag}">
            <!-- Select class attribute -->
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="$numbering = ''">list</xsl:when>
                    <xsl:when test="$type = '1'">decimal</xsl:when>
                    <xsl:otherwise><xsl:value-of select="$numbering"/></xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:if test="$tag = 'ol'">
                <xsl:attribute name="type">
                    <xsl:value-of select="$type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:for-each select="current-group()">
                <xsl:element name="li">
                    <xsl:if test="intention/@yid">
                        <xsl:attribute name="data-yid" select="intention/@yid"/>
                    </xsl:if>
                    <xsl:apply-templates mode="grouping-paragraph"/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:paragraph" mode="grouping-paragraph">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="yt:enum | yt:no-break-space | yt:bold | yt:italic | yt:underline | yt:strike | yt:span | yt:tab | yt:no-break-space | yt:non-breaking-hyphen | yt:soft-hyphen | yt:begin-double-quote | yt:end-double-quote | yt:begin-title-quote | yt:end-title-quote | yt:begin-simple-quote | yt:end-simple-quote | yt:superscript | yt:subscript | yt:hlink" mode="grouping-paragraph">
        <xsl:apply-templates select="."/>
    </xsl:template>
    <!-- /CUSTOM -->

    <xsl:template match="yt:title">
        <!-- CUSTOM: Replacing default span by `h{N}` elements -->
        <xsl:param name="level"/>
        <!-- Build h1, h2, etc… elements from the value of the $level param. -->
        <xsl:element name="{concat('h', min((6, $level)))}">
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@class">
                <xsl:attribute name="class">
                    <xsl:value-of select="@class"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@numbering">
                <xsl:value-of select="@numbering"/><xsl:text>&#32;</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
        <!-- /CUSTOM -->
    </xsl:template>

    <xsl:template match="yt:article">
        <xsl:element name="article">
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@class">
                <xsl:attribute name="class">
                    <xsl:value-of select="@class"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:comment">
        <xsl:element name="div">
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@class">
                <xsl:attribute name="class">
                    <xsl:value-of select="@class"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:text">
        <xsl:element name="div">
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@class">
                <xsl:attribute name="class">
                    <xsl:value-of select="@class"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:introduction">
        <xsl:element name="div">
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@class">
                <xsl:attribute name="class">
                    <xsl:value-of select="@class"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="yt:paragraph">
        <xsl:element name="p">
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@class">
                <xsl:attribute name="class">
                    <xsl:value-of select="@class"/>
                </xsl:attribute>
            </xsl:if>

            <!-- CUSTOM: Save the value of the attribute yid from the wrapper into a new data-yid attribute. -->
            <xsl:if test="intention/@yid">
                <xsl:attribute name="data-yid" select="intention/@yid"/>
            </xsl:if>
            <!-- /CUSTOM -->

            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
