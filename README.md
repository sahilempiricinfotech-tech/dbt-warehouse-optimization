# dbt Warehouse Optimization

This repository contains a demonstration dbt project for warehouse usage and cost optimization analysis. It is designed to work with synthetic dummy input data only.

## Purpose

The project models a sample workflow for identifying:

- actively used, low-usage, inactive, and indirectly used dbt models
- protected models that must not receive automatic deprecation recommendations
- schedule optimization candidates
- expensive rebuild chains
- long-running, failed, retried, skipped, full-refresh, and incremental runs
- stale dashboard records and incomplete ownership signals

All outputs and recommendations from this project must be treated as:

Demonstration result based on synthetic dummy data

## Repository Contents

GitHub stores only the dbt project code and configuration:

- dbt_project.yml
- models/
- macros/
- tests/
- snapshots/
- seeds/
- schedules/

CSV input data is not committed to this repository.

## Input Data Location

Synthetic CSV inputs live in Google Drive:

dbt_analysis/
  dbt_input/
    warehouse_query_log.csv
    dbt_model_rebuild_costs.csv
    bi_dashboard_usage.csv
    dbt_run_history.csv
    protected_models_exceptions.csv

Drive folders:

- dbt_analysis: https://drive.google.com/drive/folders/1tT-8g3yj9kY5mgm14LU0s_D7jX9fdlyI
- dbt_input: https://drive.google.com/drive/folders/18L3lDrhZBDDYVuKFXfazFVuHbODxGhso

## Synthetic Data Boundary

Do not use production data with this project. The expected input files must contain only fictional records, reserved-domain email-shaped values such as example.invalid, and data_classification values such as SYNTHETIC_DUMMY_DATA.

Do not commit generated CSV inputs, secrets, credentials, warehouse connection details, customer data, employee data, vendor data, billing identifiers, or production SQL to this repository.

## Project Layout

- models/staging/: Source-aligned staging models for the five synthetic input files.
- models/marts/: Demonstration rollups and recommendation logic.
- macros/: Shared helper macros for classification and usage bands.
- tests/: Custom assertions for protected-model behavior.
- snapshots/: Snapshot structure for protected-model exception history.
- seeds/: Placeholder folder only; CSV inputs remain in Google Drive.
- schedules/: Demonstration scheduling configuration using Asia/Kolkata (IST).

## Notes

This repository is for sandbox, demonstration, training, or test use only. It is not production evidence and should not be used in deployment, release, compliance, or operational reporting workflows.
