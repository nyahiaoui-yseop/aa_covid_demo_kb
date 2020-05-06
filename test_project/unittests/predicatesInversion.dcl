function UnitTest:EN:predicatesInversion_describeVariation_increase()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:PredicatesInversion_en
--> isIntentionTest true
--> description "Check the text of the intention describe variation with a cost that increases."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_en;
    LibDocument:Test:buildIntentionForExecution(
        -> LibDocument:DescribeVariation
            --> kpi FINANCIAL_COSTS_KPI
            --> timeMembers yearN
            --> timeMembers yearN_2
            --> options -> LibDocument:DescribeVariationOptions
                --> debug_generateAllVariants true
            ;
            --> dimensionConditions -> List
                --> values conso
            ;
        ;,
        // -2000 → -3000 → -3500 : the value decreases,
        // but its a cost,
        // so we should display absolute values and say it increased
        _EXPECTED_OUTPUTS: {
            "Financial costs climbed (75% since 2016), finishing at $3.5K in 2018",
            "Financial costs climbed by 75% since 2016, finishing at $3.5K in 2018",
            "Financial costs grew (75% since 2016), finishing at $3.5K in 2018",
            "Financial costs grew by 75% since 2016, finishing at $3.5K in 2018",
            "Financial costs increased (75% since 2016), finishing at $3.5K in 2018",
            "Financial costs increased by 75% since 2016, finishing at $3.5K in 2018",
            "Financial costs rose (75% since 2016), finishing at $3.5K in 2018",
            "Financial costs rose by 75% since 2016, finishing at $3.5K in 2018"
        }
    );
};

function UnitTest:EN:predicatesInversion_describeVariation_decrease()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:PredicatesInversion_en
--> isIntentionTest true
--> description "Check the text of the intention describe variation with a cost that decreases."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_en;
    LibDocument:Test:buildIntentionForExecution(
        -> LibDocument:DescribeVariation
            --> kpi NON_RECURRING_EXPENSES_KPI
            --> timeMembers yearN
            --> timeMembers yearN_2
            --> options -> LibDocument:DescribeVariationOptions
                --> debug_generateAllVariants true
            ;
            --> dimensionConditions -> List
                --> values conso
            ;
        ;,
        // -6000 → -3000 → -2500 : the value increases,
        // but its a cost,
        // so we should display absolute values and say it decreased
        _EXPECTED_OUTPUTS: {
            "Non recurring expenses declined (58.3% since 2016), finishing at $2.5K in 2018",
            "Non recurring expenses declined by 58.3% since 2016, finishing at $2.5K in 2018",
            "Non recurring expenses decreased (58.3% since 2016), finishing at $2.5K in 2018",
            "Non recurring expenses decreased by 58.3% since 2016, finishing at $2.5K in 2018",
            "Non recurring expenses dropped (58.3% since 2016), finishing at $2.5K in 2018",
            "Non recurring expenses dropped by 58.3% since 2016, finishing at $2.5K in 2018",
            "Non recurring expenses fell (58.3% since 2016), finishing at $2.5K in 2018",
            "Non recurring expenses fell by 58.3% since 2016, finishing at $2.5K in 2018",
            "Non recurring expenses went down (58.3% since 2016), finishing at $2.5K in 2018",
            "Non recurring expenses went down by 58.3% since 2016, finishing at $2.5K in 2018"
        }
    );
};

function UnitTest:EN:predicatesInversion_describeVariationContributors()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:PredicatesInversion_en
--> isIntentionTest true
--> description "Check the text of the intention describe variation contributors with a cost contributor."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_en;
    LibDocument:Test:buildIntentionForExecution(
        -> LibDocument:DescribeVariationContributors
            --> kpi FINANCIAL_RESULT_KPI
            --> timeMembers yearN
            --> timeMembers yearN_2
            --> options -> LibDocument:DescribeVariationContributorsOptions
                --> debug_generateAllVariants false
                --> numberOfContributors 2
                --> maxVariants 0
                --> maxVariantsByContributor 0
            ;
            --> dimensionConditions -> List
                --> values conso
            ;
        ;,
        // Financial cost went from -2000 to -3500 → the cost increased
        // Financial income went from 8500 to 7500 → the income decreased
        _EXPECTED_OUTPUTS: {
            "Financial result went down by 38.5% since 2016, finishing at $4K in 2018 on an increase of financial costs of 75% and a decrease of financial income of 11.8%."
        }
    );
};

