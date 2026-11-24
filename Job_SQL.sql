CREATE DATABASE job;
USE job;
SHOW TABLES;

SELECT 'job_companies' AS table_name, COUNT(*) AS total_records FROM job_companies
UNION ALL
SELECT 'job_countries', COUNT(*) FROM job_countries
UNION ALL
SELECT 'job_platforms', COUNT(*) FROM job_platforms
UNION ALL
SELECT 'job_postings', COUNT(*) FROM job_postings
UNION ALL
SELECT 'job_skill_types', COUNT(*) FROM job_skill_types
UNION ALL
SELECT 'job_skills', COUNT(*) FROM job_skills;

DESCRIBE job_postings;
DESCRIBE job_skill_types;
DESCRIBE job_postings;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT job_id) AS unique_job_ids,
    COUNT(*) - COUNT(DISTINCT job_id) AS duplicate_job_ids
FROM job_postings;

SELECT job_title, COUNT(*) AS total_jobs
FROM job_postings
GROUP BY job_title
ORDER BY total_jobs DESC;

SELECT experience_level, COUNT(*) AS total_jobs
FROM job_postings
GROUP BY experience_level
ORDER BY total_jobs DESC;

SELECT employment_type, COUNT(*) AS total_jobs
FROM job_postings
GROUP BY employment_type
ORDER BY total_jobs DESC;

SELECT remote_option,COUNT(*) AS total_jobs
FROM job_postings
GROUP BY remote_option
ORDER BY total_jobs DESC;

SELECT c.country, COUNT(*) AS total_jobs
FROM job_postings p JOIN job_countries c
ON p.country_id = c.country_id
GROUP BY c.country ORDER BY total_jobs DESC;

-- Building relationship

ALTER TABLE job_companies
ADD PRIMARY KEY (company_id);
ALTER TABLE job_countries
ADD PRIMARY KEY (country_id);
ALTER TABLE job_platforms
ADD PRIMARY KEY (platform_id);
ALTER TABLE job_skills
ADD PRIMARY KEY (skill_id);

-- job_posting
ALTER TABLE job_postings
MODIFY job_id VARCHAR(100) NOT NULL,
MODIFY company_id INT NOT NULL,
MODIFY country_id INT NOT NULL,
MODIFY platform_id INT NOT NULL,
ADD PRIMARY KEY (job_id);

-- COMPOSITE KEY
ALTER TABLE job_skill_types
MODIFY job_id VARCHAR(100) NOT NULL,
MODIFY skill_id INT NOT NULL,
ADD PRIMARY KEY (job_id, skill_id);

-- FOREIGN KEYS
ALTER TABLE job_postings
ADD CONSTRAINT fk_postings_company
FOREIGN KEY (company_id)
REFERENCES job_companies(company_id),

ADD CONSTRAINT fk_postings_country
FOREIGN KEY (country_id)
REFERENCES job_countries(country_id),

ADD CONSTRAINT fk_postings_platform
FOREIGN KEY (platform_id)
REFERENCES job_platforms(platform_id);

ALTER TABLE job_skill_types
ADD CONSTRAINT fk_skilltypes_job
FOREIGN KEY (job_id)
REFERENCES job_postings(job_id),

ADD CONSTRAINT fk_skilltypes_skill
FOREIGN KEY (skill_id)
REFERENCES job_skills(skill_id);


-- 1 – Joins and skill-demand analysis
SELECT jp.job_id,jp.job_title,jc.company,jco.country,jpl.platform,jp.experience_level
FROM job_postings jp INNER JOIN job_companies jc
    ON jp.company_id = jc.company_id
INNER JOIN job_countries jco
    ON jp.country_id = jco.country_id
INNER JOIN job_platforms jpl
    ON jp.platform_id = jpl.platform_id;
    
-- 2. Display job titles with their associated skills
SELECT jp.job_id, jp.job_title, js.skill
FROM job_postings jp INNER JOIN job_skill_types jst
    ON jp.job_id = jst.job_id
INNER JOIN job_skills js
    ON jst.skill_id = js.skill_id
ORDER BY jp.job_title, js.skill;

-- 3. Find the top 15 most demanded skills
SELECT js.skill, COUNT(DISTINCT jst.job_id) AS job_demand
FROM job_skills js INNER JOIN job_skill_types jst
ON js.skill_id = jst.skill_id
GROUP BY js.skill_id, js.skill ORDER BY job_demand DESC 
LIMIT 15;

-- 4. Identify the skills required for each job title
SELECT jp.job_title, js.skill, COUNT(DISTINCT jp.job_id) AS job_count
FROM job_postings jp INNER JOIN job_skill_types jst
ON jp.job_id = jst.job_id
INNER JOIN job_skills js
ON jst.skill_id = js.skill_id
GROUP BY jp.job_title, js.skill_id, js.skill
ORDER BY jp.job_title, job_count DESC;

