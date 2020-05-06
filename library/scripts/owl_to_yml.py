from owlready2 import get_ontology, onto_path
import sys, os

"""
Generates YML declarations for AA framework, using Ontology and Owlready2 python-mapping
(see https://owlready2.readthedocs.io/en/latest)

The files are produced in the (hardcoded) "output" sub-directory
"""

script_dir_path = os.path.dirname(sys.argv[0])

# Load Ontology
onto_path.append("%s/../../bootstrap/dialog/ontology" % script_dir_path)
onto = get_ontology("ontology.owl")
onto.load()

OUTPUT_DIR="%s/../lib/FinancialAnalysis" % script_dir_path
OUTPUT_KPI_DIR = OUTPUT_DIR + "/_instances/KeyPerformanceIndicators"
OUTPUT_METADATA_DIR = OUTPUT_DIR + "/_instances/MemberMetaData"
FINANCIAL_INDICATORS = open(OUTPUT_DIR + "/_domainObjects/financial_indicators.dcl", mode="w", encoding="utf8")
FINANCIAL_RELATIONS = open(OUTPUT_DIR + "/_domainObjects/financial_relations.dcl", mode="w", encoding="utf8")
VERB_PREDICATES = open(OUTPUT_DIR + "/_domainObjects/verb_predicates.dcl", mode="w", encoding="utf8")
VERB_NOMINALIZATIONS = open(OUTPUT_DIR + "/_domainObjects/verb_nominalizations.dcl", mode="w", encoding="utf8")
INDICATORS_DOCUMENTATION = open("%s/../../documentation/modules/ROOT/partials/indicators.adoc" % (script_dir_path), mode="w", encoding="utf8")
# global flag to manage the comma-separated list of relations
RELATIONS_HEADER_WRITTEN = False
DESCRIBE_VALUE_INTENTION = "LibDocument:DescribeValue"
DESCRIBE_VARIATION_INTENTION = "LibDocument:DescribeVariation"
DESCRIBE_VARIATION_CONTRIBUTORS_INTENTION = "LibDocument:DescribeVariationContributors"
PREDICATES_BY_CLASSES =  {}
ACCOUNTING_FRAMEWORK_CLASS_MEMBER = "AccountingFramework::"

# mapping of ontology langs to kb langs
SUPPORTED_LANGS = {
    "en" : ["en"],
    "fr" : ["fr"],
    "en_GB": ["en_GB"],
    "en_US": ["en_US"]
}

# constants

SIGNIFICANT_POSITIVE = "LibKPI:SIGNIFICANT_POSITIVE"
POSITIVE = "LibKPI:POSITIVE"
INSIGNIFICANT = "LibKPI:INSIGNIFICANT"
NEGATIVE = "LibKPI:NEGATIVE"
SIGNIFICANT_NEGATIVE = "LibKPI:SIGNIFICANT_NEGATIVE"


def indent(incr_level=1):
    if incr_level <= 1:
        return "\t"
    return "\t" * incr_level

def main():
    # start the documentation in asciidoc
    INDICATORS_DOCUMENTATION.write("[]\n")
    INDICATORS_DOCUMENTATION.write("|===\n")
    INDICATORS_DOCUMENTATION.write("|*Name* | *Variants by language* | *Synonyms by language* | *Frameworks*\n")
    fill_pred_by_classes()
    root = onto.search_one(label="Indicators")
    categories = collect_categories(root)
    for cat in categories:
        collect_hierarchy(cat, cat)
    # Closing the FINANCIAL_RELATIONS file, built recursively, with a semicolon
    FINANCIAL_RELATIONS.write("\n;")
    INDICATORS_DOCUMENTATION.write("|===")


def get_all_subclasses(source, subclasses_list):
    """
    Fill subclasses_list recursively with the current source subclasses.
    """
    for subcl in source.subclasses():
        subclasses_list.append(subcl)
        get_all_subclasses(subcl, subclasses_list)
    return subclasses_list

