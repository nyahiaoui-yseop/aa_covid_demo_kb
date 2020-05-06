function UnitTest:financeCostsAlert_instance__fr()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention financeCostsAlert, as an instance and in French, is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        financeCostsAlert,
        _EXPECTED_OUTPUTS: {
            "Quelle est la composition des charges financières ? Quelle est son échéance ? Est-ce de la dette à taux variable ou à taux fixe ?"
        }
    );
};

function UnitTest:financeCostsAlert_class__fr()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention class FinanceCostsAlert in French is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        -> FinanceCostsAlert;,
        _EXPECTED_OUTPUTS: {
            "Quelle est la composition des charges financières ? Quelle est son échéance ? Est-ce de la dette à taux variable ou à taux fixe ?"
        }
    );
};


function UnitTest:financeCostsAlert_instance__en()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention financeCostsAlert, as an instance and in English, is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_en;
    LibDocument:Test:buildIntentionForExecution(
        financeCostsAlert,
        _EXPECTED_OUTPUTS: {
            "What are the finance costs composed of? What are their due dates? Are they fixed or variable interest debts?"
        }
    );
};

function UnitTest:financeCostsAlert_class__en()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention class FinanceCostsAlert in English is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_en;
    LibDocument:Test:buildIntentionForExecution(
        -> FinanceCostsAlert;,
        _EXPECTED_OUTPUTS: {
            "What are the finance costs composed of? What are their due dates? Are they fixed or variable interest debts?"
        }
    );
};

function UnitTest:structuralOrCyclicalAlert_instance__fr()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention structuralOrCyclicalAlert, as an instance and in French, is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        structuralOrCyclicalAlert,
        _EXPECTED_OUTPUTS: {
            "Est-ce structurel ou cyclique ? Expliquer le(s) événement(s) majeur(s) expliquant ce résultat ?"
        }
    );
};

function UnitTest:structuralOrCyclicalAlert_class__fr()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention class StructuralOrCyclical in French is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        -> StructuralOrCyclical;,
        _EXPECTED_OUTPUTS: {
            "Est-ce structurel ou cyclique ? Expliquer le(s) événement(s) majeur(s) expliquant ce résultat ?"
        }
    );
};


function UnitTest:structuralOrCyclicalAlert_instance__en()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention structuralOrCyclicalAlert, as an instance and in English, is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_en;
    LibDocument:Test:buildIntentionForExecution(
        structuralOrCyclicalAlert,
        _EXPECTED_OUTPUTS: {
            "Is it structural or cyclical? Explain the major event(s) that led to this result?"
        }
    );
};

function UnitTest:structuralOrCyclicalAlert_class__en()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention class StructuralOrCyclical in English is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_en;
    LibDocument:Test:buildIntentionForExecution(
        -> StructuralOrCyclical;,
        _EXPECTED_OUTPUTS: {
            "Is it structural or cyclical? Explain the major event(s) that led to this result?"
        }
    );
};


function UnitTest:cCompareEvolution_CA_EBE_Conso_N()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention cCompareEvolution_CA_EBE_Conso_N is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        cCompareEvolution_CA_EBE_Conso_N,
        _EXPECTED_OUTPUTS: {
            "TCompareCAEBE."
        }
    );
};

function UnitTest:cContributors_CAEBE()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention cContributors_CAEBE is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        cContributors_CAEBE,
        _EXPECTED_OUTPUTS: {
            "-> ContributorsCAEBEIntentionBulletAssembly ibaContributorsCAEBE ;"
        }
    );
};

function UnitTest:cStabilisation_EBECA_Conso_N()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:Alerts
--> isIntentionTest true
--> description "Check that the text of the intention cStabilisation_EBECA_Conso_N is as expected."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        cStabilisation_EBECA_Conso_N,
        _EXPECTED_OUTPUTS: {
            "CStabilisation_EBECA_Conso_N."
        }
    );
};
