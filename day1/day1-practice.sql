/* To answer the following questions, please run your queries in https://chinook.ml. You might also copy them here for your reference. */

--If you wish, drop the tables in the Chinook Database:
drop table if exists PlaylistTrack;
drop table if exists Playlist;
drop table if exists InvoiceLine;
drop table if exists Invoice;
drop table if exists Track;
drop table if exists Genre;
drop table if exists MediaType;
drop table if exists Album;
drop table if exists Artist;
drop table if exists Customer;
drop table if exists Employee;

-- Note: if you refresh, these tables will reappear and your tables will disappear.

--TABLE CREATION
-- Create a table with an id, a text column, and a numeric column.

CREATE table baseball(
  id integer primary key autoincrement,
  description text,
  play_num integer)

--ROW CREATION
-- Insert two rows of data into your table.

INSERT INTO baseball(description,play_num) VALUES ("big yum",5)
INSERT INTO baseball(description,play_num) VALUES ("little bo",5)

--SELECT BASICS
-- Retrieve your two rows of data.
Select *
From baseball

-- Filter the data to one row with a where clause.

Select *
From baseball
WHERE description Like ("%yum")

-- Take off the where clause and select all of the data again.
-- Then order the data by one of the fields.

Select *
From baseball
Order by id desc


-- Flip the order.

Select *
From baseball
Order by id asc


-- Limit the data to one row.
Select *
From baseball
Order by id desc
LIMIT 1

--SELECT BASICS WITH REAL DATA
-- Now drop your table with the following command:
DROP TABLE table_name;

-- Import the city table by copying the statements from city.sql.

CREATE TABLE IF NOT EXISTS city (
    id integer primary key autoincrement,
    name text NOT NULL,
    countrycode character(3) not null,
    district text NOT NULL,
    population integer NOT NULL
);


-- Select all of the cities with populations less than 1,000,000.

select * from city
where population<1000000
Order by population desc

-- Further filter the results with extra conditions.
select * from city
where population<1000000 AND countrycode LIKE ("RUS")
Order by population desc
-- Select all of the cities from the United States.
select * from city
where countrycode LIKE ("USA")
Order by population desc
-- Select all of the cities from North America.
select *
from city
Where countrycode IN ("MEX","USA","CAN")
Order by population desc
-- Select all of the cities that end with 'town' or 'ton'.
select *
from city
Where name like "%town" OR name like "%ton"
Order by population desc
-- Select the cities whose country codes contain a 'Z'.

select *
from city
Where countrycode like "%z%"

-- NEED MORE PRACTICE?
-- Try importing the country database and selecting different rows and columns.

-- CALCULATIONS AND AGGREGATIONS

-- Copy the statements from country.sql and run them in chinook.

-- Calculate the population density of each country.
select *, population/surfacearea AS Density
from country
Order by Density desc
-- Which nation gained its independence first?
select *
from country
Where indepyear IS NOT NULL
Order by indepyear
LIMIT 1
-- Count the number of nations with 'stan' in their name (or 'Guinea' or 'land').
select count(*)
from country
Where name
	like "%stan%" OR
    name LIKE "%guinea%" or
    name like "%land%"
-- Count the number of countries in Africa.
select count(*)
from country
Where continent="Africa"
-- Count the number of nations which gained their independence after 1960.
select count(*)
from country
Where indepyear>1960
-- Find the average life expectancy for European and Asian nations.
select continent,avg(lifeexpectancy)AS avg_life
from country
Where continent in ("Europe","Asia")
Group By continent

--MORE PRACTICE
-- Copy the countrylanguage table into chinook.

-- How many distinct languages does this table contain?
select count(distinct language)
From countrylanguage
-- Which nation has the most recorded languages?
select countrycode,count(language)
From countrylanguage
Group by countrycode
order by count(language) desc

-- Which languages are spoken in the most nations?
select language,count(countrycode)
From countrylanguage
Group by language
order by count(language) desc

-- Which language is most creolized?
select *, count(*)
From countrylanguage
where language like "%creole%"
group by language

--ONE FOR THE MONEY
-- Drop the tables above if you wish:
drop table if exists country;
drop table if exists city;
drop table if exists countrylanguage;

-- Copy the computer_jobs table into chinook, and do a little job research.

-- Which state, on average, pays computer workers the most?
select state, avg(median_salary)
from computerjobs
group by state
order by avg(median_salary) desc

-- Which field of computer science pays the most on average?
select title, avg(median_salary)
from computerjobs
group by title
order by avg(median_salary) desc

-- Which field has the most number of jobs?
select title,sum(jobs_per_1000)
from computerjobs
group by title
order by sum(jobs_per_1000) desc
-- How much do web developers make in your state?
select title,median_salary
from computerjobs
where state = "TX" and title like "web developers"
-- Which state employs the most web developers?
select state,title,number_employed
from computerjobs
where title like "web developers"
order by number_employed desc

--STILL WANT MORE?
-- Find some data you want to play around with. These queries can be painfully rote if you're using fake data--you can look up only so many fake product orders before your mind begins to wander. See if you can find data for something you're interested in. If you can get the data into a spreadsheet, I'll help you convert it and insert it into chinook. I also have job data for all occupations in Dallas if you're interested.
