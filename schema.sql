-- PostgreSQL Version - Activity 02 Schema
DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL CHECK(price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK(stock_quantity >= 0),
    category VARCHAR(50) NOT NULL CHECK(category IN ('Electronics', 'Accessories', 'Audio', 'Computer', 'Other')),
    brand VARCHAR(100) NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_brand ON products(brand);
