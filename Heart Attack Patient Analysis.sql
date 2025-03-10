use project;

select * from heart_attack;

-- 1.How many total patients are recorded in the dataset? 
select count(gender) as TotalPatients from heart_attack;

-- 2.How many male and female patients are there? 
select gender,count(gender) as Total from heart_attack group by gender;

-- OR 

select 
	sum(case when gender='male' then 1 else 0 end) as Male,
    sum(case when gender='female' then 1 else 0 end) as Female,
    sum(case when gender='other' then 1 else 0 end) as Other
from heart_attack;

-- 3.What is the average cholesterol level for all patients? 
-- We can express the cholesterol level as a percentage relative to a reference range.
-- A common range for total cholesterol is 0 to 300 mg/dL (though values above 200 mg/dL are considered high).
select avg(cholesterol) as AvgCholestrol from heart_attack;

-- 4.What is the average cholesterol level by gender? 
select gender,avg(cholesterol) as AvgCholesterol from heart_attack group by gender;

-- 5.What is the difference in average cholesterol levels between males and females? 
-- ABS(AVG(Male) - AVG(Female)) → Computes the absolute difference between the two averages
select
	avg(case when gender='male' then cholesterol end) as Male,
    avg(case when gender='female' then cholesterol end) as Female,
    abs(avg(case when gender='male' then cholesterol end) - avg(case when gender='female' then cholesterol end)) as Difference
from heart_attack;

-- 6.What is the average blood pressure for all patients? 
-- Blood pressure is recorded as systolic/diastolic (e.g., 120/80 mmHg).
select avg(bloodpressure) as AvgBloodPressure from heart_attack;

-- 7.What is the average high and low blood pressure by gender? 
select
	gender,avg(case when bloodpressure > 0 and bloodpressure <= 90 then bloodpressure end) as LowBloodPressure,
    avg(case when bloodpressure > 90 then bloodpressure end) as HighBloodPressure
    from heart_attack group by gender;

-- 8.What is the difference in average blood pressure between males and females? 
select 
	avg(case when gender='male' then bloodpressure end) as Male,
    avg(case when gender='female' then bloodpressure end) as Female,
    abs(avg(case when gender='male' then bloodpressure end) - avg(case when gender='female' then bloodpressure end)) as Difference
    from heart_attack;

-- 9.What is the average high and low blood pressure by age group?
    SELECT 
    CASE 
        WHEN age BETWEEN 0 AND 12 THEN 'Child'
        WHEN age BETWEEN 13 AND 19 THEN 'Teenager'
        WHEN age BETWEEN 20 AND 29 THEN 'Young Adult'
        WHEN age BETWEEN 30 AND 39 THEN 'Adult'
        WHEN age BETWEEN 40 AND 49 THEN 'Middle-aged'
        WHEN age BETWEEN 50 AND 64 THEN 'Senior Adult'
        ELSE 'Elderly'
    END AS Age_Group,
    AVG(CASE WHEN bloodpressure <= 90 THEN bloodpressure END) AS Low_BloodPressure,
    AVG(CASE WHEN bloodpressure > 90 THEN bloodpressure END) AS High_BloodPressure
FROM heart_attack
GROUP BY Age_Group;

-- 10.What is the maximum and minimum cholesterol recorded in the dataset? 
select max(cholesterol) as MaxCholesterol, min(cholesterol) as MinCholesterol from heart_attack;