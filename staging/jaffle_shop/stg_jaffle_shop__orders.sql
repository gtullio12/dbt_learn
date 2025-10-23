select
    ID as order_id,
    USER_ID as customer_id,
    ORDER_DATE,
    STATUS

from {{source('raw', 'JAFFLE_SHOP_ORDERS')}};