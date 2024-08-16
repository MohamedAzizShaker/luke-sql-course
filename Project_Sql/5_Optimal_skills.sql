/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

WITH Skills_Demand AS(
    SELECT 
        SD.skill_id,
        SD.skills,
        COUNT(SJD.job_id) AS demand_count
    FROM
        job_postings_fact JPF
    INNER JOIN
        skills_job_dim SJD ON JPF.job_id = SJD.job_id
    INNER JOIN
        skills_dim SD ON SJD.skill_id = SD.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY SD.skill_id
),

Average_Salary AS(
    SELECT 
        SJD.skill_id,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM
        job_postings_fact JPF
    INNER JOIN
        skills_job_dim SJD ON JPF.job_id = SJD.job_id
    INNER JOIN
        skills_dim SD ON SJD.skill_id = SD.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY SJD.skill_id
)

SELECT
    Skills_Demand.skill_id,
    Skills_Demand.skills,
    demand_count,
    avg_salary
FROM
    Skills_Demand
INNER JOIN
    Average_Salary ON Skills_Demand.skill_id = Average_Salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;





