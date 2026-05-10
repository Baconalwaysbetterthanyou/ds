-- ================================================
-- W4 Database Fundamentals - Activity 02
-- TaskFlow CRUD Verification Script
-- ================================================
-- Run this script after completing all TODOs to verify completion
-- Each check returns PASS or FAIL with details

PRAGMA foreign_keys = ON;

-- ============================================
-- CHECK 1: Verify 3 new users were added
-- ============================================
SELECT 
    'TODO 1: Add 3 new users' as check_name,
    CASE 
        WHEN COUNT(*) = 18 THEN 'PASS'
        ELSE 'FAIL - Expected 18 users (15 seed + 3 new), found ' || COUNT(*)
    END as result
FROM users;

-- Show new users for verification
SELECT 
    'New users added:' as info,
    user_id,
    name,
    email,
    role,
    team_id
FROM users 
WHERE email IN ('john@taskflow.io', 'jane@taskflow.io', 'bob@taskflow.io');

-- ============================================
-- CHECK 2: No overdue non-Done tasks with non-Urgent priority
-- ============================================
SELECT 
    'TODO 2: Overdue tasks marked Urgent' as check_name,
    CASE 
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL - Found ' || COUNT(*) || ' overdue tasks not marked Urgent'
    END as result
FROM tasks
WHERE due_date < DATE('now') 
  AND status != 'Done' 
  AND priority != 'Urgent';

-- Show overdue tasks status
SELECT 
    'Overdue tasks status:' as info,
    task_id,
    title,
    status,
    priority,
    due_date
FROM tasks
WHERE due_date < DATE('now') 
  AND status != 'Done'
ORDER BY due_date;

-- ============================================
-- CHECK 3: No tasks remain for Cancelled projects
-- ============================================
SELECT 
    'TODO 3: Deleted Cancelled project tasks' as check_name,
    CASE 
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL - Found ' || COUNT(*) || ' tasks for Cancelled projects'
    END as result
FROM tasks t
JOIN projects p ON t.project_id = p.project_id
WHERE p.status = 'Cancelled';

-- Show cancelled project count (should be 0 or they should have no tasks)
SELECT 
    'Cancelled projects status:' as info,
    p.project_id,
    p.name,
    p.status,
    COUNT(t.task_id) as remaining_tasks
FROM projects p
LEFT JOIN tasks t ON p.project_id = t.project_id
WHERE p.status = 'Cancelled'
GROUP BY p.project_id, p.name, p.status;

-- ============================================
-- CHECK 4: No Open tasks with NULL assignee
-- ============================================
SELECT 
    'TODO 4: Assigned unassigned Open tasks' as check_name,
    CASE 
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL - Found ' || COUNT(*) || ' Open tasks without assignee'
    END as result
FROM tasks
WHERE status = 'Open' 
  AND assignee_id IS NULL;

-- Show Open tasks with their assignees
SELECT 
    'Open tasks assignments:' as info,
    t.task_id,
    t.title,
    t.status,
    t.assignee_id,
    u.name as assignee_name
FROM tasks t
LEFT JOIN users u ON t.assignee_id = u.user_id
WHERE t.status = 'Open'
ORDER BY t.task_id;

-- ============================================
-- CHECK 5: New project exists with 3 tasks
-- ============================================
WITH new_project AS (
    SELECT project_id 
    FROM projects 
    WHERE name = 'AI Integration Platform'
)
SELECT 
    'TODO 5: New project with 3 tasks' as check_name,
    CASE 
        WHEN COUNT(*) = 1 THEN 'PASS'
        WHEN COUNT(*) = 0 THEN 'FAIL - Project not found'
        ELSE 'FAIL - Multiple projects with same name found'
    END as result
FROM new_project;

-- Show new project details
SELECT 
    'New project details:' as info,
    p.project_id,
    p.name,
    p.description,
    p.status,
    p.deadline,
    COUNT(t.task_id) as task_count
FROM projects p
LEFT JOIN tasks t ON p.project_id = t.project_id
WHERE p.name = 'AI Integration Platform'
GROUP BY p.project_id, p.name, p.description, p.status, p.deadline;

-- Show new project tasks
SELECT 
    'New project tasks:' as info,
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
-- CHECK 5b: Verify exactly 3 tasks for new project
-- ============================================
SELECT 
    'TODO 5b: Exactly 3 tasks for new project' as check_name,
    CASE 
        WHEN task_count = 3 THEN 'PASS'
        ELSE 'FAIL - Expected 3 tasks, found ' || task_count
    END as result
FROM (
    SELECT COUNT(*) as task_count
    FROM tasks t
    JOIN projects p ON t.project_id = p.project_id
    WHERE p.name = 'AI Integration Platform'
);

-- ============================================
-- OVERALL SUMMARY
-- ============================================
SELECT 
    '=== OVERALL RESULT ===' as summary,
    CASE 
        WHEN (SELECT COUNT(*) FROM users) = 18
         AND (SELECT COUNT(*) FROM tasks WHERE due_date < DATE('now') AND status != 'Done' AND priority != 'Urgent') = 0
         AND (SELECT COUNT(*) FROM tasks t JOIN projects p ON t.project_id = p.project_id WHERE p.status = 'Cancelled') = 0
         AND (SELECT COUNT(*) FROM tasks WHERE status = 'Open' AND assignee_id IS NULL) = 0
         AND (SELECT COUNT(*) FROM projects WHERE name = 'AI Integration Platform') = 1
         AND (SELECT COUNT(*) FROM tasks t JOIN projects p ON t.project_id = p.project_id WHERE p.name = 'AI Integration Platform') = 3
        THEN 'ALL CHECKS PASSED - Activity Complete!'
        ELSE 'SOME CHECKS FAILED - Review results above'
    END as final_result;

-- ============================================
-- FINAL COUNTS
-- ============================================
SELECT 
    'Final database counts:' as info,
    (SELECT COUNT(*) FROM teams) as teams,
    (SELECT COUNT(*) FROM users) as users,
    (SELECT COUNT(*) FROM projects) as projects,
    (SELECT COUNT(*) FROM tasks) as tasks,
    (SELECT COUNT(*) FROM task_comments) as comments;