function UnitTest:EN:predicatesInversion_describeVariationContributors_valueChange()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:PredicatesInversion_en
--> isIntentionTest true
--> description "Check the text of the intention describe variation contributors with a cost contributor."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_en;
    LibDocument:Test:buildIntentionForExecution(
        -> LibDocument:DescribeVariationContributors
            --> kpi FINANCIAL_RESULT_KPI
            --> timeMembers yearN
            --> timeMembers yearN_2
            --> options -> LibDocument:DescribeVariationContributorsOptions
                --> debug_generateAllVariants false
                --> numberOfContributors 2
                --> showContributorsPercentChange false
                --> showContributorsValueChange true
                --> maxVariants 0
                --> maxVariantsByContributor 0
            ;
            --> dimensionConditions -> List
                --> values conso
            ;
        ;,
        // Financial cost went from -2000 to -3500 → the cost increased
        // Financial income went from 8500 to 7500 → the income decreased
        _EXPECTED_OUTPUTS: {
            "Financial result went down by 38.5% since 2016, finishing at $4K in 2018 on an increase of financial costs of $1.50K and a decrease of financial income of $1K."
        }
    );
};

function UnitTest:FR:predicatesInversion_describeVariation_increase()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:PredicatesInversion_fr
--> isIntentionTest true
--> description "Check the text of the intention describe variation with a cost that increases."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        -> LibDocument:DescribeVariation
            --> kpi FINANCIAL_COSTS_KPI
            --> timeMembers yearN
            --> timeMembers yearN_2
            --> options -> LibDocument:DescribeVariationOptions
                --> debug_generateAllVariants true
            ;
            --> dimensionConditions -> List
                --> values conso
            ;
        ;,
        // -2000 → -3000 → -3500 : the value decreases,
        // but its a cost,
        // so we should display absolute values and say it increased
        _EXPECTED_OUTPUTS: {
            "Les charges financières ont augmenté de 75 % par rapport à 2016, finissant à 3,5 K$ en 2018",
            "Les charges financières ont augmenté de 75 % par rapport à 2016, s'établissant à 3,5 K$ en 2018",
            "Les charges financières ont augmenté de 75 % par rapport à 2016, terminant à 3,5 K$ en 2018",
            "Les charges financières se sont alourdies de 75 % par rapport à 2016, finissant à 3,5 K$ en 2018",
            "Les charges financières se sont alourdies de 75 % par rapport à 2016, s'établissant à 3,5 K$ en 2018",
            "Les charges financières se sont alourdies de 75 % par rapport à 2016, terminant à 3,5 K$ en 2018"
        }
    );
};

