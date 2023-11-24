#Create a database
CREATE DATABASE corona_tests;

#use database
USE corona_tests;

#print the table
SELECT * FROM corona;

#1. Find the number of corona patients who faced shortness of breath.
SELECT count(*) FROM corona WHERE Corona = "positive" AND Shortness_of_breath = "TRUE";

#2. Find the number of negative corona patients who have fever and sore_throat.
SELECT count(*) FROM corona WHERE Corona = "negative" AND Fever = "TRUE" AND Sore_Throat = "TRUE";

#3. Group the data by month and rank the number of positive cases.
CREATE VIEW Monthly_Positive_Cases AS
(SELECT MONTH(Test_date) MONTH,COUNT(Corona) Positive_Cases FROM Corona WHERE Corona = "positive" GROUP BY MONTH(Test_date));

SELECT MONTH, Positive_Cases, RANK() OVER (ORDER BY Positive_Cases DESC) AS Rank_no FROM Monthly_Positive_Cases ORDER BY MONTH;

#4. Find the female negative corona patients who faced cough and headache.
SELECT count(*) Female_count FROM corona WHERE Corona = "negative" AND Cough_symptoms = "TRUE" AND Headache = "TRUE" AND Sex = "female";

#5. How many elderly corona patients have faced breathing problems?
SELECT COUNT(*) FROM corona WHERE Age_60_above = "Yes" AND Corona = "positive" AND Shortness_of_breath = True;

#6. Which three symptoms were more common among COVID positive patients?
SELECT 'Cough_symptoms' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" and Cough_symptoms="True"
UNION ALL
SELECT 'Fever' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" and Fever="True" 
UNION ALL
SELECT 'Sore_throat' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" and Sore_throat="True" 
UNION ALL
SELECT 'Shortness_of_breath' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" and Shortness_of_breath="True"
UNION ALL
SELECT 'Headache' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" and Headache="True" ORDER BY count DESC LIMIT 3  ;

#7. Which symptom was less common among COVID negative people?
SELECT 'Cough_symptoms' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "negative" and Cough_symptoms="True"
UNION 
SELECT 'Fever' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "negative" and Fever="True" 
UNION 
SELECT 'Sore_throat' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "negative" and Sore_throat="True" 
UNION 
SELECT 'Shortness_of_breath' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "negative" and Shortness_of_breath="True"
UNION 
SELECT 'Headache' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "negative" and Headache="True" 
ORDER BY count ASC LIMIT 1;

#8. What are the most common symptoms among COVID positive males whose known contact was abroad? 
SELECT 'Cough_symptoms' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" AND Sex="male" and Cough_symptoms = "True" AND Known_contact = "Abroad"
UNION
SELECT 'Fever' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" AND Sex="male" and Fever = "True" AND Known_contact = "Abroad"
UNION
SELECT 'Sore_throat' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" AND Sex="male" and Sore_throat = "True" AND Known_contact = "Abroad"
UNION 
SELECT 'Shortness_of_breath' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" AND Sex="male" and Shortness_of_breath = "True" AND Known_contact = "Abroad"
UNION
SELECT 'Headache' as Symptom,count(Corona) Count FROM Corona WHERE Corona = "positive" AND Sex="male" and Headache = "True" AND Known_contact = "Abroad"
ORDER BY count DESC ;

