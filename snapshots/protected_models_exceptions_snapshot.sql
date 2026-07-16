{% snapshot protected_models_exceptions_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='exception_id',
        strategy='timestamp',
        updated_at='exception_start_at'
    )
}}

select *
from {{ ref('stg_protected_models_exceptions') }}

{% endsnapshot %}
