SELECT customers.name, customers.phone, count(*)
  FROM orders
       JOIN orders_items ON orders_items.orderid = orders.orderid
       JOIN products     ON products.sku         = orders_items.sku
       JOIN customers    ON customers.customerid = orders.customerid
 WHERE products.desc LIKE 'Noah%'
 GROUP BY orders.customerid
 ORDER BY count(*) DESC
 LIMIT 1;
