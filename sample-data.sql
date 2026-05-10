-- ================================================
-- W4 Database Fundamentals - Activity 02
-- TaskFlow Startup Sample Data
-- ================================================
-- MISSION: Rebuild TaskFlow's production database before the investor demo!
-- Data: 5 teams, 15 users, 10 projects, 30+ tasks, comments

-- ============================================
-- Insert Teams (5 departments)
-- ============================================
INSERT INTO teams (name, department, budget) VALUES
('Platform Engineering', 'Engineering', 150000.00),
('Mobile Team', 'Engineering', 120000.00),
('Product Strategy', 'Product', 90000.00),
('UX Design', 'Design', 80000.00),
('QA & Testing', 'Engineering', 70000.00);

-- ============================================
-- Insert Users (15 team members)
-- ============================================
INSERT INTO users (name, email, role, team_id) VALUES
('Sarah Chen', 'sarah@taskflow.io', 'Manager', 1),
('Mike Rodriguez', 'mike@taskflow.io', 'Developer', 1),
('Emma Watson', 'emma@taskflow.io', 'Developer', 1),
('James Kim', 'james@taskflow.io', 'Developer', 2),
('Lisa Anderson', 'lisa@taskflow.io', 'Designer', 2),
('David Park', 'david@taskflow.io', 'Product', 3),
('Rachel Green', 'rachel@taskflow.io', 'Designer', 4),
('Tom Baker', 'tom@taskflow.io', 'QA', 5),
('Nina Patel', 'nina@taskflow.io', 'Developer', 1),
('Alex Turner', 'alex@taskflow.io', 'Product', 3),
('Sophie Martin', 'sophie@taskflow.io', 'Designer', 4),
('Carlos Santos', 'carlos@taskflow.io', 'Developer', 2),
('Maya Johnson', 'maya@taskflow.io', 'QA', 5),
('Oliver Smith', 'oliver@taskflow.io', 'Manager', 2),
('Zoe Williams', 'zoe@taskflow.io', 'Developer', 1);

-- ============================================
-- Insert Projects (10 active projects)
-- ============================================
INSERT INTO projects (name, description, owner_id, team_id, status, deadline) VALUES
('Mobile App v2.0', 'Complete redesign of mobile interface', 14, 2, 'Active', '2024-03-15'),
('API Performance Optimization', 'Reduce API latency by 50%', 1, 1, 'Active', '2024-02-28'),
('User Dashboard Redesign', 'New analytics dashboard for users', 7, 4, 'Planning', '2024-04-01'),
('Real-time Collaboration', 'Add live editing capabilities', 2, 1, 'Active', '2024-03-30'),
('Security Audit 2024', 'Complete security review and fixes', 1, 1, 'Active', '2024-02-15'),
('Enterprise Features', 'Build enterprise customer features', 6, 3, 'Planning', '2024-05-01'),
('Performance Testing Suite', 'Automated performance testing', 8, 5, 'Active', '2024-03-10'),
('Dark Mode Implementation', 'Add dark mode to all interfaces', 11, 4, 'Active', '2024-02-20'),
('Data Export Tools', 'Let users export their data', 10, 3, 'Planning', '2024-04-15'),
('Notification System v3', 'Rebuild notification infrastructure', 9, 1, 'Active', '2024-03-05');

