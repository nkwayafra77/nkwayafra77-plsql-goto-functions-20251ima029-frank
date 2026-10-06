-- A4: Rewrite of A2 (Salary Review) WITHOUT GOTO
-- Same logic using IF / ELSIF / ELSE: structured, easier to read and maintain.
SET SERVEROUTPUT ON
DECLARE
  v_emp_id employees.emp_id%TYPE := 101;
  v_name   VARCHAR2(120);
  v_salary employees.monthly_salary%TYPE;
BEGIN
  SELECT first_name || ' ' || last_name, monthly_salary
    INTO v_name, v_salary
    FROM employees
   WHERE emp_id = v_emp_id;

  IF v_salary IS NULL THEN
    DBMS_OUTPUT.PUT_LINE(v_name || ': salary is missing - refer to HR.');
  ELSIF v_salary < 300000 THEN
    DBMS_OUTPUT.PUT_LINE(v_name || ': LOW band - eligible for salary review.');
  ELSIF v_salary < 800000 THEN
    DBMS_OUTPUT.PUT_LINE(v_name || ': MEDIUM band - standard annual increment.');
  ELSE
    DBMS_OUTPUT.PUT_LINE(v_name || ': HIGH band - no review needed.');
  END IF;
  DBMS_OUTPUT.PUT_LINE('Review finished for employee ' || v_emp_id);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ' not found.');
END;
/
