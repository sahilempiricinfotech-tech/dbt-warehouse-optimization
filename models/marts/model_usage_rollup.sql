{{ config(materialized='table') }}

with query_activity as (
    select
        model_id,
        count(*) as direct_query_count_60d,
        max(query_started_at) as last_query_at,
        sum(bytes_scanned) as bytes_scanned_60d,
        sum(duration_seconds) as query_duration_seconds_60d
    from {{ ref('stg_warehouse_query_log') }}
    group by model_id
),

dashboard_activity as (
    select
        model_id,
        sum(views_last_60d) as dashboard_views_60d,
        sum(views_last_30d) as dashboard_views_30d,
        max(last_viewed_at) as last_dashboard_viewed_at,
        max(case when stale_record_flag = 'true' then 1 else 0 end) as has_stale_dashboard_record
    from {{ ref('stg_bi_dashboard_usage') }}
    group by model_id
),

run_activity as (
    select
        model_id,
        count(*) as run_count_60d,
        max(run_started_at) as last_run_at,
        max(case when run_status in ('failed', 'retried_success') then 1 else 0 end) as has_failures_or_retries,
        max(case when duration_seconds >= 1800 then 1 else 0 end) as has_long_running_execution
    from {{ ref('stg_dbt_run_history') }}
    group by model_id
),

costs as (
    select
        model_id,
        downstream_model_ids,
        monthly_estimated_cost_usd,
        cost_source_type,
        overbuild_indicator,
        schedule_optimization_candidate,
        usage_risk_level,
        recommendation_confidence,
        owner_email,
        owner_team
    from {{ ref('stg_dbt_model_rebuild_costs') }}
),

protected as (
    select
        model_id,
        max(case when deprecation_allowed = 'false' then 1 else 0 end) as is_protected,
        max(case when auto_recommendation_allowed = 'false' then 1 else 0 end) as blocks_auto_recommendation
    from {{ ref('stg_protected_models_exceptions') }}
    group by model_id
)

select
    c.model_id,
    c.downstream_model_ids,
    coalesce(q.direct_query_count_60d, 0) as direct_query_count_60d,
    coalesce(d.dashboard_views_60d, 0) as dashboard_views_60d,
    coalesce(d.dashboard_views_30d, 0) as dashboard_views_30d,
    coalesce(r.run_count_60d, 0) as run_count_60d,
    coalesce(p.is_protected, 0) as is_protected,
    coalesce(p.blocks_auto_recommendation, 0) as blocks_auto_recommendation,
    coalesce(r.has_failures_or_retries, 0) as has_failures_or_retries,
    coalesce(r.has_long_running_execution, 0) as has_long_running_execution,
    coalesce(d.has_stale_dashboard_record, 0) as has_stale_dashboard_record,
    c.monthly_estimated_cost_usd,
    c.cost_source_type,
    c.overbuild_indicator,
    c.schedule_optimization_candidate,
    c.usage_risk_level,
    c.recommendation_confidence,
    c.owner_email,
    c.owner_team,
    q.last_query_at,
    d.last_dashboard_viewed_at,
    r.last_run_at,
    {{ synthetic_result_classification() }} as result_classification
from costs c
left join query_activity q on c.model_id = q.model_id
left join dashboard_activity d on c.model_id = d.model_id
left join run_activity r on c.model_id = r.model_id
left join protected p on c.model_id = p.model_id
