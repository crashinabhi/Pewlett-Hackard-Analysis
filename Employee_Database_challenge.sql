SELECT e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO retirement_title
FROM employees as e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (ti.to_date = '9999-01-01')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)emp_no ,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_title
ORDER BY emp_no, to_date DESC;


SELECT COUNT(emp_no), 
title

INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- Use Joins, Filter, order to find the emplpoyees eleigble for mentorship
SELECT DISTINCT ON (e.emp_no)e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp as de
ON(e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON(e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (ti.to_date = '9999-01-01')
ORDER BY emp_no;

-- roles needed to be filled as the "silver tsunami" begins to make an impact?
INTO dept_retirement
FROM departments as d
INNER JOIN dept_emp AS de
ON (d.dept_no = de.dept_no)
INNER JOIN employees AS e
ON (de.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01')

SELECT COUNT(dept_no), 
dept_name

INTO Dept_retirement_count
FROM dept_retirement
GROUP BY dept_name
ORDER BY COUNT(dept_no);

-- qualified, retirement-ready employees in the departments to mentor the next generation
SELECT d.dept_no,
d.dept_name,
de.from_date,
de.to_date,
e.emp_no

INTO dept_mentorship
FROM departments as d
INNER JOIN dept_emp AS de
ON (d.dept_no = de.dept_no)
INNER JOIN employees AS e
ON (de.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01');

SELECT COUNT(dept_no), 
dept_name

INTO Dept_mentorship_count
FROM dept_mentorship
GROUP BY dept_name
ORDER BY COUNT(dept_no);