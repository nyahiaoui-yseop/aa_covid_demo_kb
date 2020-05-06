// @alacambre Some interesting stuff here that should go in the framework.

complete LibDocument:Intention

    method initSemanticSlotCustomText
    args {
        LibDocument:SemanticSlot semanticSlot
        LibDocument:DynamicCustomTexts dynamicCustomTexts
    } function
    --> domains Void

;

Function LibDocument:Intention::initSemanticSlotCustomText
args {
    LibDocument:SemanticSlot semanticSlot
    LibDocument:DynamicCustomTexts dynamicCustomTexts
}
--> documentation """Set the dynamic custom text for the the specified semantic slot it it hasn't any value mapped to it yet. If not existing, initialises `customConceptConfiguration` before this process.

- @param `semanticSlot` The semantic slot to init.
- @param `dynamicCustomTexts` The custom text to map to this semantic slot.
"""
--> action {
    if(this.customConceptsConfiguration == null) {
        this.customConceptsConfiguration = new(LibDocument:CustomConceptsConfiguration);
    }
    if (this.customConceptsConfiguration.configValues[semanticSlot] == null) {
        this.customConceptsConfiguration.configValues[semanticSlot] = dynamicCustomTexts;
    }
}
;
