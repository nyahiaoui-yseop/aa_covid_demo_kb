// @alacambre Collection of functions because there is no way to get already computed values.

Variable significatifValeurDeReference
--> documentation """significatif par rapport à la valeur de référence"""
--> value 0.2
--> domains Number
;

Variable significatifVariation
--> documentation """significatif de part sa variation"""
--> value 0.15
--> domains Number
;

Variable variationConsideredStable
--> documentation """variation considérée comme stable"""
--> value 0.03
--> domains Number
;

Function getFactByEntity
args {
    LibCube:JointureFactsSelection factsSelection
    LibCube:Member entity
}
--> domains LibCube:Fact
--> action {

    foreach(_fact , factsSelection>>selectedFacts) {
        if(_fact.getMember(DIMENSION_ENTITY) == entity) {
            return _fact;
        }
    }

    return null;

};

Function getDescribeValueCurrentValue
args {
    LibDocument:DescribeValue dValue
}
--> domains Number
--> action {

    if (dValue == null || dValue.computedValues == null) {
        return null;
    } else {
        return dValue.computedValues.getValue(ComputedValueKey:CURRENT_VALUE).getValueAsNumber();
    }

};

Function getDescribeVariationCurrentValue
args {
    LibDocument:DescribeVariation dVariation
}
--> domains Number
--> action {

    if (dVariation == null || dVariation.computedValues == null) {
        return null;
    } else {
        return dVariation.computedValues.getValue(ComputedValueKey:CURRENT_VALUE).getValueAsNumber();
    }

};

Function getDescribeVariationPreviousValue
args {
    LibDocument:DescribeVariation dVariation
}
--> domains Number
--> action {

    if (dVariation == null || dVariation.computedValues == null) {
        return null;
    } else {
        return dVariation.computedValues.getValue(ComputedValueKey:PREVIOUS_VALUE).getValueAsNumber();
    }

};

Function getDescribeVariationCalculatedAbsoluteDifference
args {
    LibDocument:DescribeVariation dVariation
}
--> domains Number
--> action {

    if (dVariation == null || dVariation.computedValues == null) {
        return null;
    } else {
        return dVariation.computedValues.getValue(ComputedValueKey:CALCULATED_ABSOLUTE_DIFFERENCE).getValueAsNumber();
    }

};

Function getDescribeVariationCalculatedRelativeChange
args {
    LibDocument:DescribeVariation dVariation
}
--> domains Number
--> action {

    if (dVariation == null || dVariation.computedValues == null) {
        return null;
    } else {
        return dVariation.computedValues.getValue(ComputedValueKey:CALCULATED_RELATIVE_CHANGE).getValueAsNumber();
    }

};

Function getJointureOneFactValue
args {
    LibCube:JointureOneFactSelection oneFactSelection
}
--> domains Number
--> action {

    if (oneFactSelection == null || oneFactSelection.selectedFact == null || oneFactSelection.selectedFact.getMeasureValue() == null){
        return null;
    } else {
        return oneFactSelection.selectedFact.getMeasureValue().value;
    }

};

Function getJointureFactsValueByEntity
args {
    LibCube:JointureFactsSelection factsSelection
    LibCube:Member entity
}
local {
    LibCube:Fact fact
}
--> domains Number
--> action {

    fact = getFactByEntity(factsSelection, entity);
    if (fact == null || fact.getMeasureValue() == null){
        return null;
    } else {
        return fact.getMeasureValue().value;
    }

};

// Two Describe Variations are sent
Function significantIndicatorIS
args {
	LibDocument:DescribeVariation dVariationToCompare
	LibDocument:DescribeVariation dVariationReference
}
--> domains Boolean
--> action {

    if (dVariationToCompare == null || dVariationReference == null) {
        return null;
    }

    if ((
            getDescribeVariationCurrentValue(dVariationToCompare) > significatifValeurDeReference * getDescribeVariationCurrentValue(dVariationReference)
            && getDescribeVariationCalculatedRelativeChange(dVariationToCompare) > significatifVariation
        ) || (
            getDescribeVariationCurrentValue(dVariationToCompare) > significatifValeurDeReference * getDescribeVariationCurrentValue(dVariationReference)
            && getDescribeVariationCalculatedRelativeChange(dVariationToCompare) > getDescribeVariationCalculatedRelativeChange(dVariationReference)
            )
        ) {
        return true;
    } else {
        return false;
    }
};

