<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:y="http://www.yseop.com/engine/3">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:strip-space elements="*"/>

    <!-- Matches root element and construct output document -->
    <xsl:template match="/root">
        <y:input xmlns:y="http://www.yseop.com/engine/3">
            <y:data>
                <y:instance yid="theGeneralData">
                    <xsl:apply-templates select="@*|node()"/>
                </y:instance>
            </y:data>
        </y:input>
    </xsl:template>

    <!-- Add `_yid` and `_yclass` attributes from fields -->
    <xsl:template name="transformYseopAttributes">
        <xsl:if test="_yid">
            <xsl:attribute name="yid">
                <xsl:value-of select="_yid"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="_yclass">
            <xsl:attribute name="yclass">
                <xsl:value-of select="_yclass"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!-- Template used for copying an element -->
    <xsl:template name="copyContent">
        <xsl:call-template name="transformYseopAttributes"/>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>

    <!-- Remove "_yid" and "_yclass" fields -->
    <xsl:template match="_yid"/>
    <xsl:template match="_yclass"/>

    <!--
        Fallback template for all other objects
    -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:call-template name="copyContent"/>
        </xsl:copy>
    </xsl:template>

    <!--
        Managing arrays of parent/item.
    -->
    <!-- Parent elements are removed from the output -->
    <xsl:template match="
          cube/dimensions
        | cube/dimensions/item/members
        | cube/dimensions/item/hierarchies
        | cube/dimensions/item/hierarchies//child
        | cube/facts
        | cube/facts/item/members
        | cube/facts/item/factMeasures
        | dimensionConditions/item/members
        | cube/measures
        | request/measures
        | request/filters
        | request/filters/item/members
        | data/metadata
        | data/metadata/item/tags
        | data/metadata/item/members
        | keyPerformanceIndicators
        | dynamicStylingConfigurations
        | routedDynamicStylingConfigurations
        | customConceptsConfiguration/configValues//customTexts//synonyms
        | routedCustomConceptsConfiguration
        | sentimentConfiguration
        | filter/calculationTypes
        | filter/roles
        | filter/categories
        | filter/computedValuesNames
        | route
        | dataSelectionFilters/configValues//val//members
        | conceptsSpecializationsConfiguration/configValues//val//removeSynonyms
    ">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- `item` elements acquire their parent element name -->
    <xsl:template match="
          cube/dimensions/item
        | cube/dimensions/item/members/item
        | cube/dimensions/item/hierarchies/item
        | cube/dimensions/item/hierarchies//child/item
        | cube/facts/item
        | cube/facts/item/members/item
        | cube/facts/item/factMeasures/item
        | cube/measures/item
        | request/measures/item
        | request/filters/item
        | request/filters/item/members/item
        | data/metadata/item
        | data/metadata/item/tags/item
        | data/metadata/item/members/item
        | dimensionConditions/item/members/item
        | keyPerformanceIndicators/item
        | dynamicStylingConfigurations/item
        | routedDynamicStylingConfigurations/item
        | customConceptsConfiguration/configValues//customTexts//synonyms/item
        | routedCustomConceptsConfiguration/item
        | sentimentConfiguration/item
        | filter/calculationTypes/item
        | filter/roles/item
        | filter/categories/item
        | filter/computedValuesNames/item
        | route/item
        | dataSelectionFilters/configValues//val//members/item
        | conceptsSpecializationsConfiguration/configValues//val//removeSynonyms/item
    ">
        <xsl:element name="{name(..)}">
            <xsl:call-template name="copyContent"/>
        </xsl:element>
    </xsl:template>

    <!--
        Managing Lists
    -->
    <!-- Parent elements acquire the `yclass="List"` attribute -->
    <xsl:template match="
          thresholds
        | rangeValues
        | components
        | dimensionConditions
        | customConceptsConfiguration/configValues//customTexts
        | dataSelectionFilters/configValues//val [item]
    ">
        <xsl:copy>
            <xsl:attribute name="yclass">List</xsl:attribute>
            <xsl:call-template name="copyContent"/>
        </xsl:copy>
    </xsl:template>

    <!-- `item` elements are mapped to `values` -->
    <xsl:template match="
          thresholds/item
        | rangeValues/item
        | components/item
        | dimensionConditions/item
        | customConceptsConfiguration/configValues//customTexts/item
        | dataSelectionFilters/configValues//val/item
    ">
        <values>
            <xsl:call-template name="copyContent"/>
        </values>
    </xsl:template>

    <!--
        Managing HashMaps
    -->
    <!-- Parent elements acquire the `yclass="HashMap"` attribute -->
    <xsl:template match="
          dynamicStylingConfiguration/configValues
        | customConceptsConfiguration/configValues
        | conceptSpecializationConfiguration/configValues
        | dataSelectionFilters/configValues
        | conceptsSpecializationsConfiguration/configValues
        | sentimentConfiguration/configValues
    ">
        <xsl:copy>
            <xsl:attribute name="yclass">HashMap</xsl:attribute>
            <xsl:call-template name="copyContent"/>
        </xsl:copy>
    </xsl:template>

    <!-- `item` elements are mapped to `values` -->
    <xsl:template match="
          dynamicStylingConfiguration/configValues/item
        | customConceptsConfiguration/configValues/item
        | conceptSpecializationConfiguration/configValues/item
        | conceptsSpecializationsConfiguration/configValues/item
        | dataSelectionFilters/configValues/item
        | sentimentConfiguration/configValues/item
    ">
        <values>
            <xsl:call-template name="copyContent"/>
        </values>
    </xsl:template>

</xsl:stylesheet>
