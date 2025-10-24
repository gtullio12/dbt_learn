with customers as (
    select * from {{ref('stg_jaffle_shop_customers')}}
),

orders as (
    select * from {{ref('stg_jaffle_shop__orders')}}
),

select * from orders union select * from customers;