-- create table

CREATE TABLE Covid_Deaths (
	id serial PRIMARY KEY,
	iso_code varchar(8) NULL,
	continent varchar(15) NULL,
	location varchar(50) NULL,
	date date NULL,
	total_cases numeric NULL,
	new_cases numeric NULL,
	new_cases_smoothed numeric NULL,
	total_deaths numeric NULL,
	new_deaths numeric NULL,
	new_deaths_smoothed numeric NULL,
	total_cases_per_million numeric NULL,
	new_cases_per_million numeric NULL,
	new_cases_smoothed_per_million numeric NULL,
	total_deaths_per_million numeric NULL,
	new_deaths_per_million numeric NULL,
	new_deaths_smoothed_per_million numeric NULL,
	reproduction_rate numeric NULL,
	icu_patients numeric NULL,
	icu_patients_per_million numeric NULL,
	hosp_patients numeric NULL,
	hosp_patients_per_million numeric NULL,
	weekly_icu_admissions numeric NULL,
	weekly_icu_admissions_per_million numeric NULL,
	weekly_hosp_admissions numeric NULL,
	weekly_hosp_admissions_per_million numeric NULL,
	new_tests numeric NULL,
	total_tests numeric NULL,
	total_tests_per_thousand numeric NULL,
	new_tests_per_thousand numeric NULL,
	new_tests_smoothed numeric NULL,
	new_tests_smoothed_per_thousand numeric NULL,
	positive_rate numeric NULL,
	tests_per_case numeric NULL,
	tests_units varchar(50) NULL,
	total_vaccinations numeric NULL,
	people_vaccinated numeric NULL,
	people_fully_vaccinated numeric NULL,
	new_vaccinations numeric NULL,
	new_vaccinations_smoothed numeric NULL,
	total_vaccinations_per_hundred numeric NULL,
	people_vaccinated_per_hundred numeric NULL,
	people_fully_vaccinated_per_hundred numeric NULL,
	new_vaccinations_smoothed_per_million numeric NULL,
	stringency_index numeric NULL,
	population numeric NULL,
	population_density numeric NULL,
	median_age numeric NULL,
	aged_65_older numeric NULL,
	aged_70_older numeric NULL,
	gdp_per_capita numeric NULL,
	extreme_poverty numeric NULL,
	cardiovasc_death_rate numeric NULL,
	diabetes_prevalence numeric NULL,
	female_smokers numeric NULL,
	male_smokers numeric NULL,
	handwashing_facilities numeric NULL,
	hospital_beds_per_thousand numeric NULL,
	life_expectancy numeric NULL,
	human_development_index numeric NULL
);

-- Check inserted data

SELECT *
FROM Covid_Deaths
LIMIT 10;

-- query needed data

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Covid_Deaths
ORDER BY 1, 2;

-- create new column for mortality rate

SELECT location, date, total_cases, total_deaths, population,  (total_deaths/total_cases * 100) AS Mortality_Rate
FROM Covid_Deaths
ORDER BY 1, 2;

-- change zeros to nulls
UPDATE Covid_Deaths
SET total_deaths = NULL WHERE total_deaths = 0;

-- create new column for infection rate

SELECT location, date, population, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS Mortality_Rate,
(total_cases / population) * 100 AS Infection_rate
FROM Covid_Deaths
ORDER BY 1, 2;

-- check countries with highest mortality rate

SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX(total_deaths/total_cases) * 100 AS Mortality_Rate
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY Mortality_Rate DESC;

-- check countries with highest infection rate

SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX(total_cases / population) * 100 AS Infection_Rate
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY Infection_Rate DESC;

--show countries with highest death counts

SELECT location, MAX(total_deaths) AS total_death_count
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC;

-- Show death counts by continents

SELECT location, MAX(total_deaths) AS total_death_count
FROM Covid_Deaths
WHERE continent IS NULL
GROUP BY location
ORDER BY total_death_count DESC;

-- Show total cases by continents

SELECT location, MAX(total_cases) AS total_cases_count
FROM Covid_Deaths
WHERE continent IS NULL
GROUP BY location
ORDER BY total_cases_count DESC;

-- Show Mortality_Rate by continents

