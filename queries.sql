-- ================================================
-- W4 Database Fundamentals - Activity 02
-- Query Practice: CRUD Operations (Create, Read, Update, Delete)
-- ================================================
-- INSTRUCTIONS:
-- - Queries 1-7 are WORKING (run these first to understand the pattern)
-- - Queries 8-10 are TODOs for you to complete
-- - Each TODO has clear Success Criteria

-- ============================================
-- ✅ QUERY 1: View All Products (WORKING)
-- ============================================
-- PURPOSE: Basic SELECT to see entire inventory
-- LEARNING: Understanding product data structure

SELECT
    id,
    name,
    price,
    stock_quantity,
    category,
    brand,
    sku,
    is_active
FROM products
ORDER BY category, name;


-- ============================================
-- ✅ QUERY 2: INSERT Single Product (WORKING)
-- ============================================
-- PURPOSE: Add one new product to inventory
-- LEARNING: Basic INSERT syntax

INSERT INTO products (name, description, price, stock_quantity, category, brand, sku, is_active)
VALUES (
    'Bluetooth Speaker',
    'Portable waterproof speaker with 12-hour battery life',
    49.99,
    35,
    'Audio',
    'JBL',
    'BS-011',
    1
);

-- Verify the insert
SELECT * FROM products WHERE sku = 'BS-011';


-- ============================================
-- ✅ QUERY 3: INSERT Multiple Products (WORKING)
-- ============================================
-- PURPOSE: Bulk insert for efficiency
-- LEARNING: Multi-row INSERT syntax

INSERT INTO products (name, description, price, stock_quantity, category, brand, sku, is_active) VALUES
('HDMI Cable', '6ft 4K HDMI 2.1 cable with high-speed ethernet', 14.99, 95, 'Electronics', 'AmazonBasics', 'HC-012', 1),
('Monitor Stand', 'Adjustable monitor riser with storage drawer', 35.99, 42, 'Accessories', 'VIVO', 'MS-013', 1);

-- Verify the inserts
SELECT * FROM products WHERE sku IN ('HC-012', 'MS-013');


-- ============================================
-- ✅ QUERY 4: UPDATE Product Price (WORKING)
-- ============================================
-- PURPOSE: Modify existing product information
-- LEARNING: Basic UPDATE with WHERE clause

UPDATE products
SET price = 27.99
WHERE sku = 'WM-001';  -- Wireless Mouse price reduction

-- Verify the update
SELECT name, price FROM products WHERE sku = 'WM-001';


-- ============================================
-- ✅ QUERY 5: UPDATE with Conditions (WORKING)
-- ============================================
-- PURPOSE: Update multiple products matching criteria
-- LEARNING: UPDATE with complex WHERE conditions

-- Increase price by $5 for all Audio products
UPDATE products
SET price = price + 5.00
WHERE category = 'Audio';

-- Verify the updates
SELECT name, category, price FROM products WHERE category = 'Audio';


-- ============================================
-- ✅ QUERY 6: Safe DELETE with WHERE (WORKING)
-- ============================================
-- PURPOSE: Remove specific product from inventory
-- LEARNING: DELETE with WHERE clause (never without!)

-- First, let's preview what we'll delete
SELECT * FROM products WHERE sku = 'HC-012';

-- Now delete the HDMI cable we added earlier
DELETE FROM products WHERE sku = 'HC-012';

-- Verify deletion
SELECT COUNT(*) as remaining_products FROM products;


-- ============================================
-- ✅ QUERY 7: SELECT with Filtering (WORKING)
-- ============================================
-- PURPOSE: Query products by category
-- LEARNING: Combining SELECT with WHERE

SELECT
    name,
    price,
    stock_quantity,
    brand
FROM products
WHERE category = 'Electronics'
  AND is_active = 1
ORDER BY price DESC;


-- ============================================
-- TODO 8: Insert two new Engineering team members in one transaction
-- ============================================
-- Insert 2 new users on the Engineering team in a single atomic transaction.
-- Names, emails, and roles are up to you.
-- Verify: COUNT(*) for users on the Engineering team is 2 higher than before.

--BEGIN TRANSACTION;

INSERT INTO users (name, email, team, role)
VALUES 
('Alice Dev', 'alice@company.com', 'Engineering', 'Backend Engineer'),
('Bob Code', 'bob@company.com', 'Engineering', 'Frontend Engineer');

COMMIT;

-- Verification Check: Run this to see your new count
SELECT COUNT(*) FROM users WHERE team = 'Engineering';


-- ============================================
-- TODO 9: Move Open tasks on Active projects to In Progress
-- ============================================
-- Update the status of every task currently 'Open' whose project is 'Active'
-- so it becomes 'In Progress'. Run a SELECT first to preview the rows you'll change.
-- Verify: zero tasks remain in status 'Open' on Active projects.

-- Preview the tasks before changing them
SELECT t.id, t.title, t.status, p.name AS project_name, p.status AS project_status
FROM tasks t
JOIN projects p ON t.project_id = p.id
WHERE t.status = 'Open' AND p.status = 'Active';

UPDATE tasks
SET status = 'In Progress'
WHERE status = 'Open'
  AND project_id IN (SELECT id FROM projects WHERE status = 'Active');


-- ============================================
-- TODO 10: Safely cancel Cancelled projects
-- ============================================
-- For every project with status = 'Cancelled', remove its task_comments,
-- then its tasks, then the project itself, in a single transaction so a
-- failure leaves nothing changed.
-- Verify: SELECT COUNT(*) FROM projects WHERE status='Cancelled' returns 0,
-- and no orphan tasks or comments remain.

BEGIN TRANSACTION;

-- 1. Remove task comments linked to tasks of cancelled projects
DELETE FROM task_comments
WHERE task_id IN (
    SELECT id FROM tasks WHERE project_id IN (
        SELECT id FROM projects WHERE status = 'Cancelled'
    )
);

-- 2. Remove tasks linked to cancelled projects
DELETE FROM tasks
WHERE project_id IN (SELECT id FROM projects WHERE status = 'Cancelled');

-- 3. Finally, delete the projects themselves
DELETE FROM projects
WHERE status = 'Cancelled';

COMMIT;

-- Verification Checks: All should return 0
SELECT COUNT(*) FROM projects WHERE status = 'Cancelled';
SELECT COUNT(*) FROM tasks WHERE project_id NOT IN (SELECT id FROM projects);


-- ============================================
-- Stretch (optional, ungraded)
-- ============================================
-- - ALTER the users table to add a daily_task_limit column with a CHECK constraint.
-- - Write an "overload report" query: every user with 5+ open tasks.
-- - Add a CREATE VIEW for active projects with their team and owner names.
-- ORDER BY product_count DESC;


-- ============================================
-- 🎉 COMPLETION CHECKLIST
-- ============================================
-- [ ] Ran all 7 working queries successfully
-- [ ] Completed TODO 8: Bulk INSERT with transaction
-- [ ] Completed TODO 9: Complex UPDATE with CASE
-- [ ] Completed TODO 10: Safe DELETE with constraints
-- [ ] (Optional) Attempted bonus challenges
-- [ ] Tested queries return expected results
-- [ ] Code is clean and commented

-- SUCCESS MESSAGE
-- Once you complete all TODOs, you've mastered SQL data manipulation!
-- Next Activity: Advanced queries with JOINs for multi-table relationships
