-- section 2 querying a database



-- get all records from movies table
  select * from movies;
  
-- get all the records from actor table
select * from actors
 --Notes
   -- SQL keywords are case insensitive
   -- Table name are case insensitive(by convention use uppercase)
   -- postgres sql evaluates FROM clause before SELECT clause
   -- Using * in select statement for table having lots of columns might effect database performances
   -- Application performance- Reteriving unnecessary data from the databse increases the traffic between databse server and application server will slow down application performance
   -- use explict column name in the SELECT statement
   
-- Using explict column name in SELECT statement
select first_name from actors;
select first_name, last_name from actors;

-- get movie name and movie_lang form movie table
select movie_name, movie_lang from movies;

-- using column names is always a good practice and produces less load on the server

-- Adding ALIAS
select * from actors;

-- adding alias on column name
select first_name as FirstName from actors;

select first_name as "FirstName" from actors;

-- make an alis for first_name  as First Name of actors table
select first_name as "First Name" from actors;

-- make alias for movie_name as Movie Nmae and movie_lang as Language of movies table
select movie_name as "Movie Name", movie_lang as "Language" from movies;

-- the as keyword is optional
select 
    movie_name "Movie Name",
    movie_lang "Language"
from movies;

-- can i use single quotes while making an alias?.
-- Make an alias for first_name as 'FIRST_NAME' of actors table.
select first_name as 'FIRST NAME' from actors;
-- we cannot use the single quotes, when using the single quotes postgress normally see it as column name

-- select first_name and last_name from actors table
select first_name, last_name from actors;

-- combine first_name and last_name column tagether to make full_name
-- using expression
-- we will use || concatinating operator
select 
    first_name || ' ' || last_name as "Full Name"
from actors;

-- can I just use expression to get output without using table column
select 2 * 10;

-- Using ORDER BY to sort records
-- when you query data from a table the select statement return rows in an unspecified order.
-- To sort the rows of the result set we can use ORDER BY clause in the select statement.
/*
SELECT
    column_list
FROM tablename;
ORDER bY
    sort_expression1 [ASC | DESC]
    ...
    sort_expression1 [ASC | DESC]
*/

-- sort expression can be a single column or an expression
-- ASC - ascending order DESC- descending order

-- 1. sort based on single column
-- sort all movies records by their release_date in ascending order
select * from movies;

select
    * 
from movies
order by 
    release_date;
    
-- ORDER BY default is ascending order

-- sort all movies record by their release_date in descending order
select
    *
from movies
order by
    release_date desc;
    
-- sort based on multiple columns
-- sort all movie records by their release date in descending order and movie name in ascending order

select
    *
from movies
order by
    movie_name asc,
    release_date desc;


-- order of execution FROM, SELECT and ORDER_BY



-- using ORDER BY with alias column name

--1.get firstname and last_name from actors table
select
    first_name,
    last_name
from actors;

select
    first_name,
    last_name as surname
from actors;

-- sort rows by last_name
select
    first_name,
    last_name as surname
from actors
order by last_name;
-- default sorting is ascending

-- to sort in descending order
select
    first_name,
    last_name as surname
from actors
order by last_name desc;

-- using alias to order_by
select
    first_name,
    last_name as surname
from actors
order by surname desc;


-- Use ORDERY_BY to sort rows by an expression

--1. List all the records of actor table
select * from actors;

--2. Calculate the length of the actor name with LENGTH function
select
    first_name,
    LENGTH(first_name) as len
from actors;

--3. lets sort rows by length of the actor name in descending order
select
    first_name,
    LENGTH(first_name) as len
from actors
order by
    len desc;
    

-- How to use column name or column number in ORDER BY clause
--1. view all records of actor
select * from actor;
--2. sort all records by first_name asc, date_of_birth desc
select
    *
from actors
order by
    first_name asc,
    date_of_birth desc;
    
-- use column number instead of name for sorting
select
    first_name, -- referenced at first column
    last_name,  -- referenced at second column
    date_of_birth  -- referenced at second column
from actors
order by 
   1 asc, -- 1 refers to first_name
   3 desc; -- 3 refers to date_of_birth


-- Using ORDER BY with null values

-- NULL is the marker that indicates
    --1.Either data is missing or
    --2.the data is unkown
-- When you sort rows that contains NULL, you can specify the order of NULL with other non-null values
-- by using NULL FIRST or NULLS LAST option of the ORDER BY clasuse

/* 
select 
    *
from table_name
order by
    sort_parameter [ASC | DESC] [NULLS FIRST | NULLS LAST]
*/

-- to demonstrate lets create a table called demo_sorting
create table demo_sorting(
    num INT
);

-- insert some date with NULL values in demo_sorting table
INSERT INTO demo_sorting(num)
values
    (10),
    (8),
    (NULL),
    (3),
    (11)

select * from demo_sorting
order by num asc;

-- by default null are sorted at bottom.

select * from demo_sorting order by num asc;
-- ORDER BY ASC uses  NULLS LAST by default

select * from demo_sorting order by num desc;
-- ORDER BY DESC user NULLS FIRST by default

-- delete demo_sorting table
drop table demo_sorting;

-- selecting disctinct values

-- select distinct columnname from table_name

--1.lets get all record of movies table
select * from movies;

--2. get movie_lang from movies table
select 
    movie_lang