function UnitTest:FR:predicatesInversion_describeVariation_decrease()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:PredicatesInversion_fr
--> isIntentionTest true
--> description "Check the text of the intention describe variation with a cost that decreases."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        -> LibDocument:DescribeVariation
            --> kpi NON_RECURRING_EXPENSES_KPI
            --> timeMembers yearN
            --> timeMembers yearN_2
            --> options -> LibDocument:DescribeVariationOptions
                --> debug_generateAllVariants true
            ;
            --> dimensionConditions -> List
                --> values conso
            ;
        ;,
        // -6000 → -3000 → -2500 : the value increases,
        // but its a cost,
        // so we should display absolute values and say it decreased
        _EXPECTED_OUTPUTS: {
            "Les charges exceptionnelles enregistrent une baisse de 58,3 % par rapport à 2016, finissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles enregistrent une baisse de 58,3 % par rapport à 2016, s'établissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles enregistrent une baisse de 58,3 % par rapport à 2016, terminant à 2,5 K$ en 2018",
            "Les charges exceptionnelles ont baissé de 58,3 % par rapport à 2016, finissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles ont baissé de 58,3 % par rapport à 2016, s'établissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles ont baissé de 58,3 % par rapport à 2016, terminant à 2,5 K$ en 2018",
            "Les charges exceptionnelles ont chuté de 58,3 % par rapport à 2016, finissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles ont chuté de 58,3 % par rapport à 2016, s'établissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles ont chuté de 58,3 % par rapport à 2016, terminant à 2,5 K$ en 2018",
            "Les charges exceptionnelles ont diminué de 58,3 % par rapport à 2016, finissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles ont diminué de 58,3 % par rapport à 2016, s'établissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles ont diminué de 58,3 % par rapport à 2016, terminant à 2,5 K$ en 2018",
            "Les charges exceptionnelles sont en baisse de 58,3 % par rapport à 2016, finissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles sont en baisse de 58,3 % par rapport à 2016, s'établissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles sont en baisse de 58,3 % par rapport à 2016, terminant à 2,5 K$ en 2018",
            "Les charges exceptionnelles sont en retrait de 58,3 % par rapport à 2016, finissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles sont en retrait de 58,3 % par rapport à 2016, s'établissant à 2,5 K$ en 2018",
            "Les charges exceptionnelles sont en retrait de 58,3 % par rapport à 2016, terminant à 2,5 K$ en 2018"
        }
    );
};

function UnitTest:FR:predicatesInversion_describeVariationContributors()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:PredicatesInversion_fr
--> isIntentionTest true
--> description "Check the text of the intention describe variation contributors with a cost contributor."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        -> LibDocument:DescribeVariationContributors
            --> kpi FINANCIAL_RESULT_KPI
            --> timeMembers yearN
            --> timeMembers yearN_2
            --> options -> LibDocument:DescribeVariationContributorsOptions
                --> debug_generateAllVariants false
                --> numberOfContributors 2
                --> maxVariants 0
                --> maxVariantsByContributor 0
            ;
            --> dimensionConditions -> List
                --> values conso
            ;
        ;,
        // Financial cost went from -2000 to -3500 → the cost increased
        // Financial income went from 8500 to 7500 → the income decreased
        _EXPECTED_OUTPUTS: {
            "Le résultat financier enregistre une baisse de 38,5 % par rapport à 2016, finissant à 4 K$ en 2018, étant donné que les charges financières se sont alourdies de 75 %. Aussi, les produits financiers ont régressé de 11,8 %."
        }
    );
};

function UnitTest:FR:predicatesInversion_describeVariationContributors_valueChange()
--> domains Void
--> unitTest false
--> testSuiteId TestSuite:PredicatesInversion_fr
--> isIntentionTest true
--> description "Check the text of the intention describe variation contributors with a cost contributor."
--> action
{
    TEXT_PARAM_CONTEXT.kBLanguage = LANG_fr;
    LibDocument:Test:buildIntentionForExecution(
        -> LibDocument:DescribeVariationContributors
            --> kpi FINANCIAL_RESULT_KPI
            --> timeMembers yearN
            --> timeMembers yearN_2
            --> options -> LibDocument:DescribeVariationContributorsOptions
                --> debug_generateAllVariants false
                --> numberOfContributors 2
                --> showContributorsPercentChange false
                --> showContributorsValueChange true
                --> maxVariants 0
                --> maxVariantsByContributor 0
            ;
            --> dimensionConditions -> List
                --> values conso
            ;
        ;,
        // Financial cost went from -2000 to -3500 → the cost increased
        // Financial income went from 8500 to 7500 → the income decreased
        _EXPECTED_OUTPUTS: {
            "Le résultat financier enregistre une baisse de 38,5 % par rapport à 2016, finissant à 4 K$ en 2018, étant donné que les charges financières se sont alourdies de 1,50 K$. Aussi, les produits financiers ont régressé de 1 K$."
        }
    );
};
