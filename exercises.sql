-- ================================================
-- W4 Database Fundamentals - Activity 02
-- TaskFlow CRUD Workout Exercises
-- ================================================
-- INSTRUCTIONS:
-- - Complete 5 TODOs below to master CRUD operations
-- - Always run the SELECT first to preview what you'll change
-- - Each TODO includes verification criteria
-- - Run verify.sql when complete to check all requirements

-- Enable foreign keys in SQLite
PRAGMA foreign_keys = ON;

-- ============================================
-- TODO 1: Add 3 new users to specific teams (one per team)
-- ============================================
-- Add 3 new users, one for each of the first 3 teams:
-- - Team 1 (Platform Engineering): 'John Doe', 'john@taskflow.io', 'Developer'
-- - Team 2 (Mobile Team): 'Jane Smith', 'jane@taskflow.io', 'Designer'  
-- - Team 3 (Product Strategy): 'Bob Wilson', 'bob@taskflow.io', 'QA'

-- First, preview the teams to get their IDs
SELECT team_id, name, department FROM teams WHERE team_id IN (1, 2, 3);

-- Preview current users count per team
SELECT team_id, COUNT(*) as current_users FROM users WHERE team_id IN (1, 2, 3) GROUP BY team_id;

-- Your INSERT statement here
INSERT INTO users (name, email, role, team_id) VALUES
('John Doe', 'john@taskflow.io', 'Developer', 1),
('Jane Smith', 'jane@taskflow.io', 'Designer', 2),
('Bob Wilson', 'bob@taskflow.io', 'QA', 3);

-- Verify the insert
SELECT team_id, COUNT(*) as new_users_count FROM users WHERE team_id IN (1, 2, 3) GROUP BY team_id;


-- ============================================
-- TODO 2: Mark every overdue task as 'Urgent' priority
-- ============================================
-- Update all tasks that are overdue (due_date < CURRENT_DATE) 
-- and not 'Done' status to have priority = 'Urgent'

-- First, preview what will be updated
SELECT 
    task_id, 
    title, 
    status, 
    priority, 
    due_date,
    CASE 
        WHEN due_date < DATE('now') AND status != 'Done' THEN 'WILL UPDATE'
        ELSE 'NO CHANGE'
    END as action_needed
FROM tasks 
ORDER BY due_date;

-- Your UPDATE statement here
UPDATE tasks
SET priority = 'Urgent'
WHERE due_date < DATE('now') AND status != 'Done';

-- Verify the update
SELECT 
    task_id, 
    title, 
    status, 
    priority, 
    due_date
FROM tasks 
WHERE due_date < DATE('now') AND status != 'Done'
ORDER BY due_date;


-- ============================================
-- TODO 3: Delete all tasks whose project status is 'Cancelled'
-- ============================================
-- Remove all tasks belonging to cancelled projects.
-- Remember: tasks have ON DELETE CASCADE with projects, so deleting
-- the project will automatically delete its tasks.

-- First, let's see if there are any cancelled projects and their tasks
SELECT 
    p.project_id,
    p.name as project_name,
    p.status,
    COUNT(t.task_id) as task_count
FROM projects p
LEFT JOIN tasks t ON p.project_id = t.project_id
WHERE p.status = 'Cancelled'
GROUP BY p.project_id, p.name, p.status;

-- Your DELETE statement here
DELETE FROM projects WHERE status = 'Cancelled';

-- Verify deletion - should return no rows
SELECT 
    p.project_id,
    p.name as project_name,
    p.status,
    COUNT(t.task_id) as task_count
FROM projects p
LEFT JOIN tasks t ON p.project_id = t.project_id
WHERE p.status = 'Cancelled'
GROUP BY p.project_id, p.name, p.status;


-- ============================================
-- TODO 4: Assign every unassigned 'Open' task to the project's owner
-- ============================================
-- Update all tasks with status = 'Open' and assignee_id IS NULL
-- Set assignee_id to the owner_id of their project (requires subquery)

-- First, preview what will be updated
SELECT 
    t.task_id,
    t.title,
    t.status,
    t.assignee_id,
    p.name as project_name,
    p.owner_id,
    u.name as owner_name,
    CASE 
        WHEN t.status = 'Open' AND t.assignee_id IS NULL THEN 'WILL UPDATE'
        ELSE 'NO CHANGE'
    END as action_needed