def fill_pred_by_classes():
    root = onto.search_one(label="Predicates")

    all_verb_predicates = []
    all_verb_nominalizations = []
    for subcl in get_all_subclasses(root, []):
        for instance in subcl.instances():
            for instance_type in filter(lambda x: hasattr(x, "name"), instance.is_a):
                if instance_type.name not in PREDICATES_BY_CLASSES:
                    PREDICATES_BY_CLASSES[instance_type.name] = []
                PREDICATES_BY_CLASSES[instance_type.name].append(instance)
                if instance.hasGrammaticalCategory.first() == "verb" and instance not in all_verb_predicates:
                    all_verb_predicates.append(instance)
                elif instance.hasGrammaticalCategory.first() == "verbNominalization" and instance not in all_verb_nominalizations:
                    all_verb_nominalizations.append(instance)

    for instance in all_verb_predicates:
        write_verb_variant(instance)

    for instance in all_verb_nominalizations:
        write_verb_nominalization_variant(instance)

def collect_categories(root):
    """
    Categories are direct descendants of 'Indicators' node,
    :param root: the Indicators node
    :return: list of categories
    """
    categories = []
    for node in root.subclasses():
        if not node.label[0] == "Other":
            categories.append(node)
    return categories


def collect_hierarchy(category, node):
    """
    browse hierarchy under 'node', produce KPIs for each child
    :param node: root of the hierarchy
    :param node: the Indicator node
    :return: void
    """
    for child in node.subclasses():
        write_financial_indicator(category, child, child.hasStandard)
        # We do not want to create a relation for nodes which are categories
        if node != category:
            write_financial_relation(node, child)
        create_kpi(child)
        create_metadata(child)
        collect_hierarchy(category, child)

def write_financial_indicator(category, node, standards):
    FINANCIAL_INDICATORS.write("LibCube:IndicatorMember %s\n" % node.name)
    FINANCIAL_INDICATORS.write(indent() + "--> category Finance:Category::%s\n" % category.name)
    if len(standards) > 0:
        frameworks = [ACCOUNTING_FRAMEWORK_CLASS_MEMBER + f for f in standards]
        FINANCIAL_INDICATORS.write(indent() + "--> accountingFramework %s\n" % ", ".join(frameworks))
    # else: fail !
    FINANCIAL_INDICATORS.write(";\n\n")


def write_financial_relation(mother, child):
    global RELATIONS_HEADER_WRITTEN

    if not get_lang_instances(mother) or not get_lang_instances(child):
        return

    if not RELATIONS_HEADER_WRITTEN:
        FINANCIAL_RELATIONS.write("""List financialAnalysisRelations
--> documentation \"\"\"The relations between KPIs when talking about `INCOME_STATEMENT` and `BALANCE_SHEET`.
Note that there is no `ROOT` KPI. This means that `TOTACT` and `TOTPAS` are not linked directly here.
Also, this means that `RN` is the root KPI here for `INCOME_STATEMENT `.
\"\"\"
--> domains LibKPI:Relation
--> values\n""")
        RELATIONS_HEADER_WRITTEN = True
    else:
        FINANCIAL_RELATIONS.write(",\n")
    FINANCIAL_RELATIONS.write(indent() + "-> LibKPI:Relation\n")
    FINANCIAL_RELATIONS.write(indent(2) + "--> relationType RelationType::HIERARCHY\n")
    FINANCIAL_RELATIONS.write(indent(2) + "--> issuerKPI %s\n" % make_kpi_name(mother))
    FINANCIAL_RELATIONS.write(indent(2) + "--> receiverKPI %s\n" % make_kpi_name(child))
    FINANCIAL_RELATIONS.write(indent() + ";")

# creates a KPI name for a node
def make_kpi_name(node):
    return node.name + "_KPI"

# creates a MetaData name for a node
def make_metadata_name(node):
    return node.name + "_METADATA"

def keep_var_by_language(instance, lang, lang_instances):
    # checks if the name of the instance starts with the language
    # analyse unwanted_matches, ie. when `en` matches `en_US_NetDepreciationAndAmortization`
    # checks if the current language starts with all the unwanted_matches, `en_US` vs `en`
    supported_langs_expect_current = list(SUPPORTED_LANGS.keys()).copy()
    supported_langs_expect_current.remove(lang)
    unwanted_matches = list(filter(instance.name.startswith, supported_langs_expect_current))
    if instance.name.startswith(lang + "_") and list(filter(lang.startswith, unwanted_matches)) == unwanted_matches:
        for kb_lang in SUPPORTED_LANGS[lang]:
            if kb_lang not in lang_instances:
                lang_instances[kb_lang] = []
            lang_instances[kb_lang].append(instance)

