# PL/SQL GOTO Statements and Functions - Individual Assignment III

| | |
|---|---|
| **Student** | Nkwaya Frank |
| **Student ID** | 20251IMA029 |
| **Course** | Database Development with PL/SQL (INSY 8311) |
| **Instructor** | Eric Maniraguha |
| **Database / tool** | Oracle, SQL*Plus |
| **Submission deadline** | Thursday, 8 October 2026, 11:59 PM |

## Project scenario
**Umucyo Academy Staff Payroll** (a fictional school in Kigali). The school stores its `departments` (Administration, Science, Languages, Mathematics) and its staff in `employees` (name, hire date, monthly salary in RWF, department).

- The **GOTO programs** classify numbers and review staff salaries.
- The **functions** calculate annual salary, years of service, tax and department name.
- The **payroll validator** checks that a staff member's data is correct before salary is paid.

The sample data deliberately includes bad cases (missing salary, zero salary, no department) so every branch and the validator can be tested. As allowed by the instructor, I chose my own scenario, tables, data, salary bands and tax bands.

## Repository structure
```
plsql-goto-functions-20251ima029-frank/
├── README.md
├── .gitignore
├── 00_setup/create_tables.sql
├── 01_goto/        A1, A2, A3, A4
├── 02_functions/   B1, B2, B3, B4, C1
├── 03_tests/       B5_functions_in_select.sql, test_functions.sql, test_validate_payroll.sql
├── screenshots/    A1, A2, A3, A4, B5, C1 outputs
└── docs/REFLECTION.md
```

## Tasks
| Task | Description | File |
|---|---|---|
| A1 | Number classifier (negative, zero, even, odd) using GOTO | `01_goto/A1_number_classifier.sql` |
| A2 | Salary review (low / medium / high / missing) using GOTO | `01_goto/A2_salary_review.sql` |
| A3 | Illegal GOTO (PLS-00375) and its fix | `01_goto/A3_illegal_goto.sql` |
| A4 | A2 rewritten without GOTO (IF / ELSIF / ELSE) | `01_goto/A4_rewrite_no_goto.sql` |
| B1 | `fn_annual_salary`: monthly salary x 12 | `02_functions/B1_fn_annual_salary.sql` |
| B2 | `fn_years_of_service`: completed years from hire date | `02_functions/B2_fn_years_of_service.sql` |
| B3 | `fn_calculate_tax`: progressive tax bands | `02_functions/B3_fn_calculate_tax.sql` |
| B4 | `fn_dept_name`: department name lookup | `02_functions/B4_fn_dept_name.sql` |
| B5 | Functions used inside a SELECT | `03_tests/B5_functions_in_select.sql` |
| C1 | `fn_validate_payroll`: returns VALID or INVALID with a reason | `02_functions/C1_fn_validate_payroll.sql` |
| C2 | Reflection | `docs/REFLECTION.md` |

## How to run
1. Run `00_setup/create_tables.sql`.
2. Run the functions in `02_functions/` in this order: B1, B2, B3, B4, then C1 (C1 uses the others).
3. Run the programs in `01_goto/` (use `SET SERVEROUTPUT ON` first).
4. Run the test files in `03_tests/`.
5. Compare the results with the screenshots in `screenshots/`.


- **A2 salary bands (monthly, RWF):** below 300,000 = LOW, 300,000 to 799,999 = MEDIUM, 800,000 and above = HIGH, NULL = missing.
- **B3 tax bands (applied to monthly income, result annualised):** up to 60,000 = 0%; 60,001 to 100,000 = 20% of the part above 60,000; above 100,000 = 8,000 plus 30% of the part above 100,000.
- **B2** returns completed years and raises an error for a future hire date.
- **B4** returns `Unknown` for a missing department and `No Department` for a NULL department.
- **C1** returns text (`VALID` or `INVALID: reason`) instead of raising an error, so it works for every row in a query.
- **A3** intentionally contains one block that fails to compile (PLS-00375), followed by the corrected block.

## Results
All outputs were run in SQL*Plus and saved in `screenshots/`:
- A1: `15 is POSITIVE and ODD`
- A2 and A4: `Alice Uwase: HIGH band - no review needed.`
- A3: PLS-00375 error, then `Fixed: label is at the outer block level`
- B5: 7 employees with department, annual salary, years of service and annual tax
- C1: employees 101 to 104 VALID; 105 salary missing; 106 no department; 107 salary zero; 999 not found; NULL id invalid

## Notes (AI use)
I used an AI assistant (Claude) to help draft the SQL code and documentation and to explain GOTO and function concepts to me. I ran every script myself in SQL*Plus, checked the outputs, took the screenshots, and can explain the code.
