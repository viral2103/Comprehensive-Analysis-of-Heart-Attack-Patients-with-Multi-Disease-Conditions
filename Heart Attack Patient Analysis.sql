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

-- 11.What is the maximum and minimum blood pressure recorded in the dataset? 
select max(bloodpressure) as MaxBloodPressure,min(bloodpressure) as MinBloodPressure from heart_attack;

-- 12.How many patients have cholesterol levels above the overall average? 
select count(gender) as TotalPatients from heart_attack where cholesterol > (select avg(cholesterol) as AvgCholestrol from heart_attack);

-- 13.How many patients have blood pressure levels above the overall average? 
select count(gender) as TotalPatients from heart_attack where bloodpressure > (select avg(bloodpressure) as AvgBloodPressure from heart_attack);

-- 14.What is the correlation between cholesterol levels and blood pressure? 
SELECT 
    (AVG(Cholesterol * BloodPressure) - AVG(Cholesterol) * AVG(BloodPressure)) / 
    (STD(Cholesterol) * STD(BloodPressure)) AS correlation_value
FROM heart_attack;

-- 15.What is the distribution of heart attack cases by age group? 
select
	count(case when age > 0 and age <= 12 then gender end) as Child,
    count(case when age > 12 and age <=18  then gender end) as Teenager,
    count(case when age > 19 and age <= 29 then gender end) as YoungAdult,
    count(case when age > 29 and age <= 39 then gender end) as Adult,
    count(case when age > 39 and age <= 49 then gender end) as MiddleAdult,
    count(case when age > 49 and age <= 64 then gender end) as SeniorAdult,
    count(case when age > 64 then gender end) as Elderly
from heart_attack;
    
-- 16.How many patients are smokers, and how does smoking affect cholesterol levels? 
SELECT 
    smoker,
    AVG(cholesterol) AS Avg_Cholesterol
FROM heart_attack
GROUP BY smoker;

-- 17.What is the average cholesterol level for smokers vs. non-smokers? 
select smoker,avg(cholesterol) as AvgCholesterol from heart_attack group by smoker;

-- 18.How many patients have diabetes, and how does diabetes affect blood pressure levels? 
select diabetes,avg(bloodpressure) as AvgBloodpressure from heart_attack group by diabetes;

-- 19.What is the relationship between BMI and cholesterol levels? 
SELECT 
    CASE 
        WHEN BMI < 18.5 THEN 'Underweight'
        WHEN BMI BETWEEN 18.5 AND 24.9 THEN 'Normal weight'
        WHEN BMI BETWEEN 25 AND 29.9 THEN 'Overweight'
        ELSE 'Obese'
    END AS BMI_Category,
    AVG(cholesterol) AS Avg_Cholesterol
FROM heart_attack
GROUP BY BMI_Category;

-- 20.What is the relationship between BMI and blood pressure levels? 
SELECT 
    CASE 
        WHEN BMI < 18.5 THEN 'Underweight'
        WHEN BMI BETWEEN 18.5 AND 24.9 THEN 'Normal weight'
        WHEN BMI BETWEEN 25 AND 29.9 THEN 'Overweight'
        ELSE 'Obese'
    END AS BMI_Category,
    AVG(bloodpressure) AS Avg_Cholesterol
FROM heart_attack
GROUP BY BMI_Category;

-- 21.What is the average age of patients who had a heart attack? 
SELECT AVG(age) AS Average_Age_Heart_Attack 
FROM heart_attack
WHERE Previousheartattack = 1;

-- 22.What percentage of patients with high cholesterol also had high blood pressure? 
SELECT 
    (COUNT(CASE WHEN cholesterol > 200 AND bloodpressure > 140 THEN 1 END) * 100.0 / COUNT(*)) AS Percentage_HighCholesterol_HighBP
FROM heart_attack;

-- 23.What is the trend of heart attack occurrences by age and gender? 
SELECT 
    CASE 
        WHEN age BETWEEN 0 AND 12 THEN 'Child'
        WHEN age BETWEEN 13 AND 19 THEN 'Teenager'
        WHEN age BETWEEN 20 AND 29 THEN 'Young Adult'
        WHEN age BETWEEN 30 AND 39 THEN 'Adult'
        WHEN age BETWEEN 40 AND 49 THEN 'Middle Aged'
        WHEN age BETWEEN 50 AND 64 THEN 'Senior Adult'
        ELSE 'Elderly'
    END AS Age_Group,
    gender,
    COUNT(*) AS HeartAttackCount
FROM heart_attack
GROUP BY Age_Group, gender
ORDER BY FIELD(Age_Group, 'Child', 'Teenager', 'Young Adult', 'Adult', 'Middle Aged', 'Senior Adult', 'Elderly'), gender;

-- 24.How many patients have a family history of heart disease? 
select familyhistory,count(gender) as TotalPaintent from heart_attack group by familyhistory;

-- 25.How many patients have both high cholesterol and high blood pressure? 
SELECT COUNT(*) AS PatientsWithHighCholesterolAndBP
FROM heart_attack
WHERE cholesterol > 200 AND bloodpressure > 130;

-- 26.What is the most common age group for heart attacks? 
SELECT 
    CASE 
        WHEN age BETWEEN 0 AND 12 THEN 'Child'
        WHEN age BETWEEN 13 AND 19 THEN 'Teenager'
        WHEN age BETWEEN 20 AND 29 THEN 'Young Adult'
        WHEN age BETWEEN 30 AND 39 THEN 'Adult'
        WHEN age BETWEEN 40 AND 49 THEN 'Middle Aged'
        WHEN age BETWEEN 50 AND 64 THEN 'Senior Adult'
        ELSE 'Elderly'
    END AS AgeGroup,
    COUNT(*) AS HeartAttackCases
FROM heart_attack
GROUP BY AgeGroup
ORDER BY HeartAttackCases DESC
LIMIT 1;

-- 27.How many patients regularly exercise, and how does it affect blood pressure? 
SELECT 
    exerciseinducedangina, 
    COUNT(*) AS TotalPatients,
    AVG(bloodpressure) AS AvgBloodPressure
FROM heart_attack
GROUP BY exerciseinducedangina
ORDER BY AvgBloodPressure ASC;
