Create schema healthcare;
Use Healthcare;
Show tables;
SELECT * FROM diabetic_data ;
-------------------------------------------------------------------------------------------------------------------
-- Calculate the total number of patient encounters in the healthcare dataset
SELECT COUNT(DISTINCT encounter_id) AS total_patient_encounters
FROM diabetic_data;
---------------------------------------------------------------------------------------------------------------------
-- Identify the top 10 most frequent diagnoses in the dataset
Select Diagnoses,count(*) as total_diagnosed
From(
Select diag_1 as diagnoses from diabetic_data
UNION ALL
Select diag_2 from diabetic_data
UNION ALL
Select diag_3 from diabetic_data
) as All_Diagnoses
Where Diagnoses IS NOT NUll
Group By Diagnoses
Order by total_diagnosed DESC
LIMIT 10;
------------------------------------------------------------------------------------------------------------
-- Calculate the average length of hospital stay for each admission type
Select Admission_type_id,Avg(time_in_hospital) as Avg_length_of_stay
From diabetic_data
Group by Admission_type_id
Order by Avg_length_of_stay DESC;
-------------------------------------------------------------------------------------------------------------
-- Determine the number of readmitted patients and the percentage of total encounters that they represent
Select Count(*) as total_encounter,
  sum( case
          when readmitted IN('>30','<30') then 1 
          else 0
	 END) as readmmited_patients,
ROUND (
		sum( case
			when readmitted IN('>30','<30') then 1 
			else 0
			END) *100/count(*),2) as readmmission_percentage
 from diabetic_data;
-----------------------------------------------------------------------------------------------------------------------
-- Identify the age distribution of patients 
SELECT 
    age,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted IN ('<30', '>30') THEN 1 ELSE 0 END) AS readmitted_patients
FROM diabetic_data
GROUP BY age
ORDER BY age ;
-----------------------------------------------------------------------------------------------------------------------
-- Identify the most common procedures performed during patient encounters 
Select num_procedures,count(*) as encounter_count
From diabetic_data
Group by num_procedures
Order by encounter_count DESC;
-------------------------------------------------------------------------------------------------------------------------------
-- Calculate the average number of medications prescribed for patients in each age group 
Select age,round(avg(num_medications),2) as medication_average
From diabetic_data
Group by age
Order by medication_average DESC;
-------------------------------------------------------------------------------------------------------------------------
-- Identify the distribution of readmission rates across different payer codes 
Select payer_code,count(*) as encounter_count,
   Sum(Case
			WHEN readmitted IN ('>30','<30')then 1
			ELSE 0
		END) as readmitted_encounter,
ROUND(
Sum(Case
		WHEN readmitted IN ('>30','<30')then 1
		ELSE 0
    END)*100/count(*),2) as readmitted_percent_rate
From diabetic_data
Group by payer_code
Order by readmitted_percent_rate DESC;
--------------------------------------------------------------------------------------------------------------------------------








          
 







