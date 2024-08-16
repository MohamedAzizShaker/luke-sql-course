/*
Question 1 : What are the top paying Data analyst jobs ?
- Identify the top 10 highest-paying Data analys roles that are available remotely.
- Foucases no job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data analysts, offering insights into employment options and location flexibility.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as Company_Name
FROM
    job_postings_fact
LEFT JOIN
     company_dim
USING
     (company_id)
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL

ORDER BY
         salary_year_avg DESC
LIMIT 10;