-- Tests for B1-B4 (expected value shown in each line)
SET SERVEROUTPUT ON
BEGIN
  -- B1
  DBMS_OUTPUT.PUT_LINE('B1 annual(100000)   = ' || fn_annual_salary(100000) || '  (expected 1200000)');
  DBMS_OUTPUT.PUT_LINE('B1 annual(NULL)     = ' || NVL(TO_CHAR(fn_annual_salary(NULL)), 'NULL') || '  (expected NULL)');
  BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_annual_salary(-5));
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('B1 annual(-5)       -> ' || SQLERRM || '  (expected ORA-20001)');
  END;

  -- B2
  DBMS_OUTPUT.PUT_LINE('B2 years(2018-03-15)= ' || fn_years_of_service(DATE '2018-03-15'));
  BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_years_of_service(SYSDATE + 10));
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('B2 future date      -> ' || SQLERRM || '  (expected ORA-20002)');
  END;

  -- B3 (annual 600,000 -> 0 | annual 1,200,000 -> 96,000 | annual 14,400,000 -> 4,056,000)
  DBMS_OUTPUT.PUT_LINE('B3 tax(600000)      = ' || fn_calculate_tax(600000)   || '  (expected 0)');
  DBMS_OUTPUT.PUT_LINE('B3 tax(1200000)     = ' || fn_calculate_tax(1200000)  || '  (expected 96000)');
  DBMS_OUTPUT.PUT_LINE('B3 tax(14400000)    = ' || fn_calculate_tax(14400000) || '  (expected 4056000)');

  -- B4
  DBMS_OUTPUT.PUT_LINE('B4 dept(20)         = ' || fn_dept_name(20)   || '  (expected Science)');
  DBMS_OUTPUT.PUT_LINE('B4 dept(99)         = ' || fn_dept_name(99)   || '  (expected Unknown)');
  DBMS_OUTPUT.PUT_LINE('B4 dept(NULL)       = ' || fn_dept_name(NULL) || '  (expected No Department)');
END;
/
