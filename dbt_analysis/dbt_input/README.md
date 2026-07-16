# dbt_input Synthetic Dummy Data

SYNTHETIC DUMMY DATA — NOT PRODUCTION DATA

Every file in this folder contains synthetic dummy data and must not be treated as production evidence.

Analysis period: 2026-05-18T00:00:00+05:30 through 2026-07-16T23:59:59+05:30.
Timezone: Asia/Kolkata (IST, UTC+05:30).
Generated timestamp: 2026-07-16T10:30:00+05:30.

Result classification for any findings created from these files:

Demonstration result based on synthetic dummy data

## Files

- warehouse_query_log.csv: Fictional warehouse query activity across the 60-calendar-day analysis period.
- dbt_model_rebuild_costs.csv: Fictional measured and estimated model rebuild cost records.
- bi_dashboard_usage.csv: Fictional BI dashboard usage, stale records, and model-to-dashboard relationships.
- dbt_run_history.csv: Fictional dbt execution history including success, failure, retry, skipped, full-refresh, and incremental runs.
- protected_models_exceptions.csv: Fictional exception records for protected models.

## Synthetic Data Guardrails

These files contain no actual production data, warehouse records, customer records, employee data, vendor data, confidential SQL, billing account identifiers, credentials, secrets, tokens, keys, or connection details.

All user-shaped values use fictional identifiers and reserved domains such as example.invalid.

Where practical, files include data_classification = SYNTHETIC_DUMMY_DATA.

## Scenario Coverage

This dummy dataset includes:

- actively used models
- low-usage models
- inactive and potentially unused models
- directly used models
- indirectly used models
- models with no direct query activity but active downstream descendants
- overbuilt models
- schedule-optimization candidates
- expensive rebuild chains
- protected models
- long-running models
- successful, failed, retried, skipped, full-refresh, and incremental runs
- stale dashboard records
- missing or incomplete ownership
- unmatched object identifiers
- measured-style and estimated-style cost records
- varied risk and confidence levels

Important examples:

- rpt_sample_finance_monthly is protected and low usage; it must not receive an automatic modification or deprecation recommendation.
- int_sample_order_details has no direct BI/dashboard query activity but supports fct_sample_orders and rpt_sample_sales, so it should be treated as indirectly used.
- rpt_sample_experimental_churn and rpt_sample_legacy_kpi are unused-model investigation candidates.
- rpt_sample_inventory, int_sample_marketing_attribution, fct_sample_orders, and fct_sample_refunds are schedule-optimization candidates.
- fct_sample_refunds is intentionally long-running and includes failure/retry records.
- unmatched_sample_reporting_view is an intentional synthetic unmatched object identifier.

## Storage Rule

Keep these synthetic inputs inside dbt_analysis/dbt_input/. Do not include them in a production pull request, deployment package, release artifact, or operational report.

