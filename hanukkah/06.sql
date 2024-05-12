SELECT customers.customerid,
       customers.name,
       sum(products.wholesale_cost * orders_items.qty) AS cost,
       sum(orders_items.unit_price * orders_items.qty) AS sold,
       sum(orders_items.unit_price * orders_items.qty) - sum(products.wholesale_cost * orders_items.qty) AS diff,
       count(*)
  FROM orders
       JOIN orders_items ON orders_items.orderid = orders.orderid
       JOIN products     ON orders_items.sku     = products.sku
       JOIN customers    ON orders.customerid    = customers.customerid
 GROUP BY orders.customerid
 ORDER BY diff
 LIMIT 1;
