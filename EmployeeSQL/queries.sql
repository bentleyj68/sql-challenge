-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT e.emp_no "Employee Number", e.last_name "Last Name", e.first_name "First Name", 
	e.sex "Sex", CAST(s.salary AS MONEY) "Salary"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
ORDER BY e.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
--    Note: Refer to my Data folder in the GitHub repository to see how I used Excel 
--          to convert and import employee dates using the PostgreQL Date Data Type
--          Dates stored as 'YYYY-MM-DD'

SELECT first_name "First Name", last_name "Last Name" , hire_date "Hire Date"
FROM employees 
WHERE EXTRACT(year FROM hire_date) = 1986;

-- 3. List the manager of each department with the following information: department number, 
--    department name, the manager's employee number, last name, first name.

SELECT m.dept_no "Department Number", 
	(select dept_name from departments d where d.dept_no = m.dept_no) "Department Name", 
	e.emp_no "Employee Number",	e.last_name "Last Name", e.first_name "First Name"
FROM dept_manager m, employees e
WHERE m.emp_no = e.emp_no;

-- 4. List the department of each employee with the following information: employee number, 
--	  last name, first name, and department name.

SELECT e.emp_no "Employee Number",	e.last_name "Last Name", e.first_name "First Name", 
	d.dept_name "Department Name"
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON d.dept_no = de.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" 
--    and last names begin with "B."

SELECT first_name "First Name", last_name "Last Name", sex "Gender"
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, 
--    last name, first name, and department name.

-- Starting from departments
SELECT e.emp_no "Employee Number",	e.last_name "Last Name", e.first_name "First Name",
	d.dept_name "Department Name"
FROM departments d 
JOIN dept_emp de ON de.dept_no = d.dept_no AND d.dept_name = 'Sales'
JOIN employees e ON e.emp_no = de.emp_no;

-- Query with the same results, just starting from employees
SELECT e.emp_no "Employee Number",	e.last_name "Last Name", e.first_name "First Name",
	d.dept_name "Department Name"
FROM employees e 
JOIN dept_emp de ON de.emp_no = e.emp_no  
JOIN departments d ON d.dept_no = de.dept_no AND d.dept_name = 'Sales';
 
-- 7. List all employees in the Sales and Development departments, including their employee number, 
--    last name, first name, and department name.

SELECT e.emp_no "Employee Number",	e.last_name "Last Name", e.first_name "First Name",
	d.dept_name "Department Name"
FROM employees e 
JOIN dept_emp de ON de.emp_no = e.emp_no  
JOIN departments d ON d.dept_no = de.dept_no AND (d.dept_name = 'Sales' OR d.dept_name = 'Development');
 
 
-- 8. In descending order, list the frequency count of employee last names, 
--    i.e., how many employees share each last name.

SELECT last_name, count(last_name) "Count"
FROM employees 
GROUP BY last_name 
ORDER BY "Count" DESC

-- Epilogue
select * from employees where emp_no = '499942'