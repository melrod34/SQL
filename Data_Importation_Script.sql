#Use world_hapiness Schema
USE world_happiness;

/* Base Datasets are 2015, 2016, and 2017. We are creating five new tables Indicator Types, 
	Score Indicators,Scores, Country, and Regions. */ 
    
#Creating Indicator Types Table
CREATE TABLE indicator_type ( 
type_id INT NOT NULL PRIMARY KEY,
type VARCHAR(45) NOT NULL,
indicator_description VARCHAR(500)
); 

/* This is a very small table with no data already existing so we will just be automatically alter
inserting information into this one */ 
INSERT INTO indicator_type (type_id, type, indicator_description) VALUES
(1, 'Happiness', 'Score Indicators that are pulled from the World Happiness Report for the following years: 2015, 2016, 2017.'),
(2, 'Education', 'Score Indicators that are pulled from student-sourced educational data.'),
(3, 'Military', 'Score Indicators that are pulled from student-sourced military data.');

#Create Score Type Table
CREATE TABLE score_indicators ( 
indicator_id INT AUTO_INCREMENT PRIMARY KEY, 
indicator_name VARCHAR(40) NOT NULL, 
score_description VARCHAR(1000), 
type_id INT NOT NULL, 
FOREIGN KEY (type_id) REFERENCES indicator_type(type_id)
); 

/* Inserting info into this table... I am doing this manually but im sure there is a way to just say iloc 
bla bla bla and import it into this but googling it would take longer than typing it out tbh so year */ 
INSERT INTO score_indicators (indicator_name, score_description, type_id) VALUES
('Happiness Rank', 'Rank of the country based on the Happiness Score.', 1),
('Happiness Score', 'A metric measured in 2015 by asking the sampled people the question: "How would you rate your happiness on a scale from 1-10', 1),
('Standard Error', 'The standard error of the happiness score.', 1),
('Economy (GDP Per Capita)', 'The extent to which GDP contributes to the calculation of the Happiness Score.', 1),
('Family', 'The extent to which Family contributes to the calculation of the Happiness Score', 1), 
('Health (Life Expectancy)', ' The extent to which Life expectancy contributed to the calculation of the Happiness Score', 1),
('Freedom', ' The extent to which Freedom contributed to the calculation of the Happiness Score.', 1), 
('Trust (Government Corruption)', 'The extent to which Perception of Corruption contributes to Happiness Score.', 1),
('Generosity', 'The extent to which Generosity contributed to the calculation of the Happiness Score.', 1),
('Dystopia Residual', 'The extent to which Dystopia Residual contributed to the calculation of the Happiness Score.', 1), 
('Educational Score', 'Averaged percentile rank of the three educational variables', 2),
('Literacy Rates', 'Rate of people who can read.', 2), 
('Average Duration of Schooling', 'Average years of schooling.', 2),
('Educational Expenditure', 'Amount of Us Dollars spent on education.', 2), 
('Military Score', 'Averaged percentile rank of the three educational variables', 3),
('Active Troop Count', 'Number of Active Troops', 3),
('Defense Spending', 'Amount of US Dollars spent on Defense', 3), 
('Total Number of Aircraft', 'Number of functional military aircraft', 3); 

#Create Region Table
CREATE TABLE region ( 
region_id INT AUTO_INCREMENT PRIMARY KEY,
region_name varchar(100) NOT NULL
); 

#Insert DISTINCT REGIONS from happiness: 2015 into Region Table
INSERT INTO region(region_name)
SELECT DISTINCT region FROM happiness_2015;

#Create Country Table 
CREATE TABLE country (
country_id INT AUTO_INCREMENT PRIMARY KEY, 
country_name VARCHAR(100) NOT NULL, 
region_id INT, 
FOREIGN KEY (region_id) REFERENCES region (region_id)
);

#Insert DISTINCT Country Names from Happiness_2015 into country
INSERT INTO country (country_name, region_id)
SELECT DISTINCT country, r.region_id
FROM happiness_2015 AS H
JOIN region as R on h.Region = r.region_name;

#Create Score Table
CREATE TABLE scores ( 
score_id INT AUTO_INCREMENT PRIMARY KEY, 
year INT NOT NULL, 
country_id INT, 
indicator_id INT,
score DECIMAL(12,5), 
FOREIGN KEY (country_id) REFERENCES country(country_id),
FOREIGN KEY (indicator_id) REFERENCES score_indicators(indicator_id)
); 

#Insert 2015 Happiness Rank
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Happiness Rank`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Happiness Rank';

#Insert 2015 Happiness Score
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Happiness Score`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Happiness Score';

#Insert 2015 Standard Error
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Standard Error`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Standard Error';

#Insert 2015 Economy (GDP per Capita)
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Economy (GDP per Capita)`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Economy (GDP Per Capita)';

