function buildComputedValue
args {
    Object value
    LibDocument:IntentionRole role
    LibDocument:CalculationType calculationType
    LibDocument:Entity ownerEntity
    --> nullable true
}
local {
    LibDocument:ComputedValue currentComputedValue
}
--> documentation """Create a new computed value.

- @param `value` The value that will be encapsulated.
- @param `role` The role of this value. `LibDocument:IntentionRole::Root` most of the time.
- @param `calculationType` The type of computations that can be done on this value.
- @param `ownerEntity` The entity that _owns_ the value. Most of the time it is an indicator.

@return A computed value object.

"""
--> domains LibDocument:ComputedValue
--> action {
    currentComputedValue = new(LibDocument:ComputedValue);
    currentComputedValue.calculationType = calculationType;
    currentComputedValue.setValue(value);
    currentComputedValue.setRole(role);
    if(ownerEntity != null) {
        currentComputedValue.owners.add(ownerEntity);
    }
    return currentComputedValue;

};

function buildComputedDateValue
args {
    Object value
    LibDocument:IntentionRole role
    LibDocument:CalculationType calculationType
    LibDocument:Entity ownerEntity
    --> nullable true
    LibCube:TimePeriod period
}
local {
    LibDocument:ComputedValue currentComputedValue
}
--> documentation """Create a new computed date value.

- @param `value` The value that will be encapsulated.
- @param `role` The role of this value. `LibDocument:IntentionRole::Root` most of the time.
- @param `calculationType` The type of computations that can be done on this value.
- @param `ownerEntity` The entity that _owns_ the value. Most of the time it is an indicator.
- @param `period` The period used by the date.

@return A computed value date object.

"""
--> domains LibDocument:ComputedValue
--> action {
    currentComputedValue = new(LibDocument:ComputedDateValue);
    currentComputedValue.calculationType = calculationType;
    currentComputedValue.setValue(value);
    currentComputedValue.setRole(role);
    if(ownerEntity != null) {
        currentComputedValue.owners.add(ownerEntity);
    }
    currentComputedValue.setPeriod(period);
    currentComputedValue.setDateDefaultStyle();
    return currentComputedValue;

};

