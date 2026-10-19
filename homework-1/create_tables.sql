-- SQL-команды для создания таблиц
CREATE TABLE customers (
    customer_id VARCHAR(5) PRIMARY KEY,
    company_name TEXT,
    contact_name TEXT
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    title TEXT,
    birth_date DATE,
    notes TEXT
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id VARCHAR(5) REFERENCES customers(customer_id),
    employee_id INTEGER REFERENCES employees(employee_id),
    order_date DATE,
    ship_city TEXT
);