def get_lang_instances(node):
    lang_instances = {}
    for instance in node.instances():
        if node in instance.is_a:  # instances() returns all sub-class instances
            for lang in SUPPORTED_LANGS:
                keep_var_by_language(instance, lang, lang_instances)
    for indicator_class in filter(lambda x: x in PREDICATES_BY_CLASSES, node.hasClass):
        for inst in PREDICATES_BY_CLASSES[indicator_class]:
            for lang in SUPPORTED_LANGS:
                keep_var_by_language(inst, lang, lang_instances)

    return lang_instances

def create_kpi(node):
    """
    Creates a KPI definition from a node in the OWL tree
    Does not handle synonyms for now
    :param node: class in the Ontology
    :return:
    """

    lang_instances = get_lang_instances(node)
    if not lang_instances:
        return

    name = make_kpi_name(node)
    with open(OUTPUT_KPI_DIR + "/" + name + ".yobject", mode="w", encoding="utf8") as kpi:
        kpi.write("AmountKPI %s\n" % name)
        kpi.write("--> indicator %s\n" % node.name)
        kpi.write("--> documentation \"\"\"KPI for the indicator `%s`\"\"\"\n" % node.name)
        INDICATORS_DOCUMENTATION.write("| %s\n" % node.name)
        neg_contribution = node.hasNegativeContribution != []
        doc_predicates = write_main_predicates_routes(kpi, lang_instances, neg_contribution)
        filtered_lang_instances = {}
        for lang, instances in lang_instances.items():
            filtered_instances = list(filter(lambda x: x.hasGrammaticalCategory.first() not in ["verb", "verbNominalization"], instances))
            if len(filtered_instances) > 0:
                filtered_lang_instances[lang] = filtered_instances
        write_routed_custom_concept_conf(kpi, "LibDocument:Intention", filtered_lang_instances, True, neg_contribution)

        if doc_predicates:
            INDICATORS_DOCUMENTATION.write(doc_predicates)
        else:
            INDICATORS_DOCUMENTATION.write("|\n")

        INDICATORS_DOCUMENTATION.write("|%s\n\n" % ", ".join([ACCOUNTING_FRAMEWORK_CLASS_MEMBER + f for f in node.hasStandard]))

        if neg_contribution :
            kpi.write("--> stylingConfigurations FORCE_ABSOLUTE_VALUE\n")

        kpi.write(";\n")

def write_header_routed_config(kpi, intention_name):
    kpi.write("--> customConceptsConfigurations\n")
    kpi.write(indent() + "-> LibDocument:RoutedCustomConceptsConfiguration\n")
    kpi.write(indent() + "--> route\t-> LibDocument:Route\n")
    kpi.write(indent(2) + "--> intentions %s\n" % intention_name)
    if intention_name == DESCRIBE_VARIATION_INTENTION:
        kpi.write(indent(2) + "--> intentions %s\n" % DESCRIBE_VARIATION_CONTRIBUTORS_INTENTION)
    kpi.write(indent() + ";\n")
    kpi.write(indent() + "--> customConceptsConfiguration\n")
    kpi.write(indent(2) + "-> MultilingualExpression\n")

def write_footer_routed_config(kpi):
    kpi.write(indent(2) + ";\n")
    kpi.write(indent() + ";\n")


def write_main_predicates_routes(kpi, lang_instances, neg_contribution):
    # TODO: get the predicates by describe and variation categories, then by languages
    # ? { category → { language → [predicates] }
    predicates_by_language_by_category = {}
    for lang, instances in lang_instances.items():
        description_predicates, variation_predicates = split_main_predicates(instances)
        if description_predicates != []:
            if DESCRIBE_VALUE_INTENTION not in predicates_by_language_by_category:
                predicates_by_language_by_category[DESCRIBE_VALUE_INTENTION] = {}
            predicates_by_language_by_category[DESCRIBE_VALUE_INTENTION][lang] = description_predicates
        if variation_predicates != []:
            if DESCRIBE_VARIATION_INTENTION not in predicates_by_language_by_category:
                predicates_by_language_by_category[DESCRIBE_VARIATION_INTENTION] = {}
            predicates_by_language_by_category[DESCRIBE_VARIATION_INTENTION][lang] = variation_predicates

    doc_predicates = ""

    for intention_name, predicates_instances_by_lang in predicates_by_language_by_category.items():
        write_header_routed_config(kpi, intention_name)
        doc_predicates += write_predicate_mle(kpi, predicates_instances_by_lang, (intention_name == DESCRIBE_VARIATION_INTENTION), neg_contribution)
        write_footer_routed_config(kpi)

    return doc_predicates