from movies

--3. select unique movie lang
select 
    distinct movie_lang
from movies
order by 1 desc;

--4. Get unique director ids
select distinct director_id from movies order by 1;


--5. get multiple distinct values e.g get unique movie_lang, director_id
select
    distinct director_id,
    movie_lang
from movies
order by 2;

--6.get all unique records in movies table
select 
    distinct * 
from movies order by movie_name asc;

--Using fetch

--* FETCH CLAUSE TO RETERIVE A PORTION OF ROWS RETURNED BY A QUERY
--* FETCH clause is functionality equivalent to limit clause.
--* you should use the FETCH clasue because it follows the standard SQL

/* 
OFFSET start {ROW | ROWS}
FETCH {FIRST | NEXT} [row_count] {ROW | ROWS} only


*/

--* The OFFSET start is an integer that must be zero or positive. By default start is 0
--* In case the start is greater than the number of rows the result set, no rows are returned

--1. Get first row of movies table
SELECT * FROM movies
FETCH first 5 row only

--2 get the top 5 biggest movies by director_id
select * from movies
order by director_id desc
fetch first 5 row only;

--3 get the top 5 oldest american directors
select * from directors
order by date_of_birth asc
fetch first 5 row only;

--4 get the top 10 youngest female actors
select
    * 
from actors
where 
    gender = 'F'
order by date_of_birth desc
fetch first 10 row only;

--5 get the first 5 movies from the 5th record onwards by director_id
select
    *
from movies
order by  director_id desc
offset 6
fetch first 5 rows only

--IN and NOT IN operatores
-- IN and NOT IN operators are used to check if a value matches or not matches in a list
-- return true or false
-- value IN (value1, value2,....)
-- value NOT IN (value1, value2,...)

-- The IN operator return true if the value matches any value in the list i.e value1, value2 ,..
-- The NOT IN operator return true if the value does not matches

--1.Get all movies for english chinese and japaneses lanaguage
-- alternative way using WITH and OR operator
select
    *
from movies
where 
    movie_lang = 'English'
    or movie_lang = 'Chinese'
    or  movie_lang = 'Japanese';
    
select
    *
from movies
where
    movie_lang in ('English', 'Chinese', 'Japanese');


--2 get all movies where age certification is 13 and PG type
select
    *
from movies
where
    age_certificate in ('12', 'PG')
order by age_certificate;

--3. Get all movies where director id is not 13 or 10
select
    *
from movies
where
    director_id not in ('13','10')
order by director_id

--4. Get all actors where actor_id is not 1, 2, 3, 4
select
    *
from actors
where
    actor_id not in (1,2,3,4)
order by
    actor_id;
    
-- USING BETWEEN and NOT BETWEEN
-- An operator to match a value against a range of values
-- value between low and high
-- if the value is greater than or equal to the low value and less than or equal to the high value
-- the expression return true otherwise it returns false

--1.Get all the actors where birth_date between 1991 and 1995
select * from actors
where
    date_of_birth between '1991-01-01' and '1995-12-31' 
order by date_of_birth

--2.Get all the movies released between 1998 and 200
select * from movies
where
    release_date between '1998-01-01' and '2000-12-31'
order by release_date

--3. get all movies where domestic revenues are between 100 and 300
select * from movies_revenues
where
    revenues_domestic between 100 and 300
order by revenues_domestic

--290.30 and 102.10

--get all movies where domestic revenues are not between 100 and 300
select * from movies_revenues
where
    revenues_domestic not between 100 and 300
order by revenues_domestic

select * from movies_revenues
where
 revenues_domestic >= 100 and revenues_domestic <= 300
 order by revenues_domestic
 
 
 --LIKE and ILIKE operators
 
 --Operators to query data using 'patternmatching'
 --Returns true or false
 --Both let you search for patter in strings by using two special characters
 
 -- %   Percent sign (%) matches any sequese of zero or more characters:
 -- _ Underscore sign(_) matches any single character
 
 
 -- syntax: LIKE pattern
 -- syntax: value ILIKE pattern
 
 --1.Full character search
 
 select 'hello' like 'hello';
 
 --2 partial character search using '%'
 select 'hello' like 'h%';
 
 select 'hello' like '%e%';
 
 select 'hello' like '%e';
 
 select 'hello' like 'hell%';
 
 --3. single character search using _
 
 select 'hello' like '_ello';
 select 'hello' like 'h_llo';
 select 'hello' like '__ll_';
 
 --4 Using % and _ together
 select 'hello' like '%ll_';
 
 --6. Get all actors names where first name starting with 'A'
 select * from actors
 where first_name like 'A%'
 order by first_name;
 

--7 Get all the actors where last name ending with 'a'
select
    *
from actors
where
    last_name like '%a'
order by last_name;

--8 Get all the actors name where first name with 5 characters only
select 
    *
from actors
where
    first_name like '_____'
order by first_name;

--9 get all actors name where first name contains l on the second place
select 
    *
from actors
where
    first_name like '_l%'
order by first_name;

--8 Is LIKE is case-sensitive?
--get record from actors where actor name is 'Tim'
select
    *
from actors
where
    first_name like 'Tim%'
order by first_name;

--get record from actors where actor name is 'tim'
select
    *
from actors
where
    first_name like 'tim%'
order by first_name;
   