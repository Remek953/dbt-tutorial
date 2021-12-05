with orders as  (
    select * from {{ ref('stg_orders' )}}
),

payments as (
    select * from {{ ref('stg_payments') }}
),
employees as (
    select * from {{ ref('employees') }}
),

order_payments as (
    select
        order_id,
        sum(case when status = 'success' then amount end) as amount

    from payments
    group by 1
),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        employees.employee_id is not null as is_employees,
        coalesce(order_payments.amount, 0) as amount

    from orders
    left join order_payments using (order_id)
    left join employees using (customer_id)
)

select * from final