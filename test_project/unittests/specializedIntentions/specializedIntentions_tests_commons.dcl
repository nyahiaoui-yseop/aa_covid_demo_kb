LibDocument:DescribeVariation DESCRIBE_VARIATION__COST
    --> documentation """Describe the variation of the Administrative expenses over 2016 to 2018. This is a cost that goes from -7500.0 to -5000.0 → it is just a cost decrease."""
    --> timeMembers yearN_2
    --> timeMembers yearN
    --> kpi ADMINISTRATIVE_EXPENSES_KPI
    --> dimensionConditions -> List
        --> values conso
    ;
;

LibDocument:DescribeVariationContributors DESCRIBE_VARIATION_CONTRIBUTORS__COST
    --> documentation """Describe the variation contributors of the Administrative expenses over 2016 to 2018. This is a cost that has no child and that goes from -7500.0 to -5000.0 → it is just a cost decrease."""
    --> timeMembers yearN_2
    --> timeMembers yearN
    --> kpi ADMINISTRATIVE_EXPENSES_KPI
    --> dimensionConditions -> List
        --> values conso
    ;
;

DescribeVariationThreeContributorsBullet DESCRIBE_VARIATION_THREE_CONTRIBUTORS_BULLET__COST
    --> documentation """Describe the variation contributors (as bullet points, up to three) of the Administrative expenses over 2016 to 2018. This is a cost that has no child and that goes from -7500.0 to -5000.0 → it is just a cost decrease."""
    --> timeMembers yearN_2
    --> timeMembers yearN
    --> kpi ADMINISTRATIVE_EXPENSES_KPI
    --> dimensionConditions -> List
        --> values conso
    ;
;
