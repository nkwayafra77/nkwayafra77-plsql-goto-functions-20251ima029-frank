-- A1: Number Classifier (uses GOTO)
-- Classifies a number as negative, zero, even or odd. Change v_num to test.
SET SERVEROUTPUT ON
DECLARE
  v_num NUMBER := 15;
BEGIN
  IF v_num < 0 THEN
    GOTO negative_num;
  ELSIF v_num = 0 THEN
    GOTO zero_num;
  ELSIF MOD(v_num, 2) = 0 THEN
    GOTO even_num;
  ELSE
    GOTO odd_num;
  END IF;

  <<negative_num>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is NEGATIVE');
  GOTO finish;

  <<zero_num>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is ZERO');
  GOTO finish;

  <<even_num>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE and EVEN');
  GOTO finish;

  <<odd_num>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE and ODD');

  <<finish>>
  DBMS_OUTPUT.PUT_LINE('Classification complete.');
END;
/