// One Describe Variation and one Describe Value
Function significantIndicatorDebt
args {
	LibDocument:DescribeVariation dVariationToCompare
	LibDocument:DescribeValue || Number valueReference
}
local {
    Number numberValueReference
}
--> domains Boolean
--> action {

    if (dVariationToCompare == null || valueReference == null) {
        return null;
    }

    if (valueReference.isInstanceOf(LibDocument:DescribeValue) == true) {
        numberValueReference = getDescribeValueCurrentValue(valueReference);
    } else {
        numberValueReference = valueReference;
    }

    if ((getDescribeVariationCurrentValue(dVariationToCompare) > significatifValeurDeReference * numberValueReference)
            && (getDescribeVariationCalculatedRelativeChange(dVariationToCompare) > significatifVariation)) {
        return true;
    }
    if ((getDescribeVariationCurrentValue(dVariationToCompare) > 0.3 * numberValueReference)
        && (getDescribeVariationCalculatedRelativeChange(dVariationToCompare) > 0.1)) {
        return true;
    }
    return false;

};

// R9
// One Describe Variation and one Describe Value
Function significantIndicatorSocialActif
args {
	LibDocument:DescribeVariation dVariationToCompare
	Variation referenceVariation
}
--> domains Boolean
--> action {

    return (
        getDescribeVariationCalculatedRelativeChange(dVariationToCompare) > 0.3
        && getDescribeVariationCurrentValue(dVariationToCompare) > 0.2 * referenceVariation.endValue
    ).check();

};

// One Describe Variation and one Describe Value
Function significantIndicatorCF
args {
	LibCube:JointureOneFactSelection oneFactSelectionReference
	LibDocument:DescribeVariation dVariationToCompare
}
--> domains Boolean
--> action {
    return (
        abs(getDescribeVariationCurrentValue(dVariationToCompare)) >
        0.15 * abs(getJointureOneFactValue(oneFactSelectionReference))
    ).check();

};

Function getVariationFromJointures
args {
    LibCube:JointureFactsSelection endFactsSelection
    LibCube:JointureFactsSelection startFactsSelection
    LibCube:IndicatorMember entity
}
local {
    LibCube:Fact endFact
    LibCube:Fact startFact
    LibCube:TwoFactsOneMeasureComparison comparison
}
--> domains Number
--> action {
    endFact = getFactByEntity(endFactsSelection, entity);
    startFact = getFactByEntity(startFactsSelection, entity);

    if(endFact != null && startFact != null) {
        comparison = getFactsComparison(endFact, startFact, MEASURE_VALUE);
        return comparison.relativeChange;
    } else {
        return null;
    }
};

Function getVariation
args {
    Number endValue
    Number startValue
}
local {
    Number tmpVar
}
--> documentation "Get the absolute value of a variation precentage between two values."
--> domains Number
--> action {
    tmpVar = (endValue - startValue) / startValue;
    if (startValue > 0) {
        return tmpVar;
    } else {
        return - tmpVar;
    }
};

Function getVariationLevel
args {
    Number variation
}
--> documentation "Gives a specific meaning to a variation (INCREASE − STABLE − DECREASE)."
// --> domains ThreeLevelVariation
--> action {
//   if(variation >= variationConsideredStable) {
//     return ThreeLevelVariation::INCREASE;
//   }

//   if(variation > - variationConsideredStable
//     && variation < variationConsideredStable) {
//     return ThreeLevelVariation::STABLE;
//   }

//   if(variation <= - variationConsideredStable) {
//     return ThreeLevelVariation::DECREASE;
//   }

//   return null;
};