def write_routed_custom_concept_conf(kpi, intention_name, instances_by_lang, write_doc, neg_contribution):
    write_header_routed_config(kpi, intention_name)
    write_indicator_mle(kpi, instances_by_lang, write_doc, neg_contribution)
    write_footer_routed_config(kpi)


def create_metadata(node):
    """
    Creates the Member meta data definition from a node in the OWL tree
    :param node: class in the Ontology
    :return:
    """

    lang_instances = get_lang_instances(node)
    if not lang_instances:
        return

    name = make_metadata_name(node)
    with open(OUTPUT_METADATA_DIR + "/" + name + ".yobject", mode="w", encoding="utf8") as metadata:
        metadata.write("LibDocument:MemberMetaData %s\n" % name)
        metadata.write("--> members %s\n" % node.name)
        metadata.write("--> documentation \"\"\"Metadata for the member `%s`\"\"\"\n" % node.name)
        neg_contribution = node.hasNegativeContribution != []
        write_main_predicates_routes(metadata, lang_instances, neg_contribution)
        filtered_lang_instances = {}
        for lang, instances in lang_instances.items():
            filtered_instances = list(filter(lambda x: x.hasGrammaticalCategory.first() not in ["verb", "verbNominalization"], instances))
            if len(filtered_instances) > 0:
                filtered_lang_instances[lang] = filtered_instances
        write_routed_custom_concept_conf(metadata, "LibDocument:Intention", filtered_lang_instances, False, neg_contribution)
        metadata.write(";\n")

def write_synonym(kpi, language, variant):
    current_var = None
    kpi.write(indent(8) + "--> synonyms ")
    if variant.hasGrammaticalCategory.first() == "noun":
        current_var = extract_noun_variant(kpi, variant, language)
    elif variant.hasGrammaticalCategory.first() == "verb":
        current_var = extract_verb_variant(kpi, variant)
    elif variant.hasGrammaticalCategory.first() == "verbNominalization":
        current_var = extract_verb_nominalization_variant(kpi, variant)
    # else fail !
    return current_var

def split_instances(instances):
    """
    Negative instances are instances that does a reversal of the data sign (+/-) instead or (-/+).
    """
    # variant.hasGrammaticalCategory.first() != expected_grammatical_category
    negative_instances = list(dict.fromkeys(filter(lambda x: x.useIfNegative.first() and x.hasGrammaticalCategory.first() == "noun", instances)))
    positive_instances = list(dict.fromkeys(filter(lambda x: not x.useIfNegative.first() and x.hasGrammaticalCategory.first() == "noun", instances)))

    return negative_instances, positive_instances

PREDICATE_CLASS_TO_RANGE_VALUE = {
    onto.STRONG_POSITIVE : SIGNIFICANT_POSITIVE,
    onto.POSITIVE : POSITIVE,
    onto.NEGATIVE : NEGATIVE,
    onto.STRONG_NEGATIVE : SIGNIFICANT_NEGATIVE,
    onto.STRONG_INCREASE : SIGNIFICANT_POSITIVE,
    onto.INCREASE : POSITIVE,
    onto.STABLE : INSIGNIFICANT,
    onto.DECREASE : NEGATIVE,
    onto.STRONG_DECREASE : SIGNIFICANT_NEGATIVE
}

DEFAULT_VERB_SYNONYM = {
    "en" : {
        SIGNIFICANT_POSITIVE: "LibOntology:EN:Increase:increase",
        POSITIVE: "LibOntology:EN:Increase:increase",
        INSIGNIFICANT: "LibOntology:EN:Stagnate:remain_stable",
        NEGATIVE: "LibOntology:EN:Decrease:decrease",
        SIGNIFICANT_NEGATIVE: "LibOntology:EN:Decrease:decrease"
    },
    "fr" : {
        SIGNIFICANT_POSITIVE: "LibOntology:FR:Augmenter:augmenter",
        POSITIVE: "LibOntology:FR:Augmenter:augmenter",
        INSIGNIFICANT: "LibOntology:FR:stagner:rester_stable",
        NEGATIVE: "LibOntology:FR:Diminuer:diminuer",
        SIGNIFICANT_NEGATIVE: "LibOntology:FR:Diminuer:diminuer"
    }
}