-- ============================================
-- Insert Tasks (30+ tasks across projects)
-- ============================================
INSERT INTO tasks (title, description, assignee_id, project_id, status, priority, due_date) VALUES
-- Mobile App v2.0 tasks
('Design new navigation system', 'Create wireframes for mobile nav', 5, 1, 'Done', 'High', '2024-01-20'),
('Implement swipe gestures', 'Add gesture controls to UI', 4, 1, 'In Progress', 'High', '2024-02-10'),
('Test on iOS devices', 'QA testing on iPhone and iPad', 8, 1, 'Open', 'Medium', '2024-02-25'),
-- API Performance tasks
('Profile slow API endpoints', 'Identify performance bottlenecks', 2, 2, 'Done', 'Urgent', '2024-01-25'),
('Implement caching layer', 'Add Redis caching for common queries', 9, 2, 'In Progress', 'Urgent', '2024-02-15'),
('Load testing', 'Test API under production load', 13, 2, 'Open', 'High', '2024-02-20'),
-- Dashboard Redesign tasks
('User research interviews', 'Talk to 10 enterprise customers', 10, 3, 'In Progress', 'High', '2024-02-05'),
('Create dashboard mockups', 'Design 5 dashboard variations', 7, 3, 'Open', 'Medium', '2024-02-15'),
('Analytics integration', 'Connect to data analytics service', 3, 3, 'Open', 'Medium', '2024-03-01'),
-- Real-time Collaboration tasks
('WebSocket infrastructure', 'Set up WebSocket server', 2, 4, 'Done', 'Urgent', '2024-01-30'),
('Conflict resolution logic', 'Handle concurrent edits', 9, 4, 'In Progress', 'High', '2024-02-18'),
('Presence indicators', 'Show who is online', 15, 4, 'Open', 'Medium', '2024-02-25'),
-- Security Audit tasks
('Dependency vulnerability scan', 'Check all npm packages', 2, 5, 'Done', 'Urgent', '2024-01-28'),
('Implement rate limiting', 'Prevent API abuse', 9, 5, 'In Progress', 'Urgent', '2024-02-10'),
('Security documentation', 'Write security best practices', 1, 5, 'Open', 'Medium', '2024-02-14'),
-- Enterprise Features tasks
('SSO integration', 'Add SAML authentication', 3, 6, 'Open', 'High', '2024-03-01'),
('Advanced permissions', 'Role-based access control', 15, 6, 'Open', 'High', '2024-03-15'),
('Audit logging', 'Track all user actions', 2, 6, 'Open', 'Medium', '2024-04-01'),
-- Performance Testing tasks
('Set up load testing tools', 'Configure K6 and JMeter', 13, 7, 'Done', 'High', '2024-01-22'),
('Create test scenarios', 'Write realistic load test cases', 8, 7, 'In Progress', 'High', '2024-02-08'),
('CI/CD integration', 'Run tests on every deploy', 13, 7, 'Open', 'Medium', '2024-02-28'),
-- Dark Mode tasks
('Design dark color palette', 'Choose accessible dark colors', 11, 8, 'Done', 'High', '2024-01-18'),
('Update CSS variables', 'Implement theme switching', 4, 8, 'In Progress', 'High', '2024-02-12'),
('Test accessibility', 'Verify WCAG compliance', 8, 8, 'Open', 'Medium', '2024-02-18'),
-- Data Export tasks
('Define export formats', 'Support JSON, CSV, Excel', 6, 9, 'Open', 'Medium', '2024-03-01'),
('Build export API', 'Create download endpoints', 3, 9, 'Open', 'High', '2024-03-20'),
-- Notification System tasks
('Database schema design', 'Design notification tables', 9, 10, 'Done', 'Urgent', '2024-01-25'),
('Email templates', 'Create responsive email designs', 11, 10, 'In Progress', 'High', '2024-02-15'),
('Push notification service', 'Integrate Firebase Cloud Messaging', 12, 10, 'Open', 'High', '2024-02-28'),
('Notification preferences UI', 'Let users customize notifications', 4, 10, 'Open', 'Medium', '2024-03-03');

-- ============================================
-- Add Task Comments for Collaboration
-- ============================================
INSERT INTO task_comments (task_id, user_id, comment) VALUES
(2, 4, 'Making good progress - swipe left/right working!'),
(5, 1, 'Redis caching reduced response time from 800ms to 120ms'),
(11, 15, 'Need to handle edge case when 3+ users edit simultaneously'),
(14, 9, 'Rate limiting set to 100 requests/minute per user'),
(20, 8, 'K6 scripts ready, running first load test tomorrow'),
(23, 11, 'Dark palette approved by design lead'),
(28, 11, 'Using Handlebars for email templating'),
(4, 2, 'Slowest endpoints identified: /api/projects/export and /api/reports/generate'),
(7, 10, 'Completed 6 of 10 customer interviews. Key insight: users want customizable widgets');

-- ============================================
-- Verification
-- ============================================
SELECT
    'TaskFlow Data Loaded Successfully!' as status,
    (SELECT COUNT(*) FROM teams) as teams_count,
    (SELECT COUNT(*) FROM users) as users_count,
    (SELECT COUNT(*) FROM projects) as projects_count,
    (SELECT COUNT(*) FROM tasks) as tasks_count,
    (SELECT COUNT(*) FROM task_comments) as comments_count;

-- Expected Output:
-- teams_count: 5
-- users_count: 15
-- projects_count: 10
-- tasks_count: 30
-- comments_count: 9
