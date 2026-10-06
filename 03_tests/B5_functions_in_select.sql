-- B5: Using the functions inside SQL
SET LINESIZE 200
COL full_name FORMAT A22
COL department FORMAT A18
SELECT e.emp_id,
       e.first_name || ' ' || e.last_name            AS full_name,
       fn_dept_name(e.dept_id)                       AS department,
       e.monthly_salary,
       fn_annual_salary(e.monthly_salary)            AS annual_salary,
       fn_years_of_service(e.hire_date)              AS years_service,
       fn_calculate_tax(fn_annual_salary(e.monthly_salary)) AS annual_tax
  FROM employees e
 ORDER BY e.emp_id;

-- Functions in WHERE / ORDER BY
SELECT emp_id, first_name
  FROM employees
 WHERE fn_annual_salary(monthly_salary) > 5000000
 ORDER BY fn_years_of_service(hire_date) DESC;