SELECT location, MAX(total_deaths/total_cases) * 100 AS Total_Mortality_Rate
FROM Covid_Deaths
WHERE continent IS NULL
GROUP BY location
ORDER BY Total_Mortality_Rate DESC;

-- Show Infection_Rate by continents

SELECT location, MAX(total_cases / population) * 100 AS Total_Infection_Rate
FROM Covid_Deaths
WHERE continent IS NULL
GROUP BY location
ORDER BY Total_Infection_Rate DESC;

-- Check global numbers

SELECT date, SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Deaths, SUM(new_deaths)/ SUM(new_cases) * 100 AS Death_Percent
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

SELECT SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Deaths, SUM(new_deaths)/ SUM(new_cases) * 100 AS Death_Percent
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Create table for covid vaccinations table

CREATE TABLE Covid_vaccinations (
	id serial PRIMARY KEY,
	iso_code varchar(8) NULL,
	continent varchar(15) NULL,
	location varchar(50) NULL,
	date date NULL,
	new_tests numeric NULL,
	total_tests numeric NULL,
	total_tests_per_thousand numeric NULL,
	new_tests_per_thousand numeric NULL,
	new_tests_smoothed numeric NULL,
	new_tests_smoothed_per_thousand numeric NULL,
	positive_rate numeric NULL,
	tests_per_case numeric NULL,
	tests_units varchar(50) NULL,
	total_vaccinations numeric NULL,
	people_vaccinated numeric NULL,
	people_fully_vaccinated numeric NULL,
	new_vaccinations numeric NULL,
	new_vaccinations_smoothed numeric NULL,
	total_vaccinations_per_hundred numeric NULL,
	people_vaccinated_per_hundred numeric NULL,
	people_fully_vaccinated_per_hundred numeric NULL,
	new_vaccinations_smoothed_per_million numeric NULL,
	stringency_index numeric NULL,
	population_density numeric NULL,
	median_age numeric NULL,
	aged_65_older numeric NULL,
	aged_70_older numeric NULL,
	gdp_per_capita numeric NULL,
	extreme_poverty numeric NULL,
	cardiovasc_death_rate numeric NULL,
	diabetes_prevalence numeric NULL,
	female_smokers numeric NULL,
	male_smokers numeric NULL,
	handwashing_facilities numeric NULL,
	hospital_beds_per_thousand numeric NULL,
	life_expectancy numeric NULL,
	human_development_index  numeric NULL
);
--merge 2 tables and find cumulative sum of vaccination

SELECT cdea.continent, cdea.location, cdea.date, cdea.population, cvac.new_vaccinations
, SUM(cvac.new_vaccinations) OVER (PARTITION BY cdea.location ORDER BY cdea.location, cdea.date) AS cumulative_vaccination
FROM covid_deaths AS cdea
JOIN covid_vaccinations as cvac
	ON cdea.location = cvac.location
	AND cdea.date = cvac.date
WHERE cdea.continent IS NOT NULL
ORDER BY 2,3;

-- get the percent vaccination vs population via cte table

WITH vacvspop (continent, location, date, population, new_vaccinations, cumulative_vaccination)
AS (
SELECT cdea.continent, cdea.location, cdea.date, cdea.population, cvac.new_vaccinations
, SUM(cvac.new_vaccinations) OVER (PARTITION BY cdea.location ORDER BY cdea.location, cdea.date) AS cumulative_vaccination
FROM covid_deaths AS cdea
JOIN covid_vaccinations as cvac
	ON cdea.location = cvac.location
	AND cdea.date = cvac.date
WHERE cdea.continent IS NOT NULL
ORDER BY 2,3
)
SELECT *, (cumulative_vaccination/population) * 100 
FROm vacvspop


--create view for visualization

CREATE VIEW vacvspop as
SELECT cdea.continent, cdea.location, cdea.date, cdea.population, cvac.new_vaccinations
, SUM(cvac.new_vaccinations) OVER (PARTITION BY cdea.location ORDER BY cdea.location, cdea.date) AS cumulative_vaccination
FROM covid_deaths AS cdea
JOIN covid_vaccinations as cvac
	ON cdea.location = cvac.location
	AND cdea.date = cvac.date
WHERE cdea.continent IS NOT NULL
--ORDER BY 2,3

SELECT * 
FROM public.vacvspop