select
    model_id,
    recommendation_type,
    automation_boundary
from {{ ref('model_optimization_recommendations') }}
where automation_boundary = 'no automatic modification or deprecation'
  and recommendation_type <> 'retain_protected_model'
