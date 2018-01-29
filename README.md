DISCOunt manager
================

## How to run/use
1. `git clone`
2. `bundle`
3. `rake db:setup`
4. `rails c`
    ```    
    irb(main):003:0> require 'discount/manager'
    => true
    irb(main):005:0> Discount::Manager.calculate(Order.first)
      Order Load (0.5ms)  SELECT  "orders".* FROM "orders" ORDER BY "orders"."id" ASC LIMIT $1  [["LIMIT", 1]]
      OrderLine Load (0.6ms)  SELECT "order_lines".* FROM "order_lines" WHERE "order_lines"."order_id" = $1  [["order_id", 1]]
      User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
    => 0
    
    ```
5. Let's check it: 
    ```
    irb(main):008:0> OrderLine.create(order: Order.first, item: Item.last, qty: 20)
    ...
    irb(main):009:0> Discount::Manager.calculate(Order.first)                      
    => 0.1053e3
    ```
## Epilogue/regrets

It seems so easy now... but we all know that any real code is better than imagined. I don't think this solution is nice: every discount knows about Order; hopefully Order doesn't know about them. Calculation just discount amount isn't very valuable in real world: I'd love to know what discount were used and how they were calculated. But KISS and YAGNI)


