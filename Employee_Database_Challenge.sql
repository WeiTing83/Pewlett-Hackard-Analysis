
-----------Deliverable 1: The Number of Retiring Employees by Title

Drop TABLE delivery1 CASCADE;

Create Table delivery1 (
	  emp_no INT,
	  birth_date date,
	  first_name VARCHAR NOT NULL,
	  last_name VARCHAR NOT NULL,
	  gender VARCHAR NOT NULL,
	  hire_date date
);
SELECT * FROM delivery1;

SELECT emp_no,first_name,last_name 
from delivery1;
---------------------------------------------------
Drop TABLE title_update CASCADE;

Create Table title_update(
	  emp_no INT,
	  title VARCHAR NOT NULL,
	  from_date date,
	  to_date date
);
SELECT * FROM title_update;


---------------------------------------------------
Drop TABLE retirement_title CASCADE;

Select emp_no,first_name,last_name
INTO retirement_title
FROM delivery1
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');
SELECT * FROM retirement_title;
----------------------------------------
create table retirement_title_2 AS
Select r.emp_no,r.first_name,r.last_name,t.title,t.from_date,t.to_date
from retirement_title as r
left join title_update as t
on r.emp_no=t.emp_no
Order by emp_no , from_date;

SELECT * FROM retirement_title_2;

-------------------------------------------------


SELECT DISTINCT ON (emp_no)emp_no,first_name,last_name,title
INTO unique_titles
FROM  retirement_title_2
ORDER BY emp_no, to_date DESC;
SELECT * FROM unique_titles;

-----------------------------------
Drop TABLE retiring_titles CASCADE;
select title
INTO retiring_titles_1
from unique_titles;

SELECT COUNT(title) AS "count", title
INTO retiring_titles
FROM retiring_titles_1
group BY title
order by count DESC;
SELECT * FROM retiring_titles_1;

-----Deliverable2:The Employees Eligible for the Mentorship Program -----------
Select emp_no,first_name,last_name,birth_date
INTO emp_info
FROM delivery1
SELECT * FROM emp_info;

Create Table dept_emp(
	  emp_no INT,
	  dept_no VARCHAR NOT NULL,
	  from_date date,
	  to_date date
);
SELECT * FROM dept_emp;

Select from_date,to_date
FROM dept_emp
SELECT * FROM emp_info;
-----------------------------------
select emp_no,title ,from_date,to_date
INTO title_update_2
FROM title_update
ORDER BY emp_no, to_date ASC;
select from title_update_2;

SELECT DISTINCT ON(emp_no)emp_no,title
INTO original_titles
FROM  title_update_2
ORDER BY emp_no ASC;
SELECT * FROM original_titles;

Drop TABLE original_titles CASCADE;

create table mentorship_eligibilty0 AS
Select d.emp_no,d.first_name,d.last_name,d.birth_date,d_e.from_date,d_e.to_date
from delivery1 as d
left join dept_emp as d_e
on d.emp_no=d_e.emp_no
Order by emp_no , to_date;
SELECT * FROM mentorship_eligibilty0;
Drop TABLE mentorship_eligibilty0 CASCADE;

create table mentorship_eligibilty AS
Select DISTINCT(o_t.emp_no)emp_no,m0.first_name,m0.last_name,m0.birth_date,m0.from_date,m0.to_date,o_t.title
from original_titles as o_t
left join mentorship_eligibilty0 as m0
on o_t.emp_no=m0.emp_no 
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
Order by to_date DESC;
SELECT * FROM mentorship_eligibilty;

Drop TABLE mentorship_eligibilty CASCADE;


