// Used directly by the framework workflow after having the cube completed and right before it handles the intentions.
function onDialogTransitionTaskBeforeIntentionStep()
--> action {
    FinancialAnalysis:copyTextSections();
}
;

function onDialogTransitionTaskAfterIntentionStep()
--> action {
    if(getGeneralData().forceGenerateAllVariants == true) {
        foreach(_options, LibDocument:IntentionOptions) {
            _options.debug_generateAllVariants = true;
        }
    }
}
;

function runAfterXMLReading()
--> domains Void
--> action {
    // Enrich the indicators / KPIs not handled by the ontology.
    // This is project specific.
    enrichIndicators();
    // We will use the AFA_ROOT_CONFIG as customRootConfiguration
    getGeneralData().customRootConfiguration = AFA_ROOT_CONFIG;
}
;

function runProcessingTasks()
--> domains Void
--> action
{
    // ...
}
;
