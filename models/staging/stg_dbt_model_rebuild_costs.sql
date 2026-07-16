{{ config(materialized='view') }}

select
    cost_record_id,
    measured_at,
    model_id,
    parent_model_ids,
    downstream_model_ids,
    materialization,
    rebuild_strategy,
    schedule_expression_ist,
    schedule_timezone,
    average_runtime_seconds,
    p95_runtime_seconds,
    average_warehouse_credits,
    average_rebuild_cost_usd,
    monthly_rebuild_count,
    monthly_estimated_cost_usd,
    cost_source_type,
    rebuild_chain_id,
    overbuild_indicator,
    schedule_optimization_candidate,
    usage_risk_level,
    recommendation_confidence,
    owner_email,
    owner_team,
    data_classification
from {{ source('input_data', 'dbt_model_rebuild_costs') }}
where data_classification = 'SYNTHETIC_DUMMY_DATA'
