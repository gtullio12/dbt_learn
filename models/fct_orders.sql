with orders as (
    select ORDER_ID as order_id, CUSTOMER_ID as customer_id from {{ref('stg_jaffle_shop_orders')}}
),

payments as (
    select AMOUNT as amount, ORDERID as order_id from {{ref('stg_stripe_payments')}}
)

select orders.order_id, orders.customer_id, payments.amount from orders
LEFT JOIN payments
ON payments.order_id = orders.order_id