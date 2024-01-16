create database SQL_Project

use SQL_Project

select * from Employee_Survey_Data
select * from Manager_Survey_Data

select * from HR_General_Data

select HR_General_data.*, 
       Employee_Survey_Data.EnvironmentSatisfaction, 
       Employee_Survey_Data.JobSatisfaction, 
       Employee_Survey_Data.WorkLifeBalance, 
	   Manager_Survey_Data.JobInvolvement,
	   Manager_Survey_Data.PerformanceRating
	   into SQL_Project.dbo.HR_Analysis
	   from HR_General_Data inner join Employee_Survey_Data
	   on HR_General_Data.EmployeeID = Employee_Survey_Data.EmployeeID
	   inner join Manager_Survey_Data
	   on Employee_Survey_Data.EmployeeID = Manager_Survey_Data.EmployeeID

 select * from HR_Analysis

## 1. Retrieve the total number of employees in the dataset.
select count(*) as Total_Count from HR_Analysis

## 2. List all unique job roles in the dataset.
select distinct JobRole from HR_Analysis

## 3. Find the average age of employees.
select avg(Age) as Avg_Age from HR_Analysis

## 4. Retrieve the names and ages of employees who have worked at the company for more 
than 5 years.
select Emp_Name, Age from HR_Analysis
where NumCompaniesWorked > 5

## 5. Get a count of employees grouped by their department.
select Department, count(Emp_Name) as Total_count 
from HR_Analysis
group by Department

## 6. List employees who have 'High' Job Satisfaction.select EMP_Name from HR_Analysiswhere JobSatisfaction = 3## 7. Find the highest Monthly Income in the dataset.select max(MonthlyIncome) as High_Income from HR_Analysis## 8. List employees who have 'Travel_Rarely' as their BusinessTravel type.select EMP_Name from HR_Analysiswhere BusinessTravel = 'Travel_Rarely'## 9. Retrieve the distinct MaritalStatus categories in the dataset.select distinct MaritalStatus from HR_Analysis## 10. Get a list of employees with more than 2 years of work experience but less than 4 years in 
their current role.select EMP_Name from HR_Analysiswhere TotalWorkingYears > 2 and YearsWithCurrManager < 4## 11. List employees who have changed their job roles within the company (JobLevel and 
JobRole differ from their previous job).
select distinct EMP_Name, JobRole, JobLevel from HR_Analysis

## 12. Find the average distance from home for employees in each department.
select Department, avg(DistanceFromHome) as Avg_Distance 
from HR_Analysis
group by Department

## 13. Retrieve the top 5 employees with the highest MonthlyIncome.
select top 5 EMP_Name, max(MonthlyIncome) as max_monthlyincome from HR_Analysis
group by EMP_Name
order by max_monthlyincome desc

## 14. Calculate the percentage of employees who have had a promotion in the last year.
select count(*) as Total_Employees,
sum(case when YearsSinceLastPromotion <= 1 and YearsSinceLastPromotion is not null
then 1 else 0 END) AS Promoted_Last_Year,
(sum(case when YearsSinceLastPromotion <= 1 and YearsSinceLastPromotion is not null
then 1 else 0 END) * 100)/count(*) as Percentage_of_Promotion_of_Last_Year
from HR_Analysis

## 15. List the employees with the highest and lowest EnvironmentSatisfaction.
select EMP_Name from HR_Analysis
where EnvironmentSatisfaction in (1,4)

## 16. Find the employees who have the same JobRole and MaritalStatus.
select JobRole, MaritalStatus, count(*) as TotalCount from HR_Analysis
group by JobRole, MaritalStatus
order by TotalCount

## 17. List the employees with the highest TotalWorkingYears who also have a 
PerformanceRating of 4.
select top 10 EMP_Name, max(TotalWorkingYears) as MaxWorkingYears from HR_Analysis
where PerformanceRating = 4
group by EMP_Name
order by MaxWorkingYears desc

## 18. Calculate the average Age and JobSatisfaction for each BusinessTravel type
select avg(Age) as Avg_Age, avg(JobSatisfaction) as Avg_JS, BusinessTravel from HR_Analysis
group by BusinessTravel

## 19. Retrieve the most common EducationField among employees.
select top 1 EducationField, count(EducationField) as TotalCount from HR_Analysis
group by EducationField
order by TotalCount desc

## 20. List the employees who have worked for the company the longest but haven't had a promotion.'
select top 10 EMP_Name, YearsAtCompany, YearsSinceLastPromotion from  HR_Analysis
where YearsSinceLastPromotion = 0 
order by YearsAtCompany desc