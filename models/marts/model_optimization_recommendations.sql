{{ config(materialized='table') }}

select
    model_id,
    case
        when is_protected = 1 then 'retain_protected_model'
        when direct_query_count_60d = 0
             and dashboard_views_60d = 0
             and coalesce(downstream_model_ids, '') <> '' then 'indirectly_used_review_only'
        when direct_query_count_60d = 0
             and dashboard_views_60d = 0 then 'investigate_unused_model'
        when schedule_optimization_candidate = 'true' then 'review_refresh_schedule'
        when has_long_running_execution = 1 then 'investigate_long_running_model'
        when has_failures_or_retries = 1 then 'investigate_reliability'
        else 'retain_current_pattern'
    end as recommendation_type,
    case
        when is_protected = 1 then 'no automatic modification or deprecation'
        when blocks_auto_recommendation = 1 then 'manual review required'
        else 'demonstration recommendation only'
    end as automation_boundary,
    direct_query_count_60d,
    dashboard_views_60d,
    dashboard_views_30d,
    run_count_60d,
    monthly_estimated_cost_usd,
    usage_risk_level,
    recommendation_confidence,
    owner_email,
    owner_team,
    result_classification
from {{ ref('model_usage_rollup') }}
