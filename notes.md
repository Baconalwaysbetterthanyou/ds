# TaskFlow CRUD Workout - Reflection Notes

## What did you learn that you didn't know before?

*Write your answer here in 2-3 sentences. Consider surprising things like:*
- SQLite needs `PRAGMA foreign_keys = ON;` per connection for CASCADE to work
- The power of subqueries in UPDATE statements (TODO 4)
- How transactions ensure atomicity (all-or-nothing)
- The importance of previewing with SELECT before destructive operations

**Your answer:**


## How did you collaborate with AI?

*Write your answer here in 2-3 sentences:*
- What part did you contribute (prompts, verification, WHERE-first habit, bug fixes)?
- What part did the AI handle (code generation, explanations)?
- Or if you didn't use AI, what was hardest to figure out alone?

**Your answer:**


## How do you know your code works?

*Write your answer here in 2-3 sentences. Describe one specific check:*
- A row count verification
- Manual inspection of joined output
- The verify.sql passing
- Testing edge cases

**Your answer:**


---

## Activity Summary

**Date completed:** ___________

**Checklist:**
- [ ] Database created and schema loaded
- [ ] TODO 1: Added 3 new users (18 total)
- [ ] TODO 2: Overdue tasks marked as Urgent
- [ ] TODO 3: Cancelled project tasks deleted
- [ ] TODO 4: Unassigned Open tasks assigned to project owners
- [ ] TODO 5: New project + 3 tasks created in transaction
- [ ] verify.sql shows all PASS
- [ ] Reflection questions answered

**Final row counts:**
- teams: 5
- users: 18 (15 seed + 3 new)
- projects: varies (after deleting cancelled, plus new project)
- tasks: varies (after deletions and additions)
- task_comments: varies
