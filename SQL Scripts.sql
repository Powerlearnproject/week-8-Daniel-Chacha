CREATE DATABASE Energy;

USE Energy;

CREATE TABLE household_energyConsumption(
    HOUSEHOLD_ID INT AUTO_INCREMENT PRIMARY KEY,
    HOUSEHOLD_NAME VARCHAR(20) NOT NULL,
    NO_OF_OCCUPANTS INT NOT NULL,
    INCOME_LEVEL DECIMAL NOT NULL,
    APPLIANCE_COUNT INT NOT NULL,
    NO_OF_MALES INT NOT NULL,
    NO_OF_FEMALES INT NOT NULL,
    CITY VARCHAR(20) NOT NULL,
	ENERGY_CONSUMED_KWH DECIMAL NOT NULL,
    COST DECIMAL NOT NULL,
    DATE DATE NOT NULL
);

-- I used an expressjs server to populate the database with the relevant data.
-- The code for this is in the server.js file inside the api folder.

SELECT
    *
FROM
    Energy.household_energyConsumption;

-- 1. DATA RETRIEVAL QUERRIES
-- Retrieve Households from a specific city
SELECT
    *
FROM
    household_energyConsumption
WHERE
    CITY='Mombasa';

-- Retrive households with monthly incomes of less than 5000
-- This query retrieves households with monthly income below a certain threshold (e.g., 5000), which could be relevant for analyzing energy affordability.
SELECT
    *
FROM
    household_energyConsumption
WHERE
    MONTHLY_INCOME<'5000';

-- Retrieve households with high appliance usage
-- This query retrieves households that have more than 8 appliances, potentially indicating higher energy consumption.
SELECT
    *
FROM
    household_energyConsumption
WHERE
    APPLIANCE_COUNT>8;

-- Retrive households with more than 5 occupants
-- This query retrieves households with more than 5 occupants, which could correlate with higher energy needs.
SELECT
    *
FROM
   household_energyConsumption
WHERE
    NO_OF_OCCUPANTS >=5;

-- Retrieve households with more females than males

SELECT
    *
FROM
    household_energyConsumption
WHERE
    NO_OF_FEMALES > NO_OF_MALES;

-- 2. DATA ANALYSIS QUERRIES
-- Average Income level by city
-- This query calculates the average monthly income of households in each city, which could be used to compare monthly income  across different regions.
SELECT
    CITY,
    AVG(MONTHLY_INCOME) AS AVG_INCOME
FROM
    household_energyConsumption
GROUP BY
    CITY
ORDER BY
    AVG_INCOME DESC;

-- Total Appliance count  by City
-- This query calculates the total number of appliances in each city, providing insight into the potential energy demand in different areas.
SELECT
    CITY,
    SUM(APPLIANCE_COUNT) AS TOT_APPLIANCES
FROM
    household_energyConsumption
GROUP BY
    CITY
ORDER BY
    TOT_APPLIANCES DESC;

-- Monthly Income Distribtion
-- This query generates a distribution of monthly income  across all households, helping to identify the range and concentration of monthly income.
SELECT
    MONTHLY_INCOME,
    COUNT(*)AS       HOUSEHOLD_COUNT
FROM
    household_energyConsumption
GROUP BY
    MONTHLY_INCOME
ORDER BY
    MONTHLY_INCOME;

-- Correlation between Monthly Income and Appliance count
-- This query analyzes the correlation between monthly income  and appliance ownership, which could be indicative of energy consumption patterns.
SELECT
    MONTHLY_INCOME,
    ROUND(AVG(APPLIANCE_COUNT)) AS AVG_APPLIANCE_COUNT
FROM
    household_energyConsumption
GROUP BY
    MONTHLY_INCOME
ORDER BY
    MONTHLY_INCOME;

-- Gender distribution in households by City
-- This query provides an overview of gender distribution in households across different cities, which could be relevant for gender-specific energy programs.
SELECT
    CITY,
    SUM(NO_OF_MALES)   AS TOTAL_MALES,
    SUM(NO_OF_FEMALES) AS TOTAL_FEMALES
FROM
    household_energyConsumption
GROUP BY
    CITY;