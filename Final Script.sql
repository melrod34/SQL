#Use World Happiness 
USE world_happiness; 

/* This is the Script for Deliverable #3; I'm going to delete 2015, 2016, and 2017 "Happiness Rankings
because our group is aggregating the happiness scores, military, and education and creating an updated ranking for each year. 
I'll also delete the 2015 Active Troop Count, Re-Insert it, and finally update the data. */ 

#Delete Happiness Ranking Scores 
DELETE FROM scores
WHERE indicator_id = 1; 

#Dispay Happiness Ranking Scores after Deletion 
SELECT * FROM scores
WHERE indicator_id = 1;

#Delete 2015 Active Troop Counts 
DELETE FROM scores
WHERE year = 2015 AND indicator_id = 16;

#Insert 2015 Active Troop Count
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c3.country_id, si3.indicator_id, h3.`Active Troop Count`
FROM `2015 additional indicators` AS h3
JOIN country AS c3 ON h3.`Country` = c3.country_name
JOIN score_indicators AS si3 ON si3.indicator_name = 'Active Troop Count';

#Display 2015 Active Troop Counts
SELECT * FROM scores
WHERE YEAR = 2015 AND indicator_id = 16; 

#Update 2015 Troop Counts w/ Random Ints
UPDATE scores
SET score = FLOOR(1 + RAND() * 1000000)
WHERE YEAR = 2015 AND indicator_id = 16;

#Display updated 2015 Active Troop Counts
SELECT * FROM scores
WHERE YEAR = 2015 AND indicator_id = 16; 

#Function: Discover which country has the highest Happiness Score from 2015-2017
SELECT c.country_name AS `Country Name`, SUM(score) AS `Overall Happiness Score`
FROM scores AS s
JOIN country AS C ON s.country_id = c.country_id 
WHERE indicator_id = 2
AND YEAR IN (2015, 2016, 2017)
GROUP BY c.country_name;


