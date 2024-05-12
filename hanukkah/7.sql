WITH RECURSIVE
  sherri(tiempo, sku, desc) AS (
    SELECT orders.ordered, products.sku, substr(products.desc, 0, instr(products.desc, '(')-1)
      FROM orders
           JOIN orders_items ON orders_items.orderid = orders.orderid
           JOIN products     ON products.sku         = orders_items.sku
     WHERE orders.customerid = 4167           -- Sherri
       AND products.desc LIKE 'Noah%(%'       -- something colored
       AND orders.ordered    = orders.shipped -- inplace purchase
       AND orders_items.qty  = 1              -- one item bought
  )
SELECT customers.name, customers.phone, orders.orderid, orders.ordered, products.desc, sherri.tiempo
  FROM orders
       JOIN sherri       ON date(orders.ordered) = date(sherri.tiempo) -- same day
       JOIN orders_items ON orders_items.orderid = orders.orderid
       JOIN products     ON products.sku         = orders_items.sku
       JOIN customers    ON orders.customerid    = customers.customerid
 WHERE orders.ordered    = orders.shipped -- inplace purchase
   AND orders_items.sku != sherri.sku     -- not exact same product
   AND instr(products.desc, sherri.desc)  -- same kind of product
 ORDER by orders.ordered;
