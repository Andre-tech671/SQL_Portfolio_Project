
--CHECKING TABLE COVIDDEATHS
SELECT * 
FROM Portifolio_Project_SQL.dbo.CovidDeaths

--CHECKING TABLE COVIDVACCINATIONS
--SELECT * 
--FROM Portifolio_Project_SQL.dbo.CovidVaccinations

--select the data that we are going to be using
SELECT Location, last_updated_date, total_cases, new_cases, total_deaths, population
FROM Portifolio_Project_SQL.dbo.CovidDeaths
Order By 1,2

-- Looking at the Total cases vs Total Deaths
--Show likelihood of dying if you contract covid
SELECT 
    Location, 
    last_updated_date, 
    total_cases, 
    total_deaths, 
    ((total_deaths * 1.0 / NULLIF(total_cases,0)) * 100) AS DeathPercentage
FROM Portifolio_Project_SQL.dbo.CovidDeaths
--WHERE location like '%Malawi%'
ORDER BY Location, last_updated_date;

-- Looking at total cases vs Population
--shows the percentage of population that has covid 
SELECT Location, last_updated_date, total_cases, population, ((total_cases * 1.0 / NULLIF(population,0)) * 100) AS PercentageOfPopulationInfected
FROM Portifolio_Project_SQL.dbo.CovidDeaths
--WHERE location like '%Malawi%'
ORDER BY 1,2;

--Looking at countries with highest infection rate compared to population
SELECT Location, population, MAX(total_cases) AS HighestInfectionCount,MAX((total_cases   * 1.0 / NULLIF(population,0)) * 100) AS PercentageOfPopulationInfected
FROM Portifolio_Project_SQL.dbo.CovidDeaths
--WHERE location like '%Malawi%'
GROUP BY Location, Population
ORDER BY 1,2;


-- showing the countries with the highest death count per population
SELECT Location, MAX(total_deaths) as TotalDeathCount
FROM Portifolio_Project_SQL.dbo.CovidDeaths
--WHERE location like '%Malawi%'
GROUP BY Location
ORDER BY TotalDeathCount desc;