DEFAULT_NOM_SYNONYM = {
    "en" : {
        SIGNIFICANT_POSITIVE: "LibOntology:EN:Increase:an_increase_of",
        POSITIVE: "LibOntology:EN:Increase:an_increase_of",
        INSIGNIFICANT: "LibOntology:EN:Stagnate:a_stagnation_in",
        NEGATIVE: "LibOntology:EN:Decrease:a_decrease_in",
        SIGNIFICANT_NEGATIVE: "LibOntology:EN:Decrease:a_decrease_in"
    },
    "fr" : {
        SIGNIFICANT_POSITIVE: "LibOntology:FR:Augmenter:une_augmentation_de",
        POSITIVE: "LibOntology:FR:Augmenter:une_augmentation_de",
        INSIGNIFICANT: "LibOntology:FR:stagner:une_stagnation_de",
        NEGATIVE: "LibOntology:FR:Diminuer:une_diminution_de",
        SIGNIFICANT_NEGATIVE: "LibOntology:FR:Diminuer:une_diminution_de"
    }
}

THRESHOLD_FOR_DOCUMENTATION = {
    SIGNIFICANT_POSITIVE: "Significant Increase",
    POSITIVE: "Increase",
    INSIGNIFICANT: "Stagnation",
    NEGATIVE: "Decrease",
    SIGNIFICANT_NEGATIVE: "Significat Decrease"
}

def split_main_predicates(instances):
    """
    Predicates are splitted into two categories:
    * Description-related → should be based on CURRENT_VALUE
    * Variation-related → should be based on CALCULATED_RELATIVE_CHANGE
    """
    description_predicates, variation_predicates = [], []
    for verb_instance in list(dict.fromkeys(filter(lambda x: x.hasGrammaticalCategory.first() in ["verb", "verbNominalization"], instances))):
        if (onto.STRONG_POSITIVE in verb_instance.is_a
            or onto.POSITIVE in verb_instance.is_a
            or onto.NEGATIVE in verb_instance.is_a
            or onto.STRONG_NEGATIVE in verb_instance.is_a):
            description_predicates.append(verb_instance)
        if (onto.STRONG_INCREASE in verb_instance.is_a
            or onto.INCREASE in verb_instance.is_a
            or onto.STABLE in verb_instance.is_a
            or onto.DECREASE in verb_instance.is_a
            or onto.STRONG_DECREASE in verb_instance.is_a):
            variation_predicates.append(verb_instance)
    return description_predicates, variation_predicates

# creates a MultilingualExpression
def write_indicator_mle(kpi, instances_by_lang, write_doc, neg_contribution):

    doc_indicators = []

    for language, instances in instances_by_lang.items():

        noun_negative_instances, noun_positive_instances = split_instances(instances)
        write_indicator_slot = len(noun_negative_instances) > 0 or len(noun_positive_instances) > 0

        if write_indicator_slot == True:
            kpi.write(indent(2)+ "--> %s\t-> LibDocument:CustomConceptsConfiguration\n" % language)
            kpi.write(indent(4) + "--> configValues {\n")

            # Write the Indicator slot if possible
            doc_indicator = write_indicator_slot_synonyms(kpi, noun_positive_instances, noun_negative_instances, language, write_doc)
            if len(doc_indicator) > 0 :
                doc_indicators.append("* %s: %s" % (language, doc_indicator))

            kpi.write(indent(4) + "}\n")
            kpi.write(indent(4) + ";\n")

    if write_doc and len(doc_indicators) > 0:
        INDICATORS_DOCUMENTATION.write("a|%s\n" % " +\n".join(doc_indicators))


# creates a MultilingualExpression
def write_predicate_mle(kpi, instances_by_lang, write_doc, neg_contribution):

    doc_predicates = []

    for language, instances in instances_by_lang.items():

        description_predicates, variation_predicates = split_main_predicates(instances)
        write_main_predicate_slot = len(description_predicates) > 0 or len(variation_predicates) > 0

        kpi.write(indent(2)+ "--> %s\t-> LibDocument:CustomConceptsConfiguration\n" % language)
        kpi.write(indent(4) + "--> configValues {\n")
        # Write the MainPredicate slot if possible
        if write_main_predicate_slot == True:
            doc_predicate = write_predicate_slot_synonyms(kpi, description_predicates, variation_predicates, language, neg_contribution)
            if len(doc_predicate) > 0 :
                doc_predicates.append("* %s: %s" % (language, doc_predicate))

        kpi.write(indent(4) + "}\n")
        kpi.write(indent(4) + ";\n")

    if write_doc == True and len(doc_predicates) > 0:
        return "a|%s\n" % " +\n".join(doc_predicates)

    return ""

