{{ config(materialized='view') }}

select
    query_id,
    query_started_at,
    query_completed_at,
    model_id,
    database_name,
    schema_name,
    object_name,
    access_type,
    usage_route,
    query_source,
    application_name,
    user_identifier,
    service_account,
    dashboard_id,
    downstream_model_id,
    rows_scanned,
    bytes_scanned,
    duration_seconds,
    query_status,
    query_text_stub,
    usage_classification,
    data_classification
from {{ source('input_data', 'warehouse_query_log') }}
where data_classification = 'SYNTHETIC_DUMMY_DATA'
