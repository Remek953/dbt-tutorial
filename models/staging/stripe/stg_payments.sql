with payment as (
    
    select
        id as customer_id,
        orderid as order_id,
        paymentmethod,
        status,
        {{ cents_to_dollars('amount', 4) }} as amount,
        created as created_at

    from {{ source('stripe', 'payment') }}
)

select * from payment