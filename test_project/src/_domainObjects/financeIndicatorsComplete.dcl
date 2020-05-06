@patch Remove the enrichment when the informations here are in the ontology.

// Unknown indicators
LibCube:IndicatorMember RECEIPT_IN_ADVANCE;
LibCube:IndicatorMember TRADE_AND_OTHER_PAYABLES;
LibCube:IndicatorMember DIVIDENDS_RECEIVED_FROM_JV_AND_ASSOCIATES;

function enrichIndicators()
--> documentation """Set the label in French and English for each indicators available in the demo input."""
--> action {
    foreach(_indicator, LibCube:IndicatorMember) {
        switch(_indicator) {
            case(RECEIPT_IN_ADVANCE): {
                _indicator.label = -> MultilingualExpression
                    --> en -> LibOntology:NounPhrase
                        --> head "receipt in advance"
                        --> number SINGULAR
                    ;
                    --> fr -> LibOntology:NounPhrase
                        --> head "avances et acomptes reçus"
                        --> gender MASCULINE
                        --> number PLURAL
                    ;
                ;
            }
            case(TRADE_AND_OTHER_PAYABLES): {
                _indicator.label = -> MultilingualExpression
                    --> en -> LibOntology:NounPhrase
                        --> head "trade & other payables"
                        --> number PLURAL
                    ;
                    --> fr -> LibOntology:NounPhrase
                        --> head "dettes fournisseurs & comptes rattachés"
                        --> gender FEMININE
                        --> number PLURAL
                    ;
                ;
            }
            case(DIVIDENDS_RECEIVED_FROM_JV_AND_ASSOCIATES): {
                _indicator.label = -> MultilingualExpression
                    --> en -> LibOntology:NounPhrase
                        --> head "dividends received from joint ventures and associates"
                        --> number PLURAL
                    ;
                    --> fr -> LibOntology:NounPhrase
                        --> head "dividendes reçus des entreprises associées et de coentreprises"
                        --> gender MASCULINE
                        --> number PLURAL
                    ;
                ;
            }
        }
    }
};

complete LibDocument:DescribeValueContributors
    --> hideFromApi true
;

complete LibDocument:DescribeFormulaVariationContributors
    --> hideFromApi true
;

/**** Level of details completes ****/
/*
These instances are modified inside the test_project to avoid having to regenerate all the reference files when the default values are modified.
*/
@patch This needs to be done statically with completes but for some reasons, it works with precompiled library but not with the import lib way.
function defaultAndLODOverride()
--> domains Void
--> callOnInitServer true
--> action {
    INTENTION_DEFAULT_OPTIONS.writeOwner = true;

    DESCRIBE_VALUE_DEFAULT_OPTIONS.writeOwner = true;

    DESCRIBE_VALUE_CONTRIBUTORS_DEFAULT_OPTIONS.writeOwner = true;

    DESCRIBE_VARIATION_DEFAULT_OPTIONS.writeOwner = true;
    DESCRIBE_VARIATION_MEDIUM_LOD.showStartDate = true;
    DESCRIBE_VARIATION_MEDIUM_LOD.showEndDate = true;
    DESCRIBE_VARIATION_MEDIUM_LOD.showPeriod = false;
    DESCRIBE_VARIATION_MEDIUM_LOD.useAbsoluteVariation = true;

    DESCRIBE_VARIATION_CONTRIBUTORS_DEFAULT_OPTIONS.writeOwner = true;
    DESCRIBE_VARIATION_CONTRIBUTORS_DEFAULT_OPTIONS.leafContributorsOnly = true;
    DESCRIBE_VARIATION_CONTRIBUTORS_MEDIUM_LOD.useAbsoluteVariation = true;
    DESCRIBE_VARIATION_CONTRIBUTORS_MEDIUM_LOD.numberOfContributors = -1;
    DESCRIBE_VARIATION_CONTRIBUTORS_MEDIUM_LOD.mainContributorsRatio = 0;

    DESCRIBE_FORMULA_VARIATION_CONTRIBUTORS_DEFAULT_OPTIONS.writeOwner = true;
    DESCRIBE_FORMULA_VARIATION_CONTRIBUTORS_MEDIUM_LOD.showStartDate = true;
    DESCRIBE_FORMULA_VARIATION_CONTRIBUTORS_MEDIUM_LOD.showEndDate = true;
    DESCRIBE_FORMULA_VARIATION_CONTRIBUTORS_MEDIUM_LOD.showPeriod = false;
    DESCRIBE_FORMULA_VARIATION_CONTRIBUTORS_MEDIUM_LOD.useAbsoluteVariation = true;

    COMPARE_VALUE_WITH_REFERENCE_DEFAULT_OPTIONS.writeOwner = true;
    // logWarning(\(\debugValue(DESCRIBE_VARIATION_CONTRIBUTORS_MEDIUM_LOD, _ALL_ATTRIBUTES, _ATTRIBUTES_LOG_STYLE)\));
};