Function updateTable
args {
    LibDocument:CubeToTable table
    LibDocument:KeyPerformanceIndicator kpi
    LibDocument:KeyPerformanceIndicator beforeKpi
}
local {
    Boolean toAdd
}
--> domains Void
--> action {
    toAdd = false;

    // If the table does not already contain the KPI
    if(table.kpis.contains(kpi) == false) {
        toAdd = true;
    }

    // Special case for consoIncomeStatementTable
    // Do not add to much significant indicators

    /* // @alacambre Business specific case
    if(table == consoIncomeStatementTable
        && kpi != tableKpiREXCEP
        && table.kpis.size() >= 10) {
        toAdd = false;
    }
    */

    if(toAdd == true) {
        table.kpis.add(kpi, _BEFORE, beforeKpi);
        table.isInitialized = false;
        table.selections = new(HashMap);
        table.initTableFactsSelections();
    }
};

// use extern because this function is recursive
extern function FinancialAnalysis:copyTextSection
args {
    LibDocument:TextSection section
};

function FinancialAnalysis:copyTextSection
args {
    LibDocument:TextSection section
}
local {
    LibDocument:TextSection currentClone
    LibCube:Hierarchy dimFirstHierarchy
    Collection hierarchyChildren
    Collection newComponents
    LibCube:JointureDimensionCondition condition
    Collection copyOfTextSection
}
--> domains Collection
--> documentation """If required returns a collection of TextSection that are copies of `section` but used for a specific dimension's member children.

For example using DIMENSION_COUNTRY / EUROPE will find all the members in DIMENSION_COUNTRY that are under EUROPE (probably countries here) and duplicates itself for each of them. A dimensionCondition will be automatically added so that the correct LibCube:JointureDimensionCondition is applied to each new TextSection's intentions.
This function is recursive, so each sub TextSection can be duplicated too if required.


If no loop condition is found, this function returns `section` as a single-element list.

@param `section` The TextSection to duplicate.

@return a collection of one or more `TextSection` objects.
"""
--> action {
    if(
        // No need to duplicate the TextSection.
        section.loopOver == null
        // The value of the provided LibCube:JointureDimensionCondition is empty.
        || section.loopOver>>members.isEmpty() ==true
        // The first member in loopOver isn't a Tree but we need to it to be a tree to retrieve the hierarchy.
        || section.loopOver>>members.get(1).isInstanceOf(LibCube:Member) == false
      ) {
        return  {section};
    }
    dimFirstHierarchy = section.loopOver.dimension>>hierarchies.get(1);
    hierarchyChildren = dimFirstHierarchy.getChildren(_PARENT: section.loopOver>>members.get(1));
    copyOfTextSection = new(List);
    foreach(_child, hierarchyChildren) {
        currentClone = section.clone(_DYNAMIC_RECURSIVE);
        newComponents = new(List);
        condition = new(LibCube:JointureDimensionCondition);
        condition.dimension = section.loopOver.dimension;
        condition.members = _child;
        foreach(_component, currentClone.components) {
            if(_component.isInstanceOf(LibDocument:Intention) == true) {
                _component.dimensionConditions = new(List);
                _component.dimensionConditions.add(condition);
                _component.options.writeOwner = true;
            } else if(_component.isInstanceOf(LibDocument:TextSection) == true) {
                LibDocument:TextSection(_component).components = FinancialAnalysis:copyTextSection(_component);
            }
            newComponents.add(_component);
        }
        currentClone.components = newComponents;
        // The workflow can make us come back in this function. Deactivate the loopOver system.
        currentClone.loopOver = null;
        // TODO: remove later.
        currentClone.title = concat("Sub TextSection for SubElement ", _child.extendedIdentifier);
        copyOfTextSection.add(currentClone);
    }
    // The workflow can make us come back in this function. Deactivate the loopOver system.
    section.loopOver = null;
    // In case we found no children.
    if(copyOfTextSection.isEmpty() == true) {
        copyOfTextSection.add(section);
    }
    return copyOfTextSection;
};


function FinancialAnalysis:copyTextSections()
--> domains Void
--> local Collection components
--> documentation """Copy the `TextSection` objects in the rootSection if required."""
--> action {
    components = new(List);
    foreach(_comp, getGeneralData().rootSection.components) {
        if(_comp.isInstanceOf(LibDocument:TextSection) == true) {
            components.addAll(FinancialAnalysis:copyTextSection(_comp));
        } else {
            components.add(_comp);
        }
    }
    getGeneralData().rootSection.components = components;

};
