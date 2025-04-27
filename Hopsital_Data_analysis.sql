create database hospital_data;
use hospital_data; 
drop table if exists hospital;
create table hospital(
Hospital_Name varchar(100),
Location varchar(60),
Department varchar(50),
Doctors_Count int,
Patients_Count int,
Medical_Expenses float,
Admission_Date date,
Discharge_Date date
);
 
/*Data Analysis*/
/*1. Total Number of Patients
•	Write an SQL query to find the total number of patients across all hospitals.*/
select distinct hospital_name, sum(patients_count) as "Total_patient_count"
from hospital
group by hospital_name;

/*Average Number of Doctors per Hospital
o Retrieve the average count of doctors available in each hospital.*/
select distinct hospital_name, round(avg(doctors_count)) as "average_count_of_doctors"
from hospital
group by hospital_name;

/*Top 3 Departments with the Highest Number of Patients
o Find the top 3 hospital departments that have the highest number of patients.*/
SELECT distinct department, sum(patients_count) as "Patients_count"
from hospital
group by department
order by Patients_count desc
limit 3;
/*Hospital with the Maximum Medical Expenses
o Identify the hospital that recorded the highest medical expenses.*/
select * from hospital;
select hospital_name,medical_expenses
from hospital
group by hospital_name,medical_expenses
order by medical_expenses desc;
/*Daily Average Medical Expenses
o Calculate the average medical expenses per day for each hospital.*/
select * from hospital;
SELECT hospital_name,
       ROUND(SUM(medical_expenses) / COUNT(DISTINCT admission_date), 2) AS avg_daily_medical_expenses
FROM hospital
GROUP BY hospital_name;

/*Longest Hospital Stay
o Find the patient with the longest stay by calculating the difference between
Discharge Date and Admission Date.*/
select distinct hospital_name,DATEDIFF(discharge_date, admission_date) AS length_of_stay
from hospital
group by hospital_name,length_of_stay
order by length_of_stay desc;
/*Total Patients Treated Per City
o Count the total number of patients treated in each city.*/
select distinct location, sum(patients_count)
from hospital
group by location;
/*Average Length of Stay Per Department
o Calculate the average number of days patients spend in each department.*/
SELECT department,
       ROUND(AVG(DATEDIFF(discharge_date, admission_date))) AS avg_length_of_stay
FROM hospital
GROUP BY department;
/*Identify the Department with the Lowest Number of Patients
o Find the department with the least number of patients.*/
WITH DepartmentRank AS (
    SELECT department, 
           SUM(patients_count) AS total_patients,
           RANK() OVER (ORDER BY SUM(patients_count)) AS rnk
    FROM hospital
    GROUP BY department
)
SELECT department, total_patients
FROM DepartmentRank
WHERE rnk = 1;
/*Monthly Medical Expenses Report
• Group the data by month and calculate the total medical expenses for each month.*/
SELECT
       MONTH(admission_date) AS month,
       ROUND(SUM(medical_expenses),2) AS total_expenses
FROM hospital
GROUP BY MONTH(admission_date)
ORDER BY MONTH(admission_date);
