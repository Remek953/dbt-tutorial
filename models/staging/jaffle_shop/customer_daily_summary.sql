SELECT

    {{ dbt_utils.surrogate_key(['customer_id', 'order_date']) }} as id,
    customer_id,
    order_date,
    count(*)

FROM {{ ref('stg_orders') }}
group by 1, 2, 3