def get_variants_by_threshold_conditions(description_predicates, variation_predicates):
    possible_descr_types = [
        onto.STRONG_POSITIVE,
        onto.POSITIVE,
        onto.NEGATIVE,
        onto.STRONG_NEGATIVE
    ]
    variants_by_description_threshold_conditions = {}
    for variant in description_predicates:
        for variant_type in filter(lambda x: x in possible_descr_types, variant.is_a):
            if variant_type not in variants_by_description_threshold_conditions:
                variants_by_description_threshold_conditions[variant_type] = []
            variants_by_description_threshold_conditions[variant_type].append(variant)

    possible_var_types = [
        onto.STRONG_INCREASE,
        onto.INCREASE,
        onto.STABLE,
        onto.DECREASE,
        onto.STRONG_DECREASE
    ]
    variants_by_variation_threshold_conditions = {}
    for variant in variation_predicates:
        for variant_type in filter(lambda x: x in possible_var_types, variant.is_a):
            if variant_type not in variants_by_variation_threshold_conditions:
                variants_by_variation_threshold_conditions[variant_type] = []
            variants_by_variation_threshold_conditions[variant_type].append(variant)

    return variants_by_description_threshold_conditions, variants_by_variation_threshold_conditions


#
# ? ajouter des sémantiques lots describe variation → increase, decrease, stagnate
# ? ajouter un sémantique slot pour overrider « measure » dans describe value
# ! on a deux systèmes pour remplacer/ajouter/supprimer → comment faire pour n'en avoir qu'un seul ?
# ? filtrage par intentions
#

def write_predicate_slot_synonyms(kpi, description_predicates, variation_predicates, language, neg_contribution):
    """Write in kpi the content of the MainPredicate semantic slot, but only for variations

    Arguments:
        kpi {file} -- file to write in
        description_predicates {list} -- list of predicates related to a description
        variation_predicates {list} -- list of predicates related to a variation
        language {string} -- current language of the variants to write
    """

    doc_predicate = ""

    kpi.write(indent(5) + "LibDocument:SemanticSlot::MainPredicate :\n")
    variants_by_description_threshold_conditions, variants_by_variation_threshold_conditions = get_variants_by_threshold_conditions(description_predicates, variation_predicates)

    kpi.write(indent(6) + "-> LibDocument:DynamicCustomTexts\n")
    if variants_by_variation_threshold_conditions != {}:
        doc_predicate = write_custom_texts(kpi, variants_by_variation_threshold_conditions, language, neg_contribution, True)
    elif variants_by_description_threshold_conditions != {}:
        # For now, synonyms for description are not handled => not in documentation
        write_custom_texts(kpi, variants_by_description_threshold_conditions, language, neg_contribution, False)
    kpi.write(indent(5) + ";\n")

    return doc_predicate

