--Covid 19 Data Exploration 
--Skills used: Joins,  Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
---------------------------------------------------
-- Select Data that we are going to be starting with

SELECT distinct
      [location]
      ,[date]
      ,[population]
      ,[total_cases]
      ,[new_cases]
      ,[total_deaths]
      ,[new_deaths]
      
 fROM [portfolio II].[dbo].[covid_deaths]
 where location like 'canada' 
 order by 6 desc

-------------------------------------------------------------
-- overview to Covid-19 sitaution in jordan

 SELECT distinct
      [location]
      ,[date]
      ,[population]
      ,[total_cases]
      ,[new_cases]
      ,[total_deaths]
      ,[new_deaths]
      
 fROM [portfolio II].[dbo].[covid_deaths]
 where location like 'jordan' 
 order by 2 desc


select * 
 from [portfolio II] .. covid_deaths
 order by  4 ,5

select * 
 from [portfolio II] .. covid_vaccinations
 where location like 'jordan' 
 order by 4  desc
-----------------------------------------------


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid


select 
     location,  
     date ,
     population,
     total_cases,total_deaths,
     (total_deaths/total_cases)*100 as 'death persantge'

 from [portfolio II]..covid_deaths
 where location like 'united states'
 order by 1, 2

 


select  
     location,  
     date ,
     population,
     total_cases,total_deaths,
     (total_cases/population)*100 as 'death persantge'

from [portfolio II]..covid_deaths
 where location like 'united states'
 order by 1, 2

-------------------------------------------------------
-- Total Cases vs Population
-- Shows what percentage of population infected with Covid



select 
    location, 
    population,
    max(total_cases) as highestInnfictioncount ,
    max(total_cases/population)*100 as 'death persantge'

from [portfolio II]..covid_deaths
group by location , population
order by 4 desc



select 
    location, 
    population,
    max(total_deaths) as highestDeathcount 
--  max(total_cases/population)*100 as 'death persantge'

from [portfolio II]..covid_deaths
	 group by location , population
	 order by 3 desc

---------------------------------------------------------

-- death summary for each continent


select
    continent, 
    max(total_deaths) as highestDeathcount 
from [portfolio II]..covid_deaths
where continent is not null
group by continent
order by 2 desc

select
    location, 
    max(total_deaths) as highestDeathcount 

from [portfolio II]..covid_deaths
where continent is null
group by location
order by 2 desc


----------------------------------------------------
-- The Highest number of cases ber day



select 
    date ,
    sum(new_cases) as GloupalInnficationsD

from [portfolio II]..covid_deaths
group by date 
order by 2 desc,1 



select 
    date ,
    sum(new_cases) as GloupalInnficationsDaily,
		sum(new_deaths), (sum(new_deaths)/sum(new_cases))*100
 
from [portfolio II]..covid_deaths
where continent is not null 
group by  date
order by 1 ,2
------------------------------------------------------
-- getting the total number of cases all around the world


select 
    sum(new_cases) as GloupalInnficationsDaily,
    sum(new_deaths) as totalDeaths, (sum(new_deaths)/sum(new_cases))*100 as deathPercintage

from [portfolio II]..covid_deaths
where continent is not null 
--group by  date
 order by 1 ,2


-----------------------------------------------------
--checking for inconvenient Data
 
Select *
from [portfolio II]..covid_deaths
where new_cases < 0 

-- unfortunately there are more 60 rows having negative new cases which is unrealistic
