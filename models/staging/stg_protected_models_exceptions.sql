{{ config(materialized='view') }}

select
    exception_id,
    model_id,
    exception_type,
    protected_reason,
    exception_start_at,
    exception_end_at,
    approval_reference,
    approved_by,
    owner_email,
    owner_team,
    auto_recommendation_allowed,
    deprecation_allowed,
    required_review_cadence_days,
    usage_risk_level,
    recommendation_confidence,
    notes,
    data_classification
from {{ source('input_data', 'protected_models_exceptions') }}
where data_classification = 'SYNTHETIC_DUMMY_DATA'
