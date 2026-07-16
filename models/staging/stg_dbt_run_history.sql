{{ config(materialized='view') }}

select
    run_id,
    invocation_id,
    model_id,
    run_started_at,
    run_completed_at,
    run_business_date_ist,
    run_type,
    execution_mode,
    materialization,
    run_status,
    retry_attempt,
    is_full_refresh,
    duration_seconds,
    rows_affected,
    warehouse_size,
    triggered_by,
    schedule_expression_ist,
    dbt_job_name,
    error_category,
    downstream_impact,
    data_classification
from {{ source('input_data', 'dbt_run_history') }}
where data_classification = 'SYNTHETIC_DUMMY_DATA'