FROM tasks t
JOIN projects p ON t.project_id = p.project_id
LEFT JOIN users u ON p.owner_id = u.user_id
ORDER BY t.status, t.assignee_id;

-- Your UPDATE statement here
UPDATE tasks
SET assignee_id = (
    SELECT owner_id 
    FROM projects 
    WHERE project_id = tasks.project_id
)
WHERE status = 'Open' AND assignee_id IS NULL;

-- Verify the update
SELECT 
    t.task_id,
    t.title,
    t.status,
    t.assignee_id,
    p.name as project_name,
    p.owner_id,
    u.name as owner_name
FROM tasks t
JOIN projects p ON t.project_id = p.project_id
LEFT JOIN users u ON p.owner_id = u.user_id
WHERE t.status = 'Open' AND t.assignee_id IS NOT NULL
ORDER BY t.task_id;


-- ============================================
-- TODO 5: Insert a new project + 3 tasks for it in a single transaction
-- ============================================
-- Create a new project and 3 tasks for it, all in one atomic transaction.
-- In DB Browser: Select all lines from BEGIN to COMMIT and run them together.

-- Project details:
-- - Name: 'AI Integration Platform'
-- - Description: 'Integrate AI capabilities into TaskFlow'
-- - Team: Platform Engineering (team_id = 1)
-- - Owner: Sarah Chen (user_id = 1)
-- - Status: 'Planning'
-- - Deadline: '2024-06-01'

-- Tasks details:
-- 1. 'Research AI APIs' - Medium priority - due '2024-05-15'
-- 2. 'Design AI integration architecture' - High priority - due '2024-05-20'  
-- 3. 'Implement basic AI features' - High priority - due '2024-05-25'

-- Your transaction here (select all lines from BEGIN to COMMIT and run together)
BEGIN;

INSERT INTO projects (name, description, owner_id, team_id, status, deadline)
VALUES (
    'AI Integration Platform',
    'Integrate AI capabilities into TaskFlow',
    1,  -- Sarah Chen
    1,  -- Platform Engineering
    'Planning',
    '2024-06-01'
);

INSERT INTO tasks (title, description, assignee_id, project_id, status, priority, due_date) VALUES
('Research AI APIs', 'Evaluate and select AI service providers', NULL, 
    (SELECT MAX(project_id) FROM projects), 'Open', 'Medium', '2024-05-15'),
('Design AI integration architecture', 'Create technical design for AI features', NULL,
    (SELECT MAX(project_id) FROM projects), 'Open', 'High', '2024-05-20'),
('Implement basic AI features', 'Build initial AI functionality', NULL,
    (SELECT MAX(project_id) FROM projects), 'Open', 'High', '2024-05-25');

COMMIT;

-- Verify the transaction
SELECT 
    p.project_id,
    p.name as project_name,
    p.description,
    COUNT(t.task_id) as task_count
FROM projects p
LEFT JOIN tasks t ON p.project_id = t.project_id
WHERE p.name = 'AI Integration Platform'
GROUP BY p.project_id, p.name, p.description;

-- Show the tasks that were created
SELECT 
    t.task_id,
    t.title,
    t.priority,
    t.due_date,
    t.status
FROM tasks t
JOIN projects p ON t.project_id = p.project_id
WHERE p.name = 'AI Integration Platform'
ORDER BY t.task_id;


-- ============================================
-- 🎉 COMPLETION CHECKLIST
-- ============================================
-- [ ] TODO 1: Added 3 new users (1 per team)
-- [ ] TODO 2: Marked overdue tasks as Urgent
-- [ ] TODO 3: Deleted tasks for Cancelled projects
-- [ ] TODO 4: Assigned unassigned Open tasks to project owners
-- [ ] TODO 5: Created new project + 3 tasks in transaction
-- [ ] Run verify.sql to validate all requirements
-- [ ] Create notes.md with reflections

-- SUCCESS MESSAGE
-- Once you complete all TODOs and verify.sql passes, 
-- you've mastered SQL CRUD operations with complex relationships!
