# anna-ontology

- [Protégé Desktop 5.5.0](#protege)
- [Importing an ontology to Protégé](#import)
- [Building a financial "ontology"](#build)
- [Exporting the ontology](#export)

<a name="protege"></a>

### Protégé Desktop 5.5.0

*This work was conducted using the Protégé resource, which is supported by grant GM10331601 from the National Institute of General Medical Sciences of the United States National Institutes of Health.*

Protégé is a free, open source platform. It enables users to build and maintain ontologies.
Link to download : https://protege.stanford.edu/products.php#desktop-protege

Installation guide : https://protegewiki.stanford.edu/wiki/Install_Protege5
<a name="import"></a>
### Importing an ontology to Protégé

- File > Open
- Select the `ontology.owl` file
- Open
<a name="build"></a>
### Building a financial "ontology"

See the documentation : [Augmented Analyst - Ontology (Work in progress) - Intranet - Yseop Knowledge](https://yseop-knowledge.atlassian.net/wiki/spaces/KNOW/pages/1160839189/Augmented+Analyst+-+Ontology+Work+in+progress)

<a name="export"></a>

### Exporting the ontology

The `scripts` directory contains the necessary scripts to export the Ontology contents in a YML format.

All the other source files are located in the `bootstrap/dialog/ontology` folder.

The generated files are directly placed in the folders were they will be used:
* `library/lib/FinancialAnalysis/_instances/KeyPerformanceIndicators` for the KPIs
* `library/lib/FinancialAnalysis/_domainObjects` for the financial indicators and relations
* `documentation/modules/ROOT/partials/indicators.adoc` for the documentation about indicators
