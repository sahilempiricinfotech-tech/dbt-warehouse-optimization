{{ config(materialized='view') }}

select
    dashboard_id,
    dashboard_name,
    dashboard_owner_email,
    owner_team,
    dashboard_tool,
    model_id,
    upstream_model_ids,
    first_seen_at,
    last_viewed_at,
    views_last_60d,
    views_last_30d,
    unique_viewers_last_30d,
    dashboard_status,
    refresh_schedule_ist,
    stale_record_flag,
    usage_classification,
    business_criticality,
    notes,
    data_classification
from {{ source('input_data', 'bi_dashboard_usage') }}
where data_classification = 'SYNTHETIC_DUMMY_DATA'
