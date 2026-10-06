-- B3: Annual tax (PAYE-style progressive bands applied to MONTHLY income, result annualised)
--   monthly <=  60,000        : 0%
--   60,001  - 100,000         : 20% of the part above 60,000
--   above 100,000             : 8,000 + 30% of the part above 100,000
-- These bands are my own design choice for this project (the instructor allowed our own scenario).
CREATE OR REPLACE FUNCTION fn_calculate_tax (p_annual_salary IN NUMBER)
RETURN NUMBER
DETERMINISTIC
IS
  v_monthly NUMBER;
  v_tax     NUMBER;
BEGIN
  IF p_annual_salary IS NULL THEN
    RETURN NULL;
  END IF;
  IF p_annual_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Annual salary cannot be negative');
  END IF;

  v_monthly := p_annual_salary / 12;

  IF v_monthly <= 60000 THEN
    v_tax := 0;
  ELSIF v_monthly <= 100000 THEN
    v_tax := (v_monthly - 60000) * 0.20;
  ELSE
    v_tax := 40000 * 0.20 + (v_monthly - 100000) * 0.30;
  END IF;

  RETURN ROUND(v_tax * 12, 2);
END fn_calculate_tax;
/
SHOW ERRORS