#Insert 2015 Family
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Family`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Family';

#Insert 2015 Health (Life Expectancy)
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Health (Life Expectancy)`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Health (Life Expectancy)';

#Insert 2015 Freedom
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Freedom`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Freedom';

#Insert 2015 Trust (Government Corruption)
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Trust (Government Corruption)`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Trust (Government Corruption)';

#Insert 2015 Generosity
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Generosity`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Generosity';

#Insert 2015 Dystopia Residual
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c.country_id, si.indicator_id, h.`Dystopia Residual`
FROM happiness_2015 AS h
JOIN country AS c ON h.`Country` = c.country_name
JOIN score_indicators AS si ON si.indicator_name = 'Dystopia Residual';

#Insert 2015 Active Troop Count
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c3.country_id, si3.indicator_id, h3.`Military Score`
FROM `2015 additional indicators` AS h3
JOIN country AS c3 ON h3.`Country` = c3.country_name
JOIN score_indicators AS si3 ON si3.indicator_name = 'Military Score';

#Insert 2015 Active Troop Count
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c3.country_id, si3.indicator_id, h3.`Active Troop Count`
FROM `2015 additional indicators` AS h3
JOIN country AS c3 ON h3.`Country` = c3.country_name
JOIN score_indicators AS si3 ON si3.indicator_name = 'Active Troop Count';

#Insert 2015 Defense Spending
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c3.country_id, si3.indicator_id, h3.`Defense Spending`
FROM `2015 additional indicators` AS h3
JOIN country AS c3 ON h3.`Country` = c3.country_name
JOIN score_indicators AS si3 ON si3.indicator_name = 'Defense Spending';

#Insert 2015 Total Number of Aircrafts
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c3.country_id, si3.indicator_id, h3.`Number of Aircrafts`
FROM `2015 additional indicators` AS h3
JOIN country AS c3 ON h3.`Country` = c3.country_name
JOIN score_indicators AS si3 ON si3.indicator_name = 'Total Number of Aircraft';

#Insert 2015 Educational Score
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c3.country_id, si3.indicator_id, h3.`Educational Score`
FROM `2015 additional indicators` AS h3
JOIN country AS c3 ON h3.`Country` = c3.country_name
JOIN score_indicators AS si3 ON si3.indicator_name = 'Educational Score';

#Insert 2015 Literacy Rate
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c3.country_id, si3.indicator_id, h3.`Literacy Rate`
FROM `2015 additional indicators` AS h3
JOIN country AS c3 ON h3.`Country` = c3.country_name
JOIN score_indicators AS si3 ON si3.indicator_name = 'Literacy Rates';

#Insert 2015 Educational Expenditure
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c3.country_id, si3.indicator_id, h3.`Educational Expenditure`
FROM `2015 additional indicators` AS h3
JOIN country AS c3 ON h3.`Country` = c3.country_name
JOIN score_indicators AS si3 ON si3.indicator_name = 'Educational Expenditure';

#Insert 2015 Average Duration of Schooling
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2015, c3.country_id, si3.indicator_id, h3.`Average Duration of Schooling`
FROM `2015 additional indicators` AS h3
JOIN country AS c3 ON h3.`Country` = c3.country_name
JOIN score_indicators AS si3 ON si3.indicator_name = 'Average Duration of Schooling';

#Insert 2016 Happiness Rank
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c1.country_id, si1.indicator_id, h1.`Happiness Rank`
FROM happiness_2016 AS h1
JOIN country AS c1 ON h1.`Country` = c1.country_name
JOIN score_indicators AS si1 ON si1.indicator_name = 'Happiness Rank';

#Insert 2016 Happiness Score
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c1.country_id, si1.indicator_id, h1.`Happiness Score`
FROM happiness_2016 AS h1
JOIN country AS c1 ON h1.`Country` = c1.country_name
JOIN score_indicators AS si1 ON si1.indicator_name = 'Happiness Score';

#Insert 2016 Economy (GDP per Capita)
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c1.country_id, si1.indicator_id, h1.`Economy (GDP per Capita)`
FROM happiness_2016 AS h1
JOIN country AS c1 ON h1.`Country` = c1.country_name
JOIN score_indicators AS si1 ON si1.indicator_name = 'Economy (GDP Per Capita)';

#Insert 2016 Family
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c1.country_id, si1.indicator_id, h1.`Family`
FROM happiness_2016 AS h1
JOIN country AS c1 ON h1.`Country` = c1.country_name
JOIN score_indicators AS si1 ON si1.indicator_name = 'Family';

#Insert 2016 Health (Life Expectancy)
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c1.country_id, si1.indicator_id, h1.`Health (Life Expectancy)`
FROM happiness_2016 AS h1
JOIN country AS c1 ON h1.`Country` = c1.country_name
JOIN score_indicators AS si1 ON si1.indicator_name = 'Health (Life Expectancy)';

#Insert 2016 Freedom
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c1.country_id, si1.indicator_id, h1.`Freedom`
FROM happiness_2016 AS h1
JOIN country AS c1 ON h1.`Country` = c1.country_name
JOIN score_indicators AS si1 ON si1.indicator_name = 'Freedom';

#Insert 2016 Trust (Government Corruption)
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c1.country_id, si1.indicator_id, h1.`Trust (Government Corruption)`
FROM happiness_2016 AS h1
JOIN country AS c1 ON h1.`Country` = c1.country_name
JOIN score_indicators AS si1 ON si1.indicator_name = 'Trust (Government Corruption)';

#Insert 2016 Generosity
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c1.country_id, si1.indicator_id, h1.`Generosity`
FROM happiness_2016 AS h1
JOIN country AS c1 ON h1.`Country` = c1.country_name
JOIN score_indicators AS si1 ON si1.indicator_name = 'Generosity';

#Insert 2016 Dystopia Residual
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c1.country_id, si1.indicator_id, h1.`Dystopia Residual`
FROM happiness_2016 AS h1
JOIN country AS c1 ON h1.`Country` = c1.country_name
JOIN score_indicators AS si1 ON si1.indicator_name = 'Dystopia Residual';

#Insert 2016 Military Score
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c4.country_id, si4.indicator_id, h4.`Military Score`
FROM `2016 additional indicators` AS h4
JOIN country AS c4 ON h4.`Country` = c4.country_name
JOIN score_indicators AS si4 ON si4.indicator_name = 'Military Score';

#Insert 2016 Active Troop Count
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c4.country_id, si4.indicator_id, h4.`Active Troop Count`
FROM `2016 additional indicators` AS h4
JOIN country AS c4 ON h4.`Country` = c4.country_name
JOIN score_indicators AS si4 ON si4.indicator_name = 'Active Troop Count';

#Insert 2016 Defense Spending
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c4.country_id, si4.indicator_id, h4.`Defense Spending`
FROM `2016 additional indicators` AS h4
JOIN country AS c4 ON h4.`Country` = c4.country_name
JOIN score_indicators AS si4 ON si4.indicator_name = 'Defense Spending';

#Insert 2016 Number of Aircrafts
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c4.country_id, si4.indicator_id, h4.`Number of Aircrafts`
FROM `2016 additional indicators` AS h4
JOIN country AS c4 ON h4.`Country` = c4.country_name
JOIN score_indicators AS si4 ON si4.indicator_name = 'Total Number of Aircraft';

#Insert 2016 Educational Score
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c4.country_id, si4.indicator_id, h4.`Educational Score`
FROM `2016 additional indicators` AS h4
JOIN country AS c4 ON h4.`Country` = c4.country_name
JOIN score_indicators AS si4 ON si4.indicator_name = 'Educational Score';

#Insert 2016 Literacy Rate
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c4.country_id, si4.indicator_id, h4.`Literacy Rate`
FROM `2016 additional indicators` AS h4
JOIN country AS c4 ON h4.`Country` = c4.country_name
JOIN score_indicators AS si4 ON si4.indicator_name = 'Literacy Rates';

#Insert 2016 Educational Expenditure
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c4.country_id, si4.indicator_id, h4.`Educational Expenditure`
FROM `2016 additional indicators` AS h4
JOIN country AS c4 ON h4.`Country` = c4.country_name
JOIN score_indicators AS si4 ON si4.indicator_name = 'Educational Expenditure';

#Insert 2016 Average Duration of Schooling
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2016, c4.country_id, si4.indicator_id, h4.`Average Duration of Schooling`
FROM `2016 additional indicators` AS h4
JOIN country AS c4 ON h4.`Country` = c4.country_name
JOIN score_indicators AS si4 ON si4.indicator_name = 'Average Duration of Schooling';

#Insert 2017 Happiness Rank
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c2.country_id, si2.indicator_id, h2.`Happiness.Rank`
FROM happiness_2017 AS h2
JOIN country AS c2 ON h2.`Country` = c2.country_name
JOIN score_indicators AS si2 ON si2.indicator_name = 'Happiness Rank';

#Insert 2017 Happiness Score
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c2.country_id, si2.indicator_id, h2.`Happiness.Score`
FROM happiness_2017 AS h2
JOIN country AS c2 ON h2.`Country` = c2.country_name
JOIN score_indicators AS si2 ON si2.indicator_name = 'Happiness Score';

#Insert 2017 Economy (GDP Per Capita)
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c2.country_id, si2.indicator_id, h2.`Economy..GDP.per.Capita.`
FROM happiness_2017 AS h2
JOIN country AS c2 ON h2.`Country` = c2.country_name
JOIN score_indicators AS si2 ON si2.indicator_name = 'Economy (GDP Per Capita)';

#Insert 2017 Family
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c2.country_id, si2.indicator_id, h2.`Family`
FROM happiness_2017 AS h2
JOIN country AS c2 ON h2.`Country` = c2.country_name
JOIN score_indicators AS si2 ON si2.indicator_name = 'Family';

#Insert 2017 Health (Life Expectancy)
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c2.country_id, si2.indicator_id, h2.`Health..Life.Expectancy.`
FROM happiness_2017 AS h2
JOIN country AS c2 ON h2.`Country` = c2.country_name
JOIN score_indicators AS si2 ON si2.indicator_name = 'Health (Life Expectancy)';

#Insert 2017 Freedom
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c2.country_id, si2.indicator_id, h2.`Freedom`
FROM happiness_2017 AS h2
JOIN country AS c2 ON h2.`Country` = c2.country_name
JOIN score_indicators AS si2 ON si2.indicator_name = 'Freedom';

#Insert 2017 Generosity
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c2.country_id, si2.indicator_id, h2.`Generosity`
FROM happiness_2017 AS h2
JOIN country AS c2 ON h2.`Country` = c2.country_name
JOIN score_indicators AS si2 ON si2.indicator_name = 'Generosity';

#Insert 2017 Trust (Government Corruption)
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c2.country_id, si2.indicator_id, h2.`Trust..Government.Corruption.`
FROM happiness_2017 AS h2
JOIN country AS c2 ON h2.`Country` = c2.country_name
JOIN score_indicators AS si2 ON si2.indicator_name = 'Trust (Government Corruption)';

#Insert 2017 Dystopia Residual
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c2.country_id, si2.indicator_id, h2.`Dystopia.Residual`
FROM happiness_2017 AS h2
JOIN country AS c2 ON h2.`Country` = c2.country_name
JOIN score_indicators AS si2 ON si2.indicator_name = 'Dystopia Residual';

#Insert 2017 Military Score
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c5.country_id, si5.indicator_id, h5.`Military Score`
FROM `2017 additional indicators` AS h5
JOIN country AS c5 ON h5.`Country` = c5.country_name
JOIN score_indicators AS si5 ON si5.indicator_name = 'Military Score';

#Insert 2017 Active Troop Count
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c5.country_id, si5.indicator_id, h5.`Active Troop Count`
FROM `2017 additional indicators` AS h5
JOIN country AS c5 ON h5.`Country` = c5.country_name
JOIN score_indicators AS si5 ON si5.indicator_name = 'Active Troop Count';

#Insert 2017 Defense Spending
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c5.country_id, si5.indicator_id, h5.`Defense Spending`
FROM `2017 additional indicators` AS h5
JOIN country AS c5 ON h5.`Country` = c5.country_name
JOIN score_indicators AS si5 ON si5.indicator_name = 'Defense Spending';

#Insert 2017 Number of Aircrafts
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c5.country_id, si5.indicator_id, h5.`Number of Aircrafts`
FROM `2017 additional indicators` AS h5
JOIN country AS c5 ON h5.`Country` = c5.country_name
JOIN score_indicators AS si5 ON si5.indicator_name = 'Total Number of Aircraft';

#Insert 2017 Educational Score
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c5.country_id, si5.indicator_id, h5.`Educational Score`
FROM `2017 additional indicators` AS h5
JOIN country AS c5 ON h5.`Country` = c5.country_name
JOIN score_indicators AS si5 ON si5.indicator_name = 'Educational Score';

#Insert 2017 Literacy Rate
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c5.country_id, si5.indicator_id, h5.`Literacy Rate`
FROM `2017 additional indicators` AS h5
JOIN country AS c5 ON h5.`Country` = c5.country_name
JOIN score_indicators AS si5 ON si5.indicator_name = 'Literacy Rates';

#Insert 2017 Educational Expenditure
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c5.country_id, si5.indicator_id, h5.`Educational Expenditure`
FROM `2017 additional indicators` AS h5
JOIN country AS c5 ON h5.`Country` = c5.country_name
JOIN score_indicators AS si5 ON si5.indicator_name = 'Educational Expenditure';

#Insert 2017 Average Duration of Schooling
INSERT INTO scores (year, country_id, indicator_id, score)
SELECT 2017, c5.country_id, si5.indicator_id, h5.`Average Duration of Schooling`
FROM `2017 additional indicators` AS h5
JOIN country AS c5 ON h5.`Country` = c5.country_name
JOIN score_indicators AS si5 ON si5.indicator_name = 'Average Duration of Schooling';








