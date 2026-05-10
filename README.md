# Activity 02 — Introduction to SQL (TaskFlow CRUD)

> **🛠️ Stack for this lesson** — SQLite via DB Browser for SQLite. Docker `mysql:8.0` + `postgres:15` shipped optionally.
> 📥 Template: [/learn/w4/template/activity-02-introduction-to-sql](/learn/w4/template/activity-02-introduction-to-sql)

A 5-table TaskFlow startup database (teams, users, projects, tasks, comments) built so you can practise the full CRUD cycle on data that looks like a real product. You'll insert, update and delete rows under realistic constraints — not toy data.

**Time:** ~50 minutes · **Concept:** Concept 02 — SQL Fundamentals

---

## What You'll Build

Three CRUD operations against the seeded TaskFlow database. Outcomes are described in `sqlite/queries.sql` — write the SQL yourself.

| # | TODO | Where |
|---|------|-------|
| 1 | Insert two new team members on the Engineering team before the demo, then return their inserted rows. | `sqlite/queries.sql` |
| 2 | Bulk-update every task currently `'Open'` whose project is `'Active'` to `'In Progress'`, then verify the updated count. | `sqlite/queries.sql` |
| 3 | Safely delete every project with status `'Cancelled'` — but only after the related tasks and comments are removed first. Wrap the delete steps so a partial failure leaves nothing changed. | `sqlite/queries.sql` |

## Run It

### SQLite

1. Open DB Browser for SQLite, **File → New Database** → save as `taskflow.db`.
2. Run `sqlite/schema.sql`, then `sample-data.sql`. **Browse Data** shows 5 teams, 15 users, 10 projects, 30 tasks, 9 comments.
3. Open `sqlite/queries.sql` and complete the 3 TODOs.

### Docker (optional)

```bash
docker-compose up -d
docker exec -it w4-mysql mysql -u root -plearning123 inventory_db
# or
docker exec -it w4-postgres psql -U postgres inventory_db
```

## Verify

- [ ] After TODO 1: `SELECT COUNT(*) FROM users WHERE team_id = (SELECT team_id FROM teams WHERE department='Engineering');` is 2 higher than before.
- [ ] After TODO 2: every task whose project is in status `'Active'` and was previously `'Open'` now shows `'In Progress'`.
- [ ] After TODO 3: `SELECT COUNT(*) FROM projects WHERE status = 'Cancelled';` returns 0, and no orphan tasks or comments reference a deleted project.

## Stretch

- Add a `daily_task_limit` CHECK constraint to `users` (max 10 active tasks per user). Show the INSERT it now blocks.
- Write a query that returns every user with 5+ open tasks (overload report).
- Add a transaction around TODO 3 that rolls back if any cascade fails.

## 🪞 Reflect on Your Work

Answer in 2-3 sentences each, in this README under your TODO commits. Your tutor reads these as part of grading.

1. **What did you learn that you didn't know before?** Pick the most surprising thing — a CHECK constraint that fired unexpectedly, the difference between DELETE and TRUNCATE, or how foreign-key cascade actually behaves on your engine.
2. **How did you collaborate with AI?** If you used Claude / ChatGPT / Cursor / Copilot, what part of the work did *you* contribute — the prompt, the verification, the design decision, the bug-fix? If you didn't use AI, what was hardest to figure out alone?
3. **How do you know your code works?** Describe one specific thing you did to confirm — the row count before and after, a SELECT query that proved the change, a screenshot of the result.

> AI is a great collaborator. Owning your thinking, verifying the output, and explaining your design choices is what *learning* looks like in this course.

## Submit

When the Verify checklist is green, head to **[/learn/w4/certification](/learn/w4/certification)** and submit your `queries.sql` link.

<!-- claude-template-fix: readme-v3 -->
