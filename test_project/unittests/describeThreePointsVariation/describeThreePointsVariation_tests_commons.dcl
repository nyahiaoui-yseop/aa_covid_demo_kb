DescribeThreePointsVariation DESCRIBE_THREE_POINTS_VARIATION_BASE
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
    ;
;

// Full increase

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__TAX_ASSETS
--> documentation "DescribeThreePointsVariation for a linear full increase variation"
--> kpi TAX_ASSETS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__FINANCIAL_COSTS
--> documentation "DescribeThreePointsVariation for a full increase variation with acceleration"
--> kpi FINANCIAL_COSTS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__OPERATING_PROFIT
--> documentation "DescribeThreePointsVariation for a full increase variation with deceleration"
--> kpi OPERATING_PROFIT_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

// Full decrease

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__FINANCIAL_INCOME
--> documentation "DescribeThreePointsVariation for a linear full decrease variation"
--> kpi FINANCIAL_INCOME_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__LOANS_AND_BORROWINGS
--> documentation "DescribeThreePointsVariation for a linear full decrease variation with acceleration"
--> kpi LOANS_AND_BORROWINGS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__INTANGIBLE_ASSETS
--> documentation "DescribeThreePointsVariation for a linear full decrease variation with deceleration"
--> kpi INTANGIBLE_ASSETS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;


// Stable

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__PROVISIONS
--> documentation "DescribeThreePointsVariation for a stable variation"
--> kpi PROVISIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

// Stabilisation

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__CASH_GENERATED_FROM_OPERATIONS
--> documentation "DescribeThreePointsVariation for a stabilisation after increase"
--> kpi CASH_GENERATED_FROM_OPERATIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__OTHER_FINANCIAL_DEBTS
--> documentation "DescribeThreePointsVariation for a stabilisation after decrease"
--> kpi OTHER_FINANCIAL_DEBTS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;


// Stable then change

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__DIVIDENDS_PAID
--> documentation "DescribeThreePointsVariation for an increase after stable period"
--> kpi DIVIDENDS_PAID_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__ADMINISTRATIVE_EXPENSES_KPI
--> documentation "DescribeThreePointsVariation for a decrease after stable period"
--> kpi ADMINISTRATIVE_EXPENSES_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

// Contrary variations

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__SHARE_CAPITAL
--> documentation "DescribeThreePointsVariation for an increase then decrease"
--> kpi SHARE_CAPITAL_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__PAYMENT_TO_EMPLOYEES
--> documentation "DescribeThreePointsVariation for a decrease then increase"
--> kpi PAYMENT_TO_EMPLOYEES_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;


//---- Options

// No first period

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__FINANCIAL_INCOME_NO_FIRST_PERIOD
--> documentation "DescribeThreePointsVariation for a linear full decrease variation without showing first period"
--> kpi FINANCIAL_INCOME_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_FIRST_PERIOD
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__PROVISIONS_NO_FIRST_PERIOD
--> documentation "DescribeThreePointsVariation for a stable variation without showing first period"
--> kpi PROVISIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_FIRST_PERIOD
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__CASH_NO_FIRST_PERIOD
--> documentation "DescribeThreePointsVariation for a stabilisation after increase without showing first period"
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_FIRST_PERIOD
--> kpi CASH_GENERATED_FROM_OPERATIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__DIVIDENDS_PAID_NO_FIRST_PERIOD
--> documentation "DescribeThreePointsVariation for an increase after stable period without showing first period"
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_FIRST_PERIOD
--> kpi DIVIDENDS_PAID_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__SHARE_CAPITAL_NO_FIRST_PERIOD
--> documentation "DescribeThreePointsVariation for an increase then decrease without showing first period"
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_FIRST_PERIOD
--> kpi SHARE_CAPITAL_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

