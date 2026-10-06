-- A2: Salary Review (uses GOTO)
-- Bands (monthly, RWF): < 300,000 LOW | 300,000-799,999 MEDIUM | >= 800,000 HIGH
-- Employees to test: 101 (high), 102 (medium), 103 (low), 105 (NULL salary), 999 (not found)
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
    GOTO no_salary;
  END IF;

  IF v_salary < 300000 THEN
    GOTO low_band;
  ELSIF v_salary < 800000 THEN
    GOTO mid_band;
  ELSE
    GOTO high_band;
  END IF;

  <<low_band>>
  DBMS_OUTPUT.PUT_LINE(v_name || ': LOW band - eligible for salary review.');
  GOTO done;

  <<mid_band>>
  DBMS_OUTPUT.PUT_LINE(v_name || ': MEDIUM band - standard annual increment.');
  GOTO done;

  <<high_band>>
  DBMS_OUTPUT.PUT_LINE(v_name || ': HIGH band - no review needed.');
  GOTO done;

  <<no_salary>>
  DBMS_OUTPUT.PUT_LINE(v_name || ': salary is missing - refer to HR.');

  <<done>>
  DBMS_OUTPUT.PUT_LINE('Review finished for employee ' || v_emp_id);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ' not found.');
END;
/
