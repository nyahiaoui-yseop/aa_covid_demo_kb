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
