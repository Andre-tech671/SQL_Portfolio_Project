# 🦠 COVID-19 Data Exploration | SQL Portfolio Project

Exploratory data analysis of global COVID-19 deaths and vaccinations using **SQL Server (T-SQL)**. This project uncovers trends in infection rates, death counts, and population impact across countries and continents.

---

## 📌 Project Overview

This project explores global COVID-19 data to uncover trends in infection rates, death counts, and population impact across countries and continents. The goal is to practice core SQL skills such as **joins, aggregations, CTEs, temp tables, window functions, and views**.

**Tools Used**
- 🗄️ SQL Server (T-SQL)
- 🖥️ SQL Server Management Studio (SSMS)

**Dataset**
- `CovidDeaths` – total cases, new cases, total deaths, population, continent
- `CovidVaccinations` – vaccination rollout data per country/date

---

## 🧭 Table of Contents

1. [Initial Data Check](#1-initial-data-check)
2. [Selecting Core Columns](#2-selecting-core-columns)
3. [Total Cases vs Total Deaths](#3-total-cases-vs-total-deaths)
4. [Total Cases vs Population](#4-total-cases-vs-population)
5. [Highest Infection Rate by Country](#5-highest-infection-rate-by-country)
6. [Highest Death Count by Country](#6-highest-death-count-by-country)
7. [Breakdown by Continent](#7-breakdown-by-continent)
8. [Key Insights](#-key-insights)
9. [Future Improvements](#-future-improvements)

---

## 1. Initial Data Check

Preview both tables to verify structure and content.

```sql
-- Check CovidDeaths table
SELECT *
FROM Portifolio_Project_SQL.dbo.CovidDeaths;

-- Check CovidVaccinations table
SELECT *
FROM Portifolio_Project_SQL.dbo.CovidVaccinations;
```

---

## 2. Selecting Core Columns

Pull only the columns relevant to the analysis.

```sql
SELECT
    Location,
    last_updated_date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM Portifolio_Project_SQL.dbo.CovidDeaths
ORDER BY 1, 2;
```

---

## 3. Total Cases vs Total Deaths

**Goal:** Show the likelihood of dying if you contract COVID-19 in a given country.

```sql
SELECT
    Location,
    last_updated_date,
    total_cases,
    total_deaths,
    ((total_deaths * 1.0 / NULLIF(total_cases, 0)) * 100) AS DeathPercentage
FROM Portifolio_Project_SQL.dbo.CovidDeaths
-- WHERE Location LIKE '%Malawi%'
ORDER BY Location, last_updated_date;
```

> 💡 `NULLIF` is used to prevent division-by-zero errors.

---

## 4. Total Cases vs Population

**Goal:** Show the percentage of the population infected in each country.

```sql
SELECT
    Location,
    last_updated_date,
    total_cases,
    population,
    ((total_cases * 1.0 / NULLIF(population, 0)) * 100) AS PercentageOfPopulationInfected
FROM Portifolio_Project_SQL.dbo.CovidDeaths
-- WHERE Location LIKE '%Malawi%'
ORDER BY 1, 2;
```

---

## 5. Highest Infection Rate by Country

**Goal:** Identify countries with the highest infection rate relative to their population.

```sql
SELECT
    Location,
    Population,
    MAX(total_cases) AS HighestInfectionCount,
    MAX((total_cases * 1.0 / NULLIF(population, 0)) * 100) AS PercentageOfPopulationInfected
FROM Portifolio_Project_SQL.dbo.CovidDeaths
-- WHERE Location LIKE '%Malawi%'
GROUP BY Location, Population
ORDER BY 1, 2;
```

---

## 6. Highest Death Count by Country

**Goal:** Rank countries by their maximum reported death count.

```sql
SELECT
    Location,
    MAX(total_deaths) AS TotalDeathCount
FROM Portifolio_Project_SQL.dbo.CovidDeaths
-- WHERE Location LIKE '%Malawi%'
GROUP BY Location
ORDER BY TotalDeathCount DESC;
```

---

## 7. Breakdown by Continent

**Goal:** Compare total deaths per continent.

```sql
SELECT
    continent,
    MAX(total_deaths) AS TotalDeathCount
FROM Portifolio_Project_SQL.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;
```

> 💡 Filtering `continent IS NOT NULL` avoids aggregating world/region-level summary rows.

---

## 🔍 Key Insights

> ✍️ *To be updated as the analysis progresses.*

- **Global death rate:** Infection fatality ratio peaked around **X%**.
- **Highest infection rate:** `[Country]` at **X%** of its population.
- **Highest death count:** `[Country]` with **X** reported deaths.
- **Continental trend:** `[Continent]` recorded the highest total deaths.
- **Malawi snapshot:** Death rate of **X%**, infection rate of **X%**.

---

## 🚀 Future Improvements

- [ ] Join `CovidDeaths` with `CovidVaccinations` to analyse vaccination impact
- [ ] Use **CTEs** and **Temp Tables** for rolling vaccination counts
- [ ] Create **Views** for reusable analysis
- [ ] Build a **Power BI / Tableau** dashboard on top of the cleaned dataset
- [ ] Add **window functions** for 7-day rolling averages

---

## 🛠️ How to Run

1. Import `CovidDeaths` and `CovidVaccinations` datasets into SQL Server.
2. Run each SQL block in this README section by section in SSMS to reproduce results.

---

## 📜 License

This is a personal portfolio project for learning purposes.

**Data Source:** [Our World in Data – COVID-19 Dataset](https://ourworldindata.org/covid-deaths)

---

**Author:** *Andre Philip Nyanjahia*
**Last Updated:** *07/17/2026*
