// Avoid warning.
complete Tree
    --> trackInstances true
;

complete LibCube:IndicatorMember

    field category
    --> domains Finance:Category
    --> documentation """Category for this indicator in the financial environment."""
	field accountingFramework
    --> domains AccountingFramework
    --> multivalued true
    --> documentation """The Accounting framework(s) using this indicator."""
;

complete LibDocument:TextSection
    field loopOver
    --> domains LibCube:JointureDimensionCondition
    --> documentation """Use this to tell that this TextSection should be duplicated and used for a specific dimension from a specific member.

For example using DIMENSION_COUNTRY / EUROPE will find all the members in DIMENSION_COUNTRY that are under EUROPE (probably countries here) and duplicates itself for each of them. A dimensionCondition will be automatically added so that the correct LibCube:JointureDimensionCondition is applied to each new TextSection's intentions.
    """
;
