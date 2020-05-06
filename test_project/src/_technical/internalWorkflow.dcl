//@defineValue _STEPS_MODE  _FORM   //_DYNAMIC //

/* _FORM : use this if you have few steps and the flow is already defined  - the corresponding dialog step can be found in _technical:dialogStepsForm.yml
   _DYNAMIC: use this if you have too many steps to organize
	 or you only know a global theme order  - the corresponding dialog step can be found in _technical:dialogStepsDynamic.yml
*/

complete PROCESSING_STEPS_ENTRY_POINTS
    --> onDialogTransitionTaskAfterIntentionStep onDialogTransitionTaskAfterIntentionStep
    --> onDialogTransitionTaskBeforeIntentionStep onDialogTransitionTaskBeforeIntentionStep
;

// ========================================================================
// ==========  Entry points in the Yseop Engine internal workflow  ========
// ========================================================================

complete REQUEST_MANAGER

// --------------------------------
// -----  serverInit
// --------------------------------

//--> serverInit { include code here }


// --------------------------------
// ----- actionBeforeXmlReading
// --------------------------------

--> actionBeforeXmlReading {
	//The Web Service will generate yid and yclass, such as <measure yclass="LibCube:Measure" yid="MEASURE_FINAL_VALUE">. This is to supress the warning.
	XML_PARAM_CONTEXT.ifUnnecessaryYclass = _IGNORE;
    PROCESSING_STEPS_ENTRY_POINTS.onDialogTransitionTaskAfterIntentionStep = onDialogTransitionTaskAfterIntentionStep;
    PROCESSING_STEPS_ENTRY_POINTS.onDialogTransitionTaskBeforeIntentionStep = onDialogTransitionTaskBeforeIntentionStep;
}

// --------------------------------
// ----- actionAfterXmlReading
// --------------------------------

--> actionAfterXmlReading {
    logInfo("actionAfterXmlReading");
    // -------------------------------------
    // ----- technical initializations
    // -------------------------------------


    // patch #586 - not sure if it is still necessary
    RULES_PARAM_CONTEXT.updateAfterDeletion = false;

    @remark "rules trigger to be plugged again. or not"
    //RULES_PARAM_CONTEXT.startTrigger(getSuiveurRegles());

    // initializes getGeneralData() !
    LibReportingFramework:CONFIG.generalData = theGeneralData;
    REQUEST_MANAGER.data = null;
    if(getGeneralData().language != null) {
        TEXT_PARAM_CONTEXT.kBLanguage = getGeneralData().language;
    }
    else {
        TEXT_PARAM_CONTEXT.kBLanguage = LANG_en;
    }

    TEXT_PARAM_CONTEXT.ifNotXmlWellFormedWritten = _WARNING;


    // -------------------------------------
    // ----- data specific initialization
    // -------------------------------------

    // include code here on specific data initialisation

    // -------------------------------------
    // ----- dialog specific initialization
    // -------------------------------------

    // INITIALIZING DIALOG
    //might be deleted - need to be checked
    runAfterXMLReading();
    DIALOG_MANAGER.openDialog();
    if(getGeneralData().runUnitTests == true){
        getGeneralData().finalDialogStep = _INTENTION_UNIT_TEST;
        YmlUnit:runUnitTests(TEST_SUITE: getGeneralData().testSuiteId);
        getGeneralData().dialogTestManager.functionList =  LibDocument:Test:collectIntentionTests(TEST_SUITE: theGeneralData.testSuiteId);
        DIALOG_MANAGER.initStep = _INIT_UNIT_TEST;
    }
    else{
        getGeneralData().finalDialogStep = _TEXT_GENERATION;
        DIALOG_MANAGER.initStep = _DIALOG_STEPS;
    }
    DIALOG_MANAGER.closeDialog();
    // -------------------------------------
    // ----- global properties settings
    // -------------------------------------

}

// --------------------------------
// ----- actionAfterXmlWriting
// --------------------------------

//--> actionAfterXmlWriting { include code here }
/*
--> outputText
	-> DialogText
		--> xmlAttributes {"id", "finalDocument"}
	;
*/
;
