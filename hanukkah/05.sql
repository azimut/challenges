SELECT customers.name, customers.citystatezip, customers.phone, count(*) as foo
  FROM orders
       JOIN customers    ON orders.customerid = customers.customerid
       JOIN orders_items ON orders.orderid    = orders_items.orderid
       JOIN products     ON orders_items.sku  = products.sku
 WHERE customers.citystatezip LIKE 'Staten Island%' AND
       products.desc LIKE '%Senior Cat%'
 GROUP BY customers.name
 ORDER BY foo DESC
 LIMIT 1;
