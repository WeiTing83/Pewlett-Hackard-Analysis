
	
-----------------deliverable 1-------------

Select e.emp_no,e.first_name,e.last_name,t.title,t.from_date,t.to_date
INTO retirement_title
from employees as e
left join titles as t
on e.emp_no=t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
Order by emp_no;

SELECT * FROM retirement_title;


----------remove duplicate entries------------------------


SELECT DISTINCT ON (emp_no)emp_no,first_name,last_name,title
INTO unique_titles
FROM  retirement_title
ORDER BY emp_no, to_date DESC;
SELECT * FROM unique_titles;

-----------------------------------


SELECT COUNT(title) AS "count", u_t.title
INTO retiring_titles
FROM unique_titles as u_t
group BY title
order by count DESC;
SELECT * FROM retiring_titles;

-----Deliverable2:The Employees Eligible for the Mentorship Program -----------


Select DISTINCT ON (e.emp_no)e.emp_no,e.first_name,e.last_name,e.birth_date,d_e.from_date,d_e.to_date,t.title
into mentorship_eligibilty
from employees as e
LEFT join dept_emp as d_e
on e.emp_no=d_e.emp_no
inner join titles as t
on e.emp_no=t.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31') and (d_e.to_date='9999-01-01')
Order by emp_no;

SELECT * FROM mentorship_eligibilty;

Drop TABLE mentorship_eligibilty CASCADE;