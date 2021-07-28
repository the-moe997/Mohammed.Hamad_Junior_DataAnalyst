-- These tables will be used to create visualizions using Tableau
-- from the Covid 19 Dataset https://ourworldindata.org/covid-deaths until 2021-07-17











-----------------------------------------------------
-- The total cases and total deaths of Covid 19 worldwide until 2021-07-17





select 
	sum(new_cases) as 'Total Cases', 
	sum(convert(int,new_deaths)) as 'Total Deaths',
	sum(convert(int,new_deaths))/sum(new_cases) *100 as 'Death Percentage'

from [portfolio porject]..[NewCovidDeaths$]
where continent is not null


----------------------------------------------------------------------------------
-- Total cases and total deaths of Covid 19 of each continent until 2021-07-17






select 
	location,
	sum(convert(int,new_deaths)) as 'Total Death Count'
	
from [portfolio porject]..[NewCovidDeaths$]
where continent is null and location not in ('European Union','International','world')
group by location--,population
order by 2 DESC




---------------------------------------------------
-- Daily Covid-19 situation in each country



select
		location,
		population,
		date,
		max(total_cases) as 'Total cases count',
		max(total_cases/population)*100 as 'percent people infected'
		
from [portfolio porject]..[NewCovidDeaths$]
group by location , population , date
order by 1, 3







--------------------------------------------------------
--Total people infected in each country


select
		location,
		population,
		date,
		max(total_cases) as 'Highest Infection count',
		max(total_cases/population)*100 as 'percent people infected'
		
from [portfolio porject]..[NewCovidDeaths$]
where location not in ('world','North america','European Union','Europe','Asia','africa','south america')
group by location , population , date
order by 5 desc



---------------------------------------
--Total people vaccinated in each country




Select 		
	dea.continent, dea.location, dea.date, dea.population,
	MAX(vac.total_vaccinations) as 'People Vaccinated',
	(MAX(vac.total_vaccinations)/dea.population)*100 as 'percent People Vaccinated' 
from [portfolio porject]..[NewCovidDeaths$] dea
Join [portfolio porject]..[NewCovidVaccinations] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
group by dea.continent, dea.location, dea.date, dea.population
order by 1,2,3



