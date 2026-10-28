-- PK 설정 --
ALTER TABLE users
ADD CONSTRAINT pk_users
primary key (user_id);

ALTER TABLE products
ADD CONSTRAINT pk_products
primary key (product_id);

ALTER TABLE orders
ADD CONSTRAINT pk_orders
primary key (order_id);

ALTER TABLE order_items
ADD CONSTRAINT pk_order_items
primary key (order_item_id);


-- FK 설정 --
ALTER TABLE orders
ADD CONSTRAINT fk_orders_users
foreign key (user_id)
REFERENCES users(user_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

