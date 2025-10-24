with customers as (

     select * from {{ ref('stg_jaffle_shop_customers') }}

),

orders as ( 

    select * from {{ ref('stg_jaffle_shop_orders') }}

),

payments as (
    select * from {{ref('stg_stripe_payments')}}
),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

customers_lifetime_value as (
    select o.customer_id, sum(p.amount) as lifetime_value from orders o
    left join payments p on p.orderid = o.order_id
    group by o.customer_id
),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce (customer_orders.number_of_orders, 0) 
        as number_of_orders,
        clv.lifetime_value


    from customers

    left join customer_orders using (customer_id)
    left join customers_lifetime_value clv using (clv.customer_id)

)

select * from final