// No last period

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__FINANCIAL_INCOME_NO_LAST_PERIOD
--> documentation "DescribeThreePointsVariation for a linear full decrease variation without showing last period"
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_LAST_PERIOD
--> kpi FINANCIAL_INCOME_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__PROVISIONS_NO_LAST_PERIOD
--> documentation "DescribeThreePointsVariation for a stable variation without showing last period"
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_LAST_PERIOD
--> kpi PROVISIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__CASH_NO_LAST_PERIOD
--> documentation "DescribeThreePointsVariation for a stabilisation after increase without showing last period"
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_LAST_PERIOD
--> kpi CASH_GENERATED_FROM_OPERATIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__DIVIDENDS_PAID_NO_LAST_PERIOD
--> documentation "DescribeThreePointsVariation for an increase after stable period without showing last period"
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_LAST_PERIOD
--> kpi DIVIDENDS_PAID_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__SHARE_CAPITAL_NO_LAST_PERIOD
--> documentation "DescribeThreePointsVariation for an increase then decrease without showing last period"
--> options DESCRVAR_THREEPOINTS_OPTIONS_NO_LAST_PERIOD
--> kpi SHARE_CAPITAL_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;


// Change as value

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__FINANCIAL_INCOME_SHOW_VALUE
--> documentation "DescribeThreePointsVariation for a linear full decrease variation showing change as value"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_VALUE
--> kpi FINANCIAL_INCOME_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__PROVISIONS_SHOW_VALUE
--> documentation "DescribeThreePointsVariation for a stable variation showing change as value"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_VALUE
--> kpi PROVISIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__CASH_SHOW_VALUE
--> documentation "DescribeThreePointsVariation for a stabilisation after increase showing change as value"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_VALUE
--> kpi CASH_GENERATED_FROM_OPERATIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__DIVIDENDS_PAID_SHOW_VALUE
--> documentation "DescribeThreePointsVariation for an increase after stable period showing change as value"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_VALUE
--> kpi DIVIDENDS_PAID_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__SHARE_CAPITAL_SHOW_VALUE
--> documentation "DescribeThreePointsVariation for an increase then decrease showing change as value"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_VALUE
--> kpi SHARE_CAPITAL_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;


// Show no change

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__FINANCIAL_INCOME_SHOW_NO_CHANGE
--> documentation "DescribeThreePointsVariation for a linear full decrease variation without showing change"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_NO_CHANGE
--> kpi FINANCIAL_INCOME_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__PROVISIONS_SHOW_NO_CHANGE
--> documentation "DescribeThreePointsVariation for a stable variation without showing change"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_NO_CHANGE
--> kpi PROVISIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__CASH_SHOW_NO_CHANGE
--> documentation "DescribeThreePointsVariation for a stabilisation after increase without showing change"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_NO_CHANGE
--> kpi CASH_GENERATED_FROM_OPERATIONS_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__DIVIDENDS_PAID_SHOW_NO_CHANGE
--> documentation "DescribeThreePointsVariation for an increase after stable period without showing change"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_NO_CHANGE
--> kpi DIVIDENDS_PAID_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__SHARE_CAPITAL_SHOW_NO_CHANGE
--> documentation "DescribeThreePointsVariation for an increase then decrease without showing change"
--> options DESCRVAR_THREEPOINTS_OPTIONS_SHOW_NO_CHANGE
--> kpi SHARE_CAPITAL_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> dimensionConditions -> List
    --> values conso
;
;

// Particular Variations

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__VARIATION_TO_0
--> documentation "DescribeThreePointsVariation for a variation finishing at 0"
--> kpi PROPERTY_PLANT_AND_EQUIPMENT_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options -> DescribeThreePointsVariationOptions
    --> maxVariants 0
    ;
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__VARIATION_FROM_0
--> documentation "DescribeThreePointsVariation for a variation starting at 0"
--> kpi INTEREST_PAID_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__NEGATIVE_TO_POSITIVE
--> documentation "DescribeThreePointsVariation for a variation from negative to positive"
--> kpi ADJUSTING_ACCOUNT_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;

DescribeThreePointsVariation DESCRVAR_THREE_POINTS__POSITIVE_TO_NEGATIVE
--> documentation "DescribeThreePointsVariation for a variation from positive to negative"
--> kpi ADMINISTRATIVE_EXPENSES_KPI
--> timeMembers yearN_2
--> timeMembers yearN
--> options DESCRVAR_THREEPOINTS_OPTIONS
--> dimensionConditions -> List
    --> values conso
;
;
