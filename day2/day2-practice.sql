/* Return to https://chinook.ml. Feel free to drop the existing tables, as you will use them in the afternoon project. */

--UPDATE
    -- Create a table or use one of the sql files to create a table.
    CREATE TABLE IF NOT EXISTS country (
        code character(3) not null primary key,
        name text NOT NULL,
        continent text NOT NULL,
        region text NOT NULL,
        surfacearea real,
        indepyear smallint,
        population integer,
        lifeexpectancy real,
        gnp numeric(10,2),
        gnpold numeric(10,2),
        capital integer,
        code2 character(2)
    );
    -- Update one value in one row.
    update Album
    set Title = "Balls in a Glass"
    where AlbumId=2
    -- Update multiple values in one row.
    update customer
    set Firstname = "Bozo",lastname="clown"
    where customerId=2
    -- Update multiple values in multiple rows.
    update customer
    set Firstname = "Bozo",lastname="clown"
    where customerId<3
    -- Update values in rows using a subquery
        -- For example, set all country populations to 1000000 where the populations are larger than the population of South Africa
    update country
    set populaton=1000000
    where population >()
      select sum(population)
      from country
      where region like "southern africa"
      )
    order by population desc
--DELETE
    -- Delete a row from a table.
    DELETE FROM country WHERE code="CHN";
    -- Delete all rows from the table.
    DELTE FROM country where code is not null
    -- Undo the operation. (Just kidding--you can't undo a delete!)

--JOINS
    -- Now we're going to need related tables. Copy the statements from world.sql into chinook in order to get started.

    -- You should see three tables. These tables share one value, the country code. We can use this code to join the tables and provide combined data.

    -- Begin by joining the country table to the countrylanguage table.
    select *
    from country
    join countrylanguage on code=countrycode
    -- Now join the city table to the country table.
    select *
from country
join city on code=countrycode
    -- Finally, join all three (I'd just include one column from each) so you can see every language for every city in every country. (Note: this isn't exactly accurate. The country's langauges may not be spoken in every city.)
    select country.name, city.name, countrylanguage.language
from country
join city on code=city.countrycode
join countrylanguage on code=countrylanguage.countrycode
--CALCULATIONS, AGGREGATIONS, and JOINS
    -- Okay, now that you have the mechanics down, let's see what we can find.

    -- Find the most populous capital cities.
    select country.name,city.name,city.population
    from country
    join city on capital=city.id
    order by city.population desc
    -- Find the languages which have the most number of speakers in any one nation.
    select country.name,countrylanguage.language, (percentage/100)*country.population AS speakers
    from country
    join countrylanguage on code=countrycode
    order by speakers desc
    -- Find the languages with the most number of speakers globally.
    select countrylanguage.language, sum((percentage/100)*country.population) AS speakers
    from country
    join countrylanguage on code=countrycode
    group by countrylanguage.language
    order by speakers desc
    -- List the countries with total_urban_population alongside their total population. For an extra challenge, try ranking the countries by the percentage of their population that is urban or rural.
    select country.name, sum(city.population) as Urban_Pop, country.population-sum(city.population) as Rural_Pop,country.population
    from country
    join city on code=countrycode
    group by country.name

    select country.name, (country.population-sum(city.population))/country.population*100 as Rur_per,sum(city.population) as Urban_Pop, country.population-sum(city.population) as Rural_Pop,country.population
    from country
    join city on code=countrycode
    group by country.name
