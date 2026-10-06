# C2 - Reflection

**Student:** Nkwaya Frank | **ID:** 20251IMA029

## 1. What I did
I built a small payroll database for a fictional school, Umucyo Academy, with two Oracle tables (`departments` and `employees`). I then wrote four GOTO programs (A1 to A4), four stored functions (B1 to B4), a query that uses the functions (B5), and a payroll validator function (C1) that calls the other functions. I ran everything in SQL*Plus and saved screenshots of the results.

## 2. GOTO: what I learned
- `GOTO label` jumps to a label written as `<<label>>`. A label must be followed by a statement (in my programs, each label is followed by a `DBMS_OUTPUT.PUT_LINE` line).
- A GOTO can jump **out of** an IF or LOOP, or to a label in the same or an enclosing block.
- It **cannot jump into** an IF, LOOP or nested block, or into an exception handler. In A3 this gave the error `PLS-00375`, and I fixed it by moving the label to the same level as the GOTO.
- GOTO makes the flow harder to follow ("spaghetti code"). In A4 I wrote the same logic as A2 with IF / ELSIF / ELSE, and it was shorter and clearer, so I would avoid GOTO unless there is a very good reason.

## 3. Functions: what I learned
- A function must `RETURN` a value and, unlike a procedure, it can be used inside SELECT, WHERE and ORDER BY (B5).
- Functions used in SQL should not change data. Mine only read data.
- `DETERMINISTIC` fits B1 and B3 because the same input always gives the same output.
- Checking for NULL and using `RAISE_APPLICATION_ERROR` makes functions safer, for example for a negative salary or a future hire date.
- Handling `NO_DATA_FOUND` in B4 and C1 returns a clear result for a missing row instead of crashing.

## 4. Challenges
- Opening the `.sql` files on my computer was confusing at first, because Windows opened them in a file viewer program instead of Notepad. I learned that GitHub shows `.sql` files as readable text, so the teacher does not need a special program.
- Understanding why a GOTO cannot jump into an IF block took some practice, until I ran A3 and saw the `PLS-00375` error myself.
- For C1, I had to decide what the validator should do with bad data. I chose to return a text reason such as `INVALID: salary is missing` instead of raising an error, so it works for every row in a query.

## 5. AI use
I used an AI assistant (Claude) to help write the SQL code and documentation and to explain GOTO and functions to me step by step. I ran every script myself in SQL*Plus, checked the outputs against what I expected, and took the screenshots.
