-- A3: Illegal GOTO and Fix
SET SERVEROUTPUT ON

-- PART 1: ILLEGAL. A GOTO cannot jump INTO an IF/LOOP/nested block.
-- Expected compile error: PLS-00375: illegal GOTO statement; this GOTO cannot branch to label 'INSIDE_IF'
BEGIN
  GOTO inside_if;
  IF 1 = 1 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Inside IF');
  END IF;
END;
/

-- PART 2: FIX. Put the label at the same (outer) block level as the GOTO.
-- A GOTO may jump out of an IF or to a label in the same/enclosing block, never into one.
BEGIN
  GOTO outer_label;
  DBMS_OUTPUT.PUT_LINE('This line is skipped');
  <<outer_label>>
  DBMS_OUTPUT.PUT_LINE('Fixed: label is at the outer block level');
END;
/
