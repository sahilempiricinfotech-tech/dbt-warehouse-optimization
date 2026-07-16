{% macro usage_band(direct_queries, dashboard_views_30d) -%}
    case
        when {{ direct_queries }} >= 10 or {{ dashboard_views_30d }} >= 20 then 'active'
        when {{ direct_queries }} > 0 or {{ dashboard_views_30d }} > 0 then 'low_usage'
        else 'inactive'
    end
{%- endmacro %}