-- 5. Find the most demanded skills for Data Analyst positions
SELECT js.skill, COUNT(DISTINCT jp.job_id) AS job_demand
FROM job_postings jp INNER JOIN job_skill_types jst
ON jp.job_id = jst.job_id
INNER JOIN job_skills js
ON jst.skill_id = js.skill_id
WHERE jp.job_title = 'Data Analyst'
GROUP BY js.skill_id, js.skill
ORDER BY job_demand DESC LIMIT 15;

-- 6. Compare skill requirements across four job roles
SELECT jp.job_title, js.skill, COUNT(DISTINCT jp.job_id) AS job_demand
FROM job_postings jp INNER JOIN job_skill_types jst
    ON jp.job_id = jst.job_id
INNER JOIN job_skills js
    ON jst.skill_id = js.skill_id
WHERE jp.job_title IN ('Data Analyst','Data Scientist','Data Engineer','AI Engineer')
GROUP BY jp.job_title, js.skill_id, js.skill ORDER BY jp.job_title,job_demand DESC;

-- 7. Salary analysis and advanced SQL
SELECT job_id, job_title, experience_level,salary_min_usd
FROM job_postings WHERE salary_mid_usd > (SELECT AVG(salary_mid_usd)
FROM job_postings) ORDER BY salary_mid_usd DESC;

-- 8. Categorise jobs into salary brackets
SELECT job_id, job_title, salary_mid_usd,
    CASE
        WHEN salary_mid_usd < 75000 THEN 'Below 75K'
        WHEN salary_mid_usd < 100000 THEN '75K - 100K'
        WHEN salary_mid_usd <= 150000 THEN '100K - 150K'
	    ELSE 'Above 150K'
    END AS salary_category FROM job_postings ORDER BY salary_mid_usd DESC;
    
-- 9. Rank job titles by job demand
WITH job_demand AS ( SELECT job_title, COUNT(*) AS total_postings
FROM job_postings GROUP BY job_title)
SELECT job_title, total_postings,RANK() OVER (ORDER BY total_postings DESC) AS demand_rank
FROM job_demand ORDER BY demand_rank;

-- 10.Rank skills by demand
WITH skill_demand AS ( SELECT js.skill, COUNT(DISTINCT jst.job_id) AS total_jobs
FROM job_skills js INNER JOIN job_skill_types jst
ON js.skill_id = jst.skill_id
GROUP BY js.skill_id, js.skill)
SELECT skill, total_jobs, DENSE_RANK() OVER (ORDER BY total_jobs DESC) AS skill_rank
FROM skill_demand ORDER BY skill_rank;

-- TABLE 1 : CREATING SKILL COMBINATION TABLE FROM PYTHON

CREATE TABLE job_skillpairs (
    pair_id INT AUTO_INCREMENT PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL,
    skill_1 VARCHAR(100) NOT NULL,
    skill_2 VARCHAR(100) NOT NULL,
    job_count INT NOT NULL,
    jaccard_similarity DECIMAL(6,4) NOT NULL,
    CONSTRAINT skill_pair
    UNIQUE (job_title, skill_1, skill_2),
    CONSTRAINT job_count
    CHECK (job_count >= 5),
    CONSTRAINT chk_jaccard
    CHECK (jaccard_similarity >= 0 AND jaccard_similarity <= 1));

SELECT job_title, skill_1,skill_2, job_count, jaccard_similarity
FROM job_skillpairs ORDER BY job_count DESC, jaccard_similarity DESC
LIMIT 20;

-- TABLE 2 : CREATING SKILL DEMAND TABLE FROM PYTHON

CREATE TABLE job_skilldemand(
    demand_id INT AUTO_INCREMENT PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL,
    skill_name VARCHAR(100) NOT NULL,
    job_count INT NOT NULL,
    total_role_postings INT NOT NULL,
    demand_percentage DECIMAL(6,2) NOT NULL,
    skill_rank INT NOT NULL,
    CONSTRAINT skill_demand
    UNIQUE (job_title, skill_name),
    CONSTRAINT demand_count
    CHECK (job_count > 0 AND total_role_postings > 0),
    CONSTRAINT demand_percentage
    CHECK (demand_percentage >= 0 AND demand_percentage <= 100),
    CONSTRAINT skill_rank
    CHECK (skill_rank > 0));
    
SELECT job_title, skill_name, job_count, total_role_postings,demand_percentage,skill_rank
FROM job_skilldemand WHERE job_title = 'Data Analyst'
ORDER BY skill_rank LIMIT 10;

