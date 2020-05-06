List financialAnalysisRelations
--> documentation """The relations between KPIs when talking about `INCOME_STATEMENT` and `BALANCE_SHEET`.
Note that there is no `ROOT` KPI. This means that `TOTACT` and `TOTPAS` are not linked directly here.
Also, this means that `RN` is the root KPI here for `INCOME_STATEMENT `.
"""
--> domains LibKPI:Relation
--> values
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_ASSETS_KPI
		--> receiverKPI ASSETS_CLASSIFIED_AS_HELD_FOR_SALE_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_ASSETS_KPI
		--> receiverKPI CURRENT_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_ASSETS_KPI
		--> receiverKPI CASH_AND_CASH_EQUIVALENTS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_ASSETS_KPI
		--> receiverKPI CURRENT_FINANCIAL_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_ASSETS_KPI
		--> receiverKPI CURRENT_TAX_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_ASSETS_KPI
		--> receiverKPI INVENTORIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_ASSETS_KPI
		--> receiverKPI OTHER_CURRENT_RECEIVABLES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_ASSETS_KPI
		--> receiverKPI OTHER_RECEIVABLES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_ASSETS_KPI
		--> receiverKPI TAX_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_ASSETS_KPI
		--> receiverKPI TRADE_AND_OTHER_RECEIVABLES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_ASSETS_KPI
		--> receiverKPI NON_CURRENT_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_ASSETS_KPI
		--> receiverKPI DEFERRED_TAX_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_ASSETS_KPI
		--> receiverKPI FINANCIAL_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_ASSETS_KPI
		--> receiverKPI GOODWILL_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_ASSETS_KPI
		--> receiverKPI INTANGIBLE_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_ASSETS_KPI
		--> receiverKPI INVESTMENTS_IN_ASSOCIATES_AND_JV_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_ASSETS_KPI
		--> receiverKPI NON_CURRENT_FINANCIAL_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_ASSETS_KPI
		--> receiverKPI OTHER_NON_CURRENT_RECEIVABLES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_ASSETS_KPI
		--> receiverKPI PROPERTY_PLANT_AND_EQUIPMENT_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
		--> receiverKPI ACCRUED_EXPENSES_AND_OTHER_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI ACCRUED_EXPENSES_AND_OTHER_KPI
		--> receiverKPI RECEIPT_IN_ADVANCE_FR_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI ACCRUED_EXPENSES_AND_OTHER_KPI
		--> receiverKPI TAX_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI ACCRUED_EXPENSES_AND_OTHER_KPI
		--> receiverKPI TRADE_AND_OTHER_PAYABLES_FR_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
		--> receiverKPI ADJUSTING_ACCOUNT_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
		--> receiverKPI CURRENT_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_LIABILITIES_KPI
		--> receiverKPI CURRENT_FINANCIAL_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_LIABILITIES_KPI
		--> receiverKPI CURRENT_PROVISIONS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_LIABILITIES_KPI
		--> receiverKPI CURRENT_TAX_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_LIABILITIES_KPI
		--> receiverKPI OTHER_CURRENT_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_LIABILITIES_KPI
		--> receiverKPI RECEIPT_IN_ADVANCE_IFRS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CURRENT_LIABILITIES_KPI
		--> receiverKPI TRADE_AND_OTHER_PAYABLES_IFRS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
		--> receiverKPI FINANCIAL_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI FINANCIAL_LIABILITIES_KPI
		--> receiverKPI LOANS_AND_BORROWINGS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI FINANCIAL_LIABILITIES_KPI
		--> receiverKPI OTHER_FINANCIAL_DEBTS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
		--> receiverKPI NON_CURRENT_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_LIABILITIES_KPI
		--> receiverKPI DEFERRED_TAX_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_LIABILITIES_KPI
		--> receiverKPI NON_CURRENT_FINANCIAL_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_LIABILITIES_KPI
		--> receiverKPI NON_CURRENT_PROVISIONS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_CURRENT_LIABILITIES_KPI
		--> receiverKPI OTHER_NON_CURRENT_LIABILITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
		--> receiverKPI OTHER_DEBTS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
		--> receiverKPI PROVISIONS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_AND_LIABILITIES_KPI
		--> receiverKPI TOTAL_EQUITY_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_KPI
		--> receiverKPI EQUITY_GROUP_SHARE_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_KPI
		--> receiverKPI EQUITY_NON_CONTROLLING_INTERESTS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_KPI
		--> receiverKPI NET_INCOME_AND_CONSOLIDATED_RESERVES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI TOTAL_EQUITY_KPI
		--> receiverKPI SHARE_CAPITAL_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CASH_AND_CASH_EQUIVALENT_END_FY_KPI
		--> receiverKPI CASH_AND_CASH_EQUIVALENT_BEGINNING_FY_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CASH_AND_CASH_EQUIVALENT_END_FY_KPI
		--> receiverKPI EXCHANGE_RATE_CHANGES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CASH_AND_CASH_EQUIVALENT_END_FY_KPI
		--> receiverKPI NET_INCREASE_DECREASE_IN_CASH_AND_CASH_EQUIVALENTS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_INCREASE_DECREASE_IN_CASH_AND_CASH_EQUIVALENTS_KPI
		--> receiverKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI CAPITAL_INCREASE_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI DIVIDENDS_PAID_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI INVESTMENT_SUBSIDIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI PAYMENT_OF_OBLIGATIONS_UNDER_FINANCE_LEASES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI PROCEEDS_FROM_LOANS_AND_BORROWINGS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI PROCEEDS_FROM_SALE_OF_TREASURY_SHARES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI PROCEEDS_ON_DISPOSAL_OF_PARTIAL_INTEREST_IN_SUBSIDIARY_WITHOUT_LOSS_OF_CONTROL_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI PROCEEDS_ON_ISSUE_OF_CONVERTIBLE_LOAN_NOTES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI PROCEEDS_ON_ISSUE_OF_SHARES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI REPAYMENTS_OF_BORROWINGS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI REPURCHASE_OF_TREASURY_SHARES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_FINANCING_ACTIVITIES_KPI
		--> receiverKPI TRANSACTION_COSTS_RELATED_TO_THE_LOANS_AND_BORROWINGS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_INCREASE_DECREASE_IN_CASH_AND_CASH_EQUIVALENTS_KPI
		--> receiverKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI ACQUISITION_OF_INTANGIBLE_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI ACQUISITION_OF_INVESTMENT_IN_ASSOCIATE_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI DIVIDENDS_RECEIVED_FROM_EQUITY_INSTRUMENTS_AT_FVTOCI_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI DIVIDENDS_RECEIVED_FROM_JOINT_VENTURES_AND_ASSOCIATES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI EFFECT_OF_CHANGE_IN_THE_REPORTING_ENTITY_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EFFECT_OF_CHANGE_IN_THE_REPORTING_ENTITY_KPI
		--> receiverKPI ACQUISITION_OF_SUBSIDIARY_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EFFECT_OF_CHANGE_IN_THE_REPORTING_ENTITY_KPI
		--> receiverKPI DISPOSAL_OF_SUBSIDIARY_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI INTEREST_RECEIVED_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI NET_PROCEEDS_FROM_INTANGIBLE_ASSETS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI NET_PROCEEDS_FROM_SALE_OF_PROPERTY_PLANT_AND_EQUIPMENT_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI PROCEEDS_ON_DISPOSAL_OF_EQUITY_INSTRUMENTS_HELD_AT_FVTOCI_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI PURCHASES_OF_EQUITY_INSTRUMENTS_AT_FVTOCI_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_INVESTING_ACTIVITIES_KPI
		--> receiverKPI PURCHASES_OF_PROPERTY_PLANT_AND_EQUIPMENT_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_INCREASE_DECREASE_IN_CASH_AND_CASH_EQUIVALENTS_KPI
		--> receiverKPI NET_CASH_FLOW_FROM_OPERATING_ACTIVITIES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_OPERATING_ACTIVITIES_KPI
		--> receiverKPI CASH_GENERATED_FROM_OPERATIONS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CASH_GENERATED_FROM_OPERATIONS_KPI
		--> receiverKPI PAYMENT_TO_EMPLOYEES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CASH_GENERATED_FROM_OPERATIONS_KPI
		--> receiverKPI PAYMENT_TO_SUPPLIERS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI CASH_GENERATED_FROM_OPERATIONS_KPI
		--> receiverKPI RECEIPTS_FROM_CUSTOMERS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_OPERATING_ACTIVITIES_KPI
		--> receiverKPI INCOME_TAX_PAID_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_CASH_FLOW_FROM_OPERATING_ACTIVITIES_KPI
		--> receiverKPI INTEREST_PAID_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_EARNINGS_KPI
		--> receiverKPI EBIT_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EBIT_KPI
		--> receiverKPI FINANCIAL_RESULT_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI FINANCIAL_RESULT_KPI
		--> receiverKPI FINANCIAL_COSTS_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI FINANCIAL_RESULT_KPI
		--> receiverKPI FINANCIAL_INCOME_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EBIT_KPI
		--> receiverKPI NON_RECURRING_RESULT_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_RECURRING_RESULT_KPI
		--> receiverKPI NON_RECURRING_EXPENSES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NON_RECURRING_RESULT_KPI
		--> receiverKPI NON_RECURRING_INCOME_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EBIT_KPI
		--> receiverKPI OPERATING_PROFIT_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI OPERATING_PROFIT_KPI
		--> receiverKPI EBITDA_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EBITDA_KPI
		--> receiverKPI ADMINISTRATIVE_EXPENSES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EBITDA_KPI
		--> receiverKPI COST_OF_SALES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EBITDA_KPI
		--> receiverKPI OTHER_OPERATING_INCOME_AND_EXPENSES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI OTHER_OPERATING_INCOME_AND_EXPENSES_KPI
		--> receiverKPI OTHER_OPERATING_EXPENSES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI OTHER_OPERATING_INCOME_AND_EXPENSES_KPI
		--> receiverKPI OTHER_OPERATING_INCOME_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EBITDA_KPI
		--> receiverKPI PERSONNEL_EXPENSES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EBITDA_KPI
		--> receiverKPI SALES_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI EBITDA_KPI
		--> receiverKPI TAXES_OTHER_THAN_INCOME_TAX_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI OPERATING_PROFIT_KPI
		--> receiverKPI NET_DEPRECIATION_AND_AMORTISATION_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI OPERATING_PROFIT_KPI
		--> receiverKPI NET_INCREASE_IN_PROVISION_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_EARNINGS_KPI
		--> receiverKPI GOODWILL_IMPAIRMENT_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_EARNINGS_KPI
		--> receiverKPI INCOME_TAX_EXPENSE_KPI
	;,
	-> LibKPI:Relation
		--> relationType RelationType::HIERARCHY
		--> issuerKPI NET_EARNINGS_KPI
		--> receiverKPI SHARE_IN_NET_INCOME_OF_ASSOCIATES_AND_JV_KPI
	;
;