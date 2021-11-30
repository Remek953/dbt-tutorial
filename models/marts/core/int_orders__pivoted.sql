{%- set paymentmethod = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}

with payments as (
    SELECT * FROM {{ ref('stg_payments') }}
),

pivoted as (
    SELECT
    order_id,
    {% for payment_method in paymentmethod -%}
    sum(case when paymentmethod = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount
    {%- if not loop.last -%}
    ,
    {%- endif %}
    {% endfor -%}
    FROM payments
    WHERE status = 'success'
    group by 1
)

SELECT * FROM pivoted