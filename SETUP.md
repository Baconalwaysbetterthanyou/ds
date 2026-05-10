# TaskFlow Database Setup Instructions

## Step 1: Create the Database in DB Browser
1. Open **DB Browser for SQLite**
2. Go to **File → New Database**
3. Navigate to this folder and name it `taskflow.db`
4. Click **Save**

## Step 2: Enable Foreign Keys (IMPORTANT!)
1. Go to **Edit → Preferences**
2. Select **Database** from the left panel
3. Check the box **"Foreign keys"**
4. Click **OK**

## Step 3: Run the Schema
1. Go to the **Execute SQL** tab
2. Click **Open SQL File** (folder icon)
3. Select `schema.sql`
4. Click **Run** (play button)
5. Verify you see: "TaskFlow database schema created!"

## Step 4: Load Sample Data
1. Click **Open SQL File** again
2. Select `sample-data.sql`
3. Click **Run**
4. Verify you see:
   - teams_count: 5
   - users_count: 15
   - projects_count: 10
   - tasks_count: 30
   - comments_count: 9

## Step 5: Complete the Exercises
1. Open `exercises.sql`
2. Work through TODOs 1-5 in order
3. For each TODO:
   - Run the SELECT preview first
   - Then run your INSERT/UPDATE/DELETE
   - Run the verification SELECT
4. **Important for TODO 5**: Select all lines from BEGIN to COMMIT and run them together

## Step 6: Verify Your Work
1. Open `verify.sql`
2. Click **Run**
3. Check that all 5 TODOs show "PASS"
4. If any show "FAIL", review and fix that TODO

## Step 7: Complete Reflection
1. Open `notes.md`
2. Answer the 3 reflection questions
3. Save and submit your work

## Troubleshooting
- If foreign keys aren't working: Make sure you enabled them in Preferences BEFORE opening the database
- If you get constraint errors: Check that seed data was loaded properly
- If TODO 5 fails: Make sure you ran the entire transaction block together (BEGIN through COMMIT)
