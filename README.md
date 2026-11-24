# Data & Technology Job Market Analysis

## Project Overview

The **Data & Technology Job Market Analysis** project explores the global data and technology job market using job postings from the 2024 dataset.

The objective is to identify in-demand job roles, analyze salary trends, understand skill requirements, and explore how employment conditions vary across countries and organizations.

This project uses Python, MySQL, and Power BI to transform raw job-market data into meaningful business insights through data analysis and interactive dashboards.

## Business Objectives

- Identify the most demanded data and technology job roles.
- Analyze job opportunities across different countries and companies.
- Understand salary variations across job roles and experience levels.
- Identify the most frequently required technical skills.
- Discover skill combinations commonly appearing together in job postings.
- Examine employment types and remote-work arrangements.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Python | Data analysis, data transformation and visualization |
| Pandas & NumPy | Data manipulation and analysis |
| Matplotlib & Seaborn | Exploratory data visualization |
| MySQL | Data storage, SQL queries and analysis |
| Power BI | Interactive dashboards and business reporting |

## Dataset Description

The project uses the **Job Market Intelligence 2024 – Skills Global Dataset**.

The dataset contains six original tables:

- Job Companies
- Job Countries
- Job Platforms
- Job Postings
- Job Skills
- Job Skill Types

**Dataset size:**
- 3,000 job postings
- 20 companies
- 13 countries
- 10 job roles
- 26 technical skills
- 13,477 job-skill records

## Project Workflow

### 1. Data Import & Storage – MySQL
- Imported the six CSV files into MySQL.
- Examined table structures and data types.
- Checked missing values and duplicate records.
- Validated relationships between job postings, companies, countries, platforms, and skills.

### 2. Data Analysis – Python
- Connected Python to MySQL.
- Performed exploratory data analysis (EDA).
- Analyzed job demand, salary distributions, experience levels, and employment patterns.
- Identified frequently occurring skill combinations.
- Calculated role-wise skill demand percentages.
- Created visualizations to communicate important findings.

### 3. Derived Tables – Python to MySQL

Created two additional analytical tables:

**job_role_skill_pairs**
- Stores skill combinations for each job role.
- Includes the number of postings containing each pair.
- Calculates Jaccard similarity to measure skill-pair overlap.

**job_skill_demand_analysis**
- Stores skill demand for each job role.
- Includes job count and total role postings.
- Calculates skill demand percentage and skill ranking.

These derived tables were exported to MySQL for further querying and Power BI reporting.

### 4. Interactive Dashboard – Power BI

Created a two-page interactive dashboard.

**Page 1: Global Job Market Analysis**
- Total job postings, companies, countries, and roles.
- Job postings by job title.
- Job postings by country.
- Experience-level distribution.
- Work-arrangement distribution.
- Filters for country, region, job role, experience level, and employment type.

**Page 2: Salary & Skill Intelligence**
- Highest average salary.
- Total skills and skill combinations.
- Top demanded skills.
- Average salary by experience level.
- Average salary by job role.
- Most common skill combinations.
- Filters for job platform and remote-work arrangement.

## Key Insights

### 1. Job Market Demand
- Machine Learning Engineer recorded the highest number of postings (340).
- Data Scientist followed with 338 postings.
- AI Engineer accounted for 329 postings.
- Data Analyst had 319 postings, showing considerable demand for analytics roles.

### 2. Country-wise Job Opportunities
- The Netherlands recorded the highest number of job postings (258).
- UAE followed with 248 postings.
- Germany recorded 245 postings.
- India accounted for 241 postings.

This indicates that opportunities were distributed across multiple global markets.

### 3. Company-wise Hiring
- SAP recorded the highest number of postings (168).
- Amazon followed with 165 postings.
- IBM and Databricks each recorded 163 postings.
- Stripe and Nvidia each recorded 159 postings.

### 4. Salary Analysis
- Analytics Engineer recorded the highest average salary midpoint at approximately **$149,154.54**.
- Senior Data Engineer followed at approximately $148,325.31.
- AI Engineer recorded approximately $146,293.24.
- Data Analyst recorded an average salary midpoint of approximately $76,185.18.

The analysis shows considerable salary differences between analytics-focused and engineering/AI-focused roles in this dataset.

### 5. Experience-Level Analysis
- Lead-level postings: 813
- Mid-level postings: 801
- Senior-level postings: 799
- Entry-level postings: 587

Lead-level roles represented the largest category, while entry-level postings were comparatively fewer.

Average salary did not increase consistently across experience levels, suggesting that job role and other factors may also influence salary.

### 6. Work Arrangement
- Hybrid: 1,013 postings
- Remote: 996 postings
- Onsite: 991 postings

The distribution was relatively balanced, indicating that all three work arrangements were represented in the dataset.

### 7. Data Analyst Skill Demand

Among the Data Analyst postings, the leading skills included:

| Skill | Job Count | Demand |
|---|---:|---:|
| Tableau | 69 | 20.97% |
| Machine Learning | 67 | 20.36% |
| SQL | 67 | 20.36% |
| Pandas | 66 | 20.06% |
| Spark | 62 | 18.84% |

Power BI, ETL, AWS, and Azure also appeared among the top 10 skills.

This highlights the importance of SQL, data visualization, Python-related tools, and data-processing technologies for Data Analyst roles in this dataset.

### 8. Skill Combination Analysis
The analysis identified frequently co-occurring skills within individual job roles.

Examples include:
- Business Intelligence Analyst: Excel + Tableau (20 postings).
- Data Engineer: AWS + Airflow (19 postings).
- Data Scientist: Excel + GCP (18 postings).
- AI Engineer: Machine Learning + Spark (18 postings).
- Data Analyst: Machine Learning + NLP (17 postings).

These combinations provide insight into the technical skills employers may expect candidates to use together.

### 9. Salary and Applicant Relationship
The correlation between salary midpoint and estimated applicants was approximately -0.0185 (Pearson correlation).

This indicates an extremely weak linear relationship in the analyzed dataset. Salary alone did not show a meaningful association with estimated applicant numbers.

## Business Recommendations

1. **Focus on high-demand roles:** Job seekers can explore Data Analyst, Data Scientist, AI Engineer, and Data Engineer opportunities based on their interests and skill sets.

2. **Develop relevant technical skills:** Strengthen SQL, Python, Tableau, Power BI, Pandas, and other tools that frequently appear in analytics job postings.

3. **Build complementary skills:** Learning combinations such as SQL + Tableau, Excel + Tableau, and Python + Pandas can help candidates prepare for practical job requirements.

4. **Explore global opportunities:** Job seekers can compare opportunities across countries instead of limiting their search to one market.

5. **Improve entry-level readiness:** Since entry-level postings were fewer than other experience categories, candidates should build practical projects, portfolios, and demonstrable technical skills.

## Conclusion

This project demonstrates how data analytics can be used to understand job-market trends, salary patterns, and technical skill requirements.

By combining Python-based analysis, MySQL querying, and Power BI visualization, the project converts raw job-posting data into actionable insights that can support career planning and recruitment decisions.

The analysis also demonstrates an end-to-end data analytics workflow, from data preparation and validation to analytical reporting and interactive dashboard development.

## Important Note

The findings are based on the 2024 dataset used in this project and should not be interpreted as a complete or live representation of the global job market. Salary values are in USD and have not been adjusted for purchasing power or cost of living.
