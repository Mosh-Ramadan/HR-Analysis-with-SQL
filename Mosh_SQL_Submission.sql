select * from employee_test;
select * from employee_perf;

--1. Which department has the most employees, and which department has the fewest employees?
Select department, count (employee_id) as Total_Num
from employee_test
group by department
order by Total_Num desc;


--2. Who are the top 5 highest-earning employees in the 'Technology' department?

Select et.employee_id, region, department, monthlyIncome, monthlyrate, age
from employee_test as et
inner join employee_perf as ep
on et.employee_id = ep.employee_id
where department like '%Technology%'
order by monthlyIncome desc
limit 5;


--3. Who are the employees with awards in departments with more than 100 employees, and what are their department names?
select *, department
from employee_test
where awards_won <> 0
and department in (
	Select department
	from employee_test
	group by department
	having count(employee_id)>100
);

Select ep.*, et.department
from employee_perf as ep
inner join employee_test as et
	on ep.employee_id=et.employee_id
where et.awards_won = 1
and et.department in (
	select department 
	from employee_test
	group by department 
	having count(employee_id)>100
);

-- 1. What is the average training score of employees in each department
Select department, round (avg (ave_training_score), 2) as Average_Score 
from employee_test
group by department
order by Average_Score desc;

-- 2. What is the average previous year rating by department?

Select department, round (avg (previous_year_rating), 2) as Average_Score 
from employee_test
group by department
order by Average_Score desc;

-- 3. What is the average training score of employees by education type?
Select education, round (avg (ave_training_score), 2) as Average_Score 
from employee_test
group by education
order by Average_Score desc;


-- 4. Group Average training score into grades (A,B,C,D,E,F) and what grade
--had the highest and lowest number of employees
Select 
	Case
		When ave_training_score between 70 and 100 then 'A'
		When ave_training_score between 40 and 44 then 'E'
		When ave_training_score between 45 and 49 then 'D'
		When ave_training_score between 50 and 59 then 'C'
		When ave_training_score between 60 and 69 then 'B'
		Else 'F'
	End as Grades, count(employee_id) Num	
From employee_test
group by Grades
Order by Num desc;
		

-- 5. Which three departments have the highest average job satisfaction among employees with a Bachelor's degree?
Select department, education, round(avg (Jobsatisfaction),2) AvgJobSat
from employee_test as et
inner join employee_perf as ep
on et.employee_id = ep.employee_id
where education like '%Bachelor%'
group by department, education
order by AvgJobSat desc
limit 3;


-- 6. What is the average previous year rating by recruitment channel?
Select recruitment_channel, round (avg (previous_year_rating), 2) as Average_Score 
from employee_test
group by recruitment_channel
order by Average_Score desc;

-- 7. What is the split of gender by the previous year rating?
Select gender, round (avg (previous_year_rating), 2) as Average_Score 
from employee_test
group by gender
order by Average_Score desc;

-- 8. Based on the age group created what is the average previous year rating and average training score.

SELECT
    CASE
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '>60'
    END AS AgeGroup,
    round (avg (previous_year_rating),2) previous_Year, round (avg (ave_training_score),2) as TrainingScore
FROM employee_test
GROUP BY AgeGroup
ORDER BY TrainingScore DESC;


-- 9. What is the average age of male and female employees, and how many
-- employees are there for each gender?
Select gender, round (avg (age), 0) as Average_Score, count (employee_id) 
from employee_test
group by gender
order by Average_Score desc;

-- 10. Who are the top 5 highest-earning employees with a JobLevel of 3 or higher?

Select et.employee_id, joblevel, department, monthlyIncome, monthlyrate, age
from employee_test as et
inner join employee_perf as ep
on et.employee_id = ep.employee_id
where joblevel >= 3
order by monthlyIncome desc
limit 5;