def write_custom_texts(kpi, variants_by_threshold_conditions, language, neg_contribution, is_variation):

    doc_by_threshold = []

    kpi.write(indent(6) + "--> customTexts -> List\n")
    for threshold, threshold_variants in variants_by_threshold_conditions.items():
        kpi.write(indent(7) + "--> values -> LibDocument:CustomText\n")
        variants = []
        for variant in threshold_variants:
            synonym = write_synonym(kpi, language, variant)
            if synonym is not None:
                variants.append(synonym)

        range_value = PREDICATE_CLASS_TO_RANGE_VALUE[threshold]

        if len(variants) > 0:
            doc_by_threshold.append("\"%s\" [%s]" % ("\" or \"".join(variants), THRESHOLD_FOR_DOCUMENTATION[range_value]))


        # patch while waiting for the ontology to be enrich with more synonyms
        if is_variation and (len(variants) == 1 or len(variants) == 2):
            default_synonym = DEFAULT_VERB_SYNONYM[language][range_value]
            if default_synonym and default_synonym not in variants:
                kpi.write(indent(8) + "--> synonyms %s\n" % default_synonym)
                variants.append(default_synonym)
            default_synonym = DEFAULT_NOM_SYNONYM[language][range_value]
            if default_synonym and default_synonym not in variants:
                kpi.write(indent(8) + "--> synonyms %s\n" % default_synonym)
                variants.append(default_synonym)

        kpi.write(indent(8) + "--> thresholdConditions %s\n" % range_value)
        kpi.write(indent(7) + ";\n")
    kpi.write(indent(6) + ";\n")

    if neg_contribution :
        kpi.write(indent(6) + "--> ranges PredicateReversedRanges\n")
    else :
        kpi.write(indent(6) + "--> ranges LibKPI:defaultPredicateRanges\n")

    if is_variation :
        computed_value_key = "CALCULATED_RELATIVE_CHANGE"
    else :
        computed_value_key = "CURRENT_VALUE"

    kpi.write(indent(6) + "--> filter -> LibDocument:ComputedValuesFilter\n")
    kpi.write(indent(7) + "--> computedValuesNames ComputedValueKey:%s\n" % computed_value_key)
    kpi.write(indent(6) + ";\n")

    if len(doc_by_threshold) > 0:
        return ", ".join(doc_by_threshold)

    return ""

def write_indicator_slot_synonyms(kpi, positive_instances, negative_instances, language, write_doc):

    doc_indicator = ""

    kpi.write(indent(5) + "LibDocument:SemanticSlot::Indicator :\n")
    kpi.write(indent(6) + "-> LibDocument:DynamicCustomTexts\n")
    kpi.write(indent(6) + "--> customTexts -> List\n")
    kpi.write(indent(7) + "--> values -> LibDocument:CustomText\n")
    variants = []
    for variant in positive_instances:
        synonym = write_synonym(kpi, language, variant)
        if synonym is not None:
            variants.append(synonym)
    if write_doc:
        doc_indicator += ("%s" % " or ".join(variants))

    if negative_instances:
        kpi.write(indent(7) + "--> thresholdConditions LibKPI:INSIGNIFICANT\n")
        kpi.write(indent(7) + "--> thresholdConditions LibKPI:POSITIVE\n")
        kpi.write(indent(7) + ";,\n")
        kpi.write(indent(7) + "-> LibDocument:CustomText\n")
        for variant in negative_instances:
            write_synonym(kpi, language, variant)
        kpi.write(indent(6) + "--> thresholdConditions LibKPI:NEGATIVE\n")

    kpi.write(indent(7) + ";\n")
    kpi.write(indent(6) + ";\n")

    # only if we have negative variants
    if negative_instances:
        kpi.write(indent(6) + "--> ranges ThreeLevelValue\n")
        kpi.write(indent(6) + "--> filter ALL_CURRENT_VALUES__NAMES\n")

    kpi.write(indent(5) + ";\n")

    return doc_indicator


def create_verb_id(language, variant):
    return "VP:" + language.upper() + ":" + variant.upper().replace(" ", "_").replace("'", "_")

def create_verb_nom_id(language, variant):
    return "VN:" + language.upper() + ":" + variant.upper().replace(" ", "_").replace("'", "_").replace("-", "_")

def extract_noun_variant(kpi, variant, language):
    """Write a NounPhrase object for the current variant in kpi

    Arguments:
        kpi {file} -- file in which write the variant
        variant {ontology object} -- the variant to write in YML
        language {string} -- a string corresponding to the language of the variant

    Returns:
        ontology object -- the variant's first lexicalization
    """
    current_var = "\"%s\"" % variant.lexicalisation.first()

    kpi.write("\t-> LibOntology:NounPhrase\n")
    kpi.write(indent(11) + "--> head %s\n" % current_var)
    if variant.hasGender.first():
        kpi.write(indent(11) + "--> gender %s\n" % variant.hasGender.first().upper())
    if variant.hasNumber.first():
        kpi.write(indent(11) + "--> number %s\n" % variant.hasNumber.first().upper())
    if language is 'fr':
        kpi.write(indent(11) + "--> determiner DEFINITE_ARTICLE\n")
    kpi.write(indent(11) + ";\n")
    return current_var

