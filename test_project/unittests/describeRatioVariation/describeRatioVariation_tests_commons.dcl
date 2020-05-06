DescribeRatioVariation DESCRIBE_RATIO_VARIATION_DECREASE
--> documentation """Intention for tests to display ratio variation (decrease)"""
--> timeMembers yearN_1
--> timeMembers yearN
--> kpi EBITDA_KPI
--> denominatorKPI SALES_KPI
--> options DESCRVAR_RATIO_BASE_OPTIONS
--> dimensionConditions -> List
    --> values conso
    ;
;

DescribeRatioVariation DESCRIBE_RATIO_VARIATION_INCREASE
--> documentation """Intention for tests to display ratio variation (increase)"""
--> timeMembers yearN_2
--> timeMembers yearN_1
--> kpi EBITDA_KPI
--> denominatorKPI SALES_KPI
--> options DESCRVAR_RATIO_BASE_OPTIONS
--> dimensionConditions -> List
    --> values conso
    ;
;

DescribeRatioVariation DESCRIBE_RATIO_VARIATION_STABLE
--> documentation """Intention for tests to display ratio variation (stable)"""
--> timeMembers yearN_2
--> timeMembers yearN_1
--> kpi TOTAL_EQUITY_KPI
--> denominatorKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
--> options DESCRVAR_RATIO_BASE_OPTIONS
--> dimensionConditions -> List
    --> values conso
    ;
;

DescribeRatioVariation DESCRIBE_RATIO_VARIATION_SHOW_RELATIVE_CHANGE
--> documentation """Intention for tests to display ratio variation as a relative change"""
--> timeMembers yearN_1
--> timeMembers yearN
--> kpi TOTAL_EQUITY_KPI
--> denominatorKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
--> options DESCRVAR_RATIO_OPTIONS_SHOW_PERCENT_CHANGE_OPTIONS
--> dimensionConditions -> List
    --> values conso
    ;
;

DescribeRatioVariation_to_SALES DESCRIBE_RATIO_VARIATION_PROFIT_MARGIN
--> documentation """Intention for tests of ratio for NET_EARNINGS to SALES"""
--> timeMembers yearN_1
--> timeMembers yearN
--> kpi NET_EARNINGS_KPI
--> options DESCRVAR_RATIO_BASE_OPTIONS
--> dimensionConditions -> List
    --> values conso
    ;
;

DescribeRatioVariation_to_TOTAL_EQUITY DESCRIBE_RATIO_VARIATION_GEARING
--> documentation """Intention for tests of ratio for """
--> timeMembers yearN_1
--> timeMembers yearN
--> kpi FINANCIAL_LIABILITIES_KPI
--> options DESCRVAR_RATIO_BASE_OPTIONS
--> dimensionConditions -> List
    --> values conso
    ;
;

DescribeRatioVariation_to_TOTAL_EQUITY AAS71
--> timeMembers yearN_2
--> timeMembers yearN
--> kpi -> LibDocument:KeyPerformanceIndicator TRADE_AND_OTHER_PAYABLES_KPI
    --> indicator TRADE_AND_OTHER_PAYABLES
    --> measure MEASURE_VALUE
;
--> dimensionConditions -> List
;
--> options DESCRVAR_RATIO_BASE_OPTIONS
;
