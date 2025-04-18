-- create customer table
create table customers(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(150),
    age INT
);

-- get everything from customer table
select * from customers;

-- insert data into table
insert into customers(first_name, last_name, email, age)
values('Sandip', 'Neupane', 'sandipnup1996@gmail.com', 27);

-- inserting multiple records into the table
insert into customers(first_name, last_name)
values 
('sandy', 'Neupane'),
('Sagar', 'Neupane'),
('Dipesh', 'Chaulagain'),
('Ambika', 'Neupane');

--inserting a data with quotes
insert into customers (first_name)
values ('Ashim''s neupane')

-- use RETURNING to get info on  return rows

-- first see the default behaviour when adding a record into a table

insert into customers(first_name)
values ('adams');

-- inserting a data while returning all the tables
insert into customers(first_name)
values ('Joshep') returning *;

select * from customers;

-- updating single column
update customers 
set first_name = 'Ashim'
where customer_id = 6 returning * ;


insert into customers (first_name)
values ('Gilchrist') returning customer_id, first_name;

-- updating multiple columns
update customers
set 
first_name = 'Ashim',
last_name = 'Chaulagain',
email = 'ashim@gmail.com',
age = '10'
where customer_id in (6, 7) returning *

-- update with no where clause
select * from customers;

update customers
set is_enabled = 'y' returning *;


-- deleting records from customers

delete from customers
where customer_id = 6;

-- deleting all the records from customers
delete from customers;

-- using upsert statement(The combination of update and insert)


create table t_tags(
    id serial primary key,
    tag text UNIQUE,
    update_date TIMESTAMP default now()
);

select * from t_tags;

-- insert into t_tage
insert into t_tags(tag)
values
('pen'),
('pencil');


-- lets insert a record on conflict and do nothing
insert into t_tags(tag)
values ('pen')
on conflict (tag)
do nothing;

--lets ubsert a record on conflict set new values
insert into t_tags(tag)
values ('pen')
on conflict(tag)
do
update set
 tag = EXCLUDED.tag || 1,
 update_date = now();