def extract_verb_variant(kpi, variant):
    """Write the VerbPhrase identifier for the current variant in kpi

    Arguments:
        kpi {file} -- file in which write the variant
        variant {ontology object} -- the variant to write in YML

    Returns:
        ontology object -- the variant's first lexicalization
    """

    ind_end = variant.name.rfind('_')
    language = variant.name[:ind_end]

    current_var = variant.lexicalisation.first()
    kpi.write("%s\n" % create_verb_id(language, variant.name[(ind_end + 1):]))
    return current_var

def extract_verb_nominalization_variant (kpi, variant):
    """Write the Verb nominalization identifier for the current variant in kpi

    Arguments:
        kpi {file} -- file in which write the variant
        variant {ontology object} -- the variant to write in YML

    Returns:
        ontology object -- the variant's first lexicalization
    """

    ind = variant.name.find('_')
    language = variant.name[:ind]

    current_var = variant.lexicalisation.first()
    kpi.write("%s\n" % create_verb_nom_id(language, variant.name[(ind + 1):]))
    return current_var

def write_verb_variant(variant):
    """Write a VerbPhrase object in the verb predicates file

    Arguments:
        variant {ontology object} -- the variant to write in YML
    """

    ind_end = variant.name.rfind('_')
    language = variant.name[:ind_end]

    current_var = variant.lexicalisation.first()
    verb = "VERB_%s_%s" % (language[:2].upper(), current_var.upper().replace(" ", "_").replace("'", "_"))

    VERB_PREDICATES.write("LibOntology:VerbPhrase %s\n" % create_verb_id(language, variant.name[(ind_end + 1):]))
    VERB_PREDICATES.write(indent() + "// %s\n" % verb)
    VERB_PREDICATES.write(indent() + "--> head %s\n" % verb)
    VERB_PREDICATES.write(indent() + "--> passiveForm %s\n" % str(variant.isPassiveForm.first()).lower())
    VERB_PREDICATES.write(indent() + "--> forcePronominalForm %s\n" % str(variant.isReflexive.first()).lower())

    has_subject = variant.hasSubject.first()
    if(has_subject == "KPI" or has_subject == "Owner"):
        VERB_PREDICATES.write(indent() + "--> hasSubject LibOntology:PredicateArgumentType::%s\n" % str(has_subject).upper())
    has_object = variant.hasObject.first()
    if(has_object == "KPI" or has_object == "Owner"):
        VERB_PREDICATES.write(indent() + "--> hasObject LibOntology:PredicateArgumentType::%s\n" % str(has_object).upper())
    if(variant.hasAdjective.first() != None):
        VERB_PREDICATES.write(indent() + "--> attributiveAdj -> NlgAdjective\n")
        VERB_PREDICATES.write(indent(2) + "--> root \"%s\"\n" % variant.hasAdjective.first())
        VERB_PREDICATES.write(indent(2) + ";\n")
    if(variant.hasDeterminer.first() != None):
        VERB_PREDICATES.write(indent() + "--> hasDeterminer %s_ARTICLE\n" % str(variant.hasDeterminer.first()).upper())
    VERB_PREDICATES.write(";\n\n")


def write_verb_nominalization_variant(variant):
    """Write a NounPhrase object in the verb_nominalizations predicates file

    Arguments:
        variant {ontology object} -- the variant to write in YML
    """

    ind = variant.name.find('_')
    language = variant.name[:ind]

    current_var = variant.lexicalisation.first()

    VERB_NOMINALIZATIONS.write("LibOntology:NounPhrase %s\n" % create_verb_nom_id(language, variant.name[(ind + 1):]))
    VERB_NOMINALIZATIONS.write(indent() + "--> head \"%s\"\n" % current_var)

    if variant.hasGender.first():
        VERB_NOMINALIZATIONS.write(indent() + "--> gender %s\n" % variant.hasGender.first().upper())
    if variant.hasNumber.first():
        VERB_NOMINALIZATIONS.write(indent() + "--> number %s\n" % variant.hasNumber.first().upper())

    if variant.hasDeterminer.first():
        VERB_NOMINALIZATIONS.write(indent() + "--> determiner %s_ARTICLE\n" % str(variant.hasDeterminer.first()).upper())
    if variant.hasPreposition.first():
        VERB_NOMINALIZATIONS.write(indent() + "--> preposition \"%s\"\n" % variant.hasPreposition.first())


    VERB_NOMINALIZATIONS.write(";\n\n")


if __name__ == '__main__':
    main()
