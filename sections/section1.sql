
-- CREATING actors table

CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(150),
    last_name VARCHAR(150) NOT NULL,
    gender CHAR(1),
    dare_of_birth DATE,
    add_date DATE,
    update_date DATE
);


-- CREATING the directors table

CREATE TABLE directors(
    director_id SERIAL PRIMARY KEY,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    date_of_birth DATE,
    nationality VARCHAR(20),
    add_date DATE,
    update_date DATE
)

select * from directors;


-- CREATING MOVIES TABLE WITH FOREIGH KEY
-- MOVIES -> Going to have directors
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    movie_length INT,
    movie_language VARCHAR(20),
    age_certification VARCHAR(10),
    release_date DATE,
    director_id INT REFERENCES directors (director_id)
);


--CREATING MOVIES REVENUE TABLE

CREATE TABLE movies_revenues(
    revenue_id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies (movie_id),
    revenues_domestic NUMERIC (10,2),
    revenues_international NUMERIC (10,2)
);


SELECT * FROM movies_revenue;


-- CREATING a movies_actors junction table

CREATE TABLE movies_actors(
    movie_id INT REFERENCES movies (movie_id),
    actor_id INT REFERENCES actors (actor_id),
    PRIMARY KEY (movie_id,actor_id)
);


-- Imstall Sample Data for 'movies' table

-- Use scripts in sequence directors.sql,  actors.sql, movies.sql, movies_actors.sql, movies_revenues.sql
-- We will use this scripts to insert data to our table

-- run the script and check data

select * from directors;
select * from actors;
select * from movies;
SELECT * FROM movies_actors;
SELECT * FROM movies_revenues;


-- crate and drop table examples

CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);

-- verify table has been created
SELECT * FROM roles;


-- drop tabel sql file
DROP TABLE roles;



