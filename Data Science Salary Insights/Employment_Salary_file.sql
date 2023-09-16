SELECT * FROM data_science_salary.ds_salaries;
-- 1. Which job title earns highest salary ?
SELECT work_year,experience_level,employment_type,salary_in_usd,company_location,
job_title,company_size,max(salary) AS Maximum_Salary FROM ds_salaries;

-- 2. What is the average salary for each experience level ?
SELECT experience_level , avg(salary) AS Average_Salary 
FROM ds_salaries GROUP BY experience_level;

-- 3. What is the average salary for company size Large, Small and Medium ?
SELECT company_size , avg(salary) AS Average_Salary 
FROM ds_salaries GROUP BY company_size;

-- 4. Does people working full time earns more than contract base employees ?
SELECT employment_type, AVG(salary) AS avg_salary
FROM ds_salaries
GROUP BY employment_type;

-- 5. Is salary less for employee woking remotely than who comes to office ?
SELECT remote_ratio, AVG(salary) AS avg_salary
FROM ds_salaries
GROUP BY  remote_ratio ORDER BY avg_salary DESC;

-- 6. Which country pays more to the employees ?
SELECT company_location, AVG(salary) AS avg_salary
FROM ds_salaries
GROUP BY company_location
ORDER BY avg_salary DESC;

-- 7. What is the highest earning job in highest paying countries ?
SELECT  company_location, job_title, MAX(salary) AS max_salary
FROM ds_salaries
WHERE company_location IN (
  SELECT company_location
  FROM ds_salaries
  GROUP BY company_location
  ORDER BY AVG(salary) DESC
)
GROUP BY company_location
ORDER BY max_salary DESC;

-- 8. What is the highest earning job titles working at expert level ?
SELECT job_title, MAX(salary) AS max_salary
FROM ds_salaries
WHERE experience_level = 'EX'
GROUP BY job_title
ORDER BY max_salary DESC;

-- 9. What is the highest earning job titles working at senioir level ?
SELECT job_title, MAX(salary) AS max_salary
FROM ds_salaries
WHERE experience_level = 'SE'
GROUP BY job_title
ORDER BY max_salary DESC;

-- 10. Has salary of data science job roles increased over the passing years ?
SELECT work_year, AVG(salary) AS avg_salary
FROM ds_salaries
GROUP BY work_year
ORDER BY work_year;

-- 11. What is the trend of salary paid by medium size company over the passing years ?
SELECT work_year, AVG(salary) AS avg_salary
FROM ds_salaries
WHERE company_size = 'M'
GROUP BY work_year
ORDER BY work_year;

-- 12. What is the trend of salary paid by large size company over the passing years ?
SELECT work_year, AVG(salary) AS avg_salary
FROM ds_salaries
WHERE company_size = 'L'
GROUP BY work_year
ORDER BY work_year;

-- 12. What is the trend of salary paid by large size company over the passing years ?
SELECT work_year, AVG(salary) AS avg_salary
FROM ds_salaries
WHERE company_size = 'S'
GROUP BY work_year
ORDER BY work_year;






http://youtu.be/qfyynHBFOsm
