-- C1: Payroll Validator. Returns 'VALID' or 'INVALID: <reason>'.
-- Depends on B1-B4, so compile those first.
CREATE OR REPLACE FUNCTION fn_validate_payroll (p_emp_id IN NUMBER)
RETURN VARCHAR2
IS
  v_emp    employees%ROWTYPE;
  v_annual NUMBER;
  v_tax    NUMBER;
  v_years  NUMBER;
BEGIN
  IF p_emp_id IS NULL THEN
    RETURN 'INVALID: employee id is NULL';
  END IF;

  SELECT * INTO v_emp FROM employees WHERE emp_id = p_emp_id;

  IF v_emp.monthly_salary IS NULL THEN
    RETURN 'INVALID: salary is missing';
  ELSIF v_emp.monthly_salary <= 0 THEN
    RETURN 'INVALID: salary must be greater than zero';
  ELSIF v_emp.dept_id IS NULL THEN
    RETURN 'INVALID: employee has no department';
  ELSIF fn_dept_name(v_emp.dept_id) = 'Unknown' THEN
    RETURN 'INVALID: department does not exist';
  END IF;

  v_years  := fn_years_of_service(v_emp.hire_date);  -- raises if hire date is in the future
  v_annual := fn_annual_salary(v_emp.monthly_salary);
  v_tax    := fn_calculate_tax(v_annual);

  IF v_tax >= v_annual THEN
    RETURN 'INVALID: tax is not less than annual salary';
  END IF;

  RETURN 'VALID';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'INVALID: employee not found';
  WHEN OTHERS THEN
    RETURN 'INVALID: ' || SQLERRM;
END fn_validate_payroll;
/
SHOW ERRORS
