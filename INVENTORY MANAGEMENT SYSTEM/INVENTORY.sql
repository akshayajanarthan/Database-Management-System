create database inventory_database;
use inventory_database;

CREATE TABLE product (
    product_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    quantity_in_stock INT,
    price DECIMAL(10, 2),
    category_id VARCHAR(255),
    supplier_id VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);
CREATE TABLE suppliers(
    supplier_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info TEXT
);

CREATE TABLE categories (
    category_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE orders (
    order_id VARCHAR(255) PRIMARY KEY,
    date DATE,
    total_amount DECIMAL(10, 2),
    customer_id VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE customers (
    customer_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info TEXT
);


select * from suppliers;

INSERT INTO suppliers (supplier_id, name, contact_info)
VALUES ('SUP004', 'Supplier Name', 'supplier@example.com');

DELETE FROM suppliers
WHERE supplier_id = 'SUP001';


UPDATE suppliers
SET name = 'New Supplier Name'
WHERE supplier_id = 'SUP004';

DROP TABLE supplies;
show tables;

