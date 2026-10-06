-- Tests for C1 fn_validate_payroll
SET SERVEROUTPUT ON
BEGIN
  FOR r IN (SELECT emp_id FROM employees ORDER BY emp_id) LOOP
    DBMS_OUTPUT.PUT_LINE('Employee ' || r.emp_id || ' -> ' || fn_validate_payroll(r.emp_id));
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Employee 999 -> ' || fn_validate_payroll(999));
  DBMS_OUTPUT.PUT_LINE('Employee NULL -> ' || fn_validate_payroll(NULL));
END;
/
-- Expected: 101-104 VALID | 105 salary missing | 106 no department | 107 zero salary | 999 not found | NULL id
SELECT emp_id, fn_validate_payroll(emp_id) AS status FROM employees ORDER BY emp_id;
