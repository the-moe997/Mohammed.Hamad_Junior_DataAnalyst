-- These tables are used to create visualizions using Tableau
-- Covid 19 Dataset https://ourworldindata.org/covid-deaths until 2021-07-17









----------------------------------------------------------------------------------
-- Total cases and total deaths of Covid 19 of each continent until 2021-07-17





select 
location,convert(int,total_deaths)as 'Total deaths count '--population,total_cases
from [portfolio porject]..[NewCovidDeaths$]
where continent is null and date = '2021-07-17'
	  and location not in ('world','European Union', 'international')
order by 2 Desc

-----------------------------------------------------
-- The total cases and total deaths of Covid 19 worldwide until 2021-07-17

select sum(new_cases) as 'The total cases',sum(convert(int,new_deaths)) as 'the total deaths'
	  ,(sum(convert(int,new_deaths))/sum(new_cases))*100 as 'Death Percentage'
From [portfolio porject]..[NewCovidDeaths$]
where continent is null 
And	  location = 'world'


------or----------


select sum(new_cases) as 'The total cases',sum(convert(int,new_deaths)) as 'the total deaths'
	  ,(sum(convert(int,new_deaths))/sum(new_cases))*100 as 'Death Percentage'
From [portfolio porject]..[NewCovidDeaths$]
where continent is not null 


---------------------------------------------------
-- Daily Covid-19 situation in each country

select cv.continent,cv.location,cv.date,cv.population                
		,CV.new_cases,cv.new_cases/cv.population*100 as 'total people infected'
from [portfolio porject]..[NewCovidDeaths$] CV
join [portfolio porject]..[NewCovidVaccinations] VCC
	on CV.location = VCC.location
	AND CV.Date = VCC.Date
 
--group by 1,2
--------------------------------------------------------
--Total people infected + total people vaccinated in each country



select cv.location,cv.population               
      ,CV.total_cases,cv.total_cases/cv.population as 'total people infected'
from [portfolio porject]..[NewCovidDeaths$] CV
join [portfolio porject]..[NewCovidVaccinations] VCC
	on CV.location = VCC.location
	AND CV.Date = VCC.Date
 where cv.date= '2021-07-17'
	   and cv.continent is not null
	   and vcc.total_vaccinations is not null
order by 3 desc
--group by 1,2
---------------------------------------

