-- Setup: Umucyo Academy staff payroll (fictional school). Tables and sample data (Oracle). Run this FIRST.
BEGIN EXECUTE IMMEDIATE 'DROP TABLE employees PURGE';   EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE departments PURGE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE departments (
  dept_id   NUMBER        PRIMARY KEY,
  dept_name VARCHAR2(50)  NOT NULL
);

CREATE TABLE employees (
  emp_id         NUMBER         PRIMARY KEY,
  first_name     VARCHAR2(50)   NOT NULL,
  last_name      VARCHAR2(50)   NOT NULL,
  hire_date      DATE           NOT NULL,
  monthly_salary NUMBER(12,2),
  dept_id        NUMBER REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES (10, 'Administration');
INSERT INTO departments VALUES (20, 'Science');
INSERT INTO departments VALUES (30, 'Languages');
INSERT INTO departments VALUES (40, 'Mathematics');

INSERT INTO employees VALUES (101, 'Alice',   'Uwase',      DATE '2018-03-15', 1200000, 20);
INSERT INTO employees VALUES (102, 'Eric',    'Mugisha',    DATE '2021-07-01',  450000, 10);
INSERT INTO employees VALUES (103, 'Grace',   'Ineza',      DATE '2023-01-10',  250000, 30);
INSERT INTO employees VALUES (104, 'Jean',    'Habimana',   DATE '2015-09-20',  900000, 20);
INSERT INTO employees VALUES (105, 'Sandra',  'Keza',       DATE '2020-05-05',    NULL, 10); -- missing salary
INSERT INTO employees VALUES (106, 'Patrick', 'Niyonzima',  DATE '2022-11-11',  300000, NULL); -- no department
INSERT INTO employees VALUES (107, 'Diane',   'Mukamana',   DATE '2024-02-02',       0, 40); -- zero salary
COMMIT;

SELECT * FROM departments;
SELECT * FROM employees ORDER BY emp_id;
