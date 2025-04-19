# 📘 PostgreSQL Learning Project

Welcome to the **PostgreSQL Learning Project**! This repository is designed to help you learn PostgreSQL by working with realistic datasets like **Movies**, **HR**, **Northwind**, and **Stocks**. You'll also get hands-on experience creating and dropping databases, roles, and tables using proper SQL practices.

---

## 📌 Table of Contents

1. [Project Overview](#project-overview)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Creating Roles and Databases](#creating-roles-and-databases)
5. [Database Projects](#database-projects)
   - [Movies Database](#movies-database)
   - [Customer/Product/Purchase](#customerproductpurchase)
   - [Stocks Database](#stocks-database)
   - [HR Database](#hr-database)
   - [Northwind Database](#northwind-database)
6. [Common SQL Commands](#common-sql-commands)
7. [License](#license)

---

## 📖 Project Overview

This project helps you practice PostgreSQL by:

- Creating and dropping databases and tables
- Working with real-world schemas
- Practicing foreign key constraints and table relationships
- Running meaningful SQL queries on each dataset

It is beginner-friendly and ideal for learners preparing for SQL interviews or backend development.

---

## 🛠️ Prerequisites

Before you begin, make sure you have the following installed:

- ✅ **PostgreSQL** (v12 or higher recommended)
  - Download: https://www.postgresql.org/download/
- ✅ **psql** CLI or **pgAdmin**
- ✅ (Optional) **Git** to clone the repository
- ✅ SQL script files provided with this project (`.sql` files)

---

## 🔧 Installation

### 1. Clone the repository (Optional)

```bash
git clone https://github.com/SandipNup/POSTGRES-SQL
cd POSTGRES-SQL

```

### 2.🔐 Create Role

```sql
CREATE ROLE db_admin WITH LOGIN PASSWORD 'SecurePass123!';

```

### 3. Database Setup

```sql
CREATE DATABASE Learning WITH OWNER db_admin

```

- ✅ Run customer.sql file from sample_data
- ✅ Run products.sql file from sample_data
- ✅ Run purchase.sql file from sample_data
- ✅ Run stocks_symbols.sql file from sample_data
- ✅ Run stocks_types.sql file from sample_data
- ✅ Run stock_prices.sql file from sample_data

```sql
CREATE DATABASE hr WITH OWNER db_admin

```

- ✅ Run hr.sql file from sample_data

```sql
CREATE DATABASE northwind WITH OWNER db_admin

```

- ✅ Run northwind.sql file from sample_data

## Creating and Modifiying tables

```sql
CREATE DATABASE movies WITH OWNER db_admin;

```

# Database Schema Setup: Creating and Modifying Tables

This section covers the SQL commands used to create and modify database tables for a movie database system.

## Table Creation Commands

### 1. Actors Table

```sql
CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(150),
    last_name VARCHAR(150) NOT NULL,
    gender CHAR(1),
    date_of_birth DATE,
    add_date DATE,
    update_date DATE
);
```

- Creates a table for storing actor information
- Uses SERIAL for auto-incrementing primary key
- Enforces last_name as NOT NULL

### 2. Directors Table

```sql
CREATE TABLE directors(
    director_id SERIAL PRIMARY KEY,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    date_of_birth DATE,
    nationality VARCHAR(20),
    add_date DATE,
    update_date DATE
);
```

### 3. Movies Table

```sql
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    movie_length INT,
    movie_language VARCHAR(20),
    age_certification VARCHAR(10),
    release_date DATE,
    director_id INT REFERENCES directors (director_id)
);
```

- Includes reference to directors table via foreign key
- Enforces movie name as NOT NULL

### 4. Movies Revenues Table

```sql
CREATE TABLE movies_revenues(
    revenue_id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies (movie_id),
    revenues_domestic NUMERIC (10,2),
    revenues_international NUMERIC (10,2)
);
```

- Tracks financial data with NUMERIC type for precise decimal values
- References movies table

### 5. Movies Actors Junction Table

```sql
CREATE TABLE movies_actors(
    movie_id INT REFERENCES movies (movie_id),
    actor_id INT REFERENCES actors (actor_id),
    PRIMARY KEY (movie_id,actor_id)
);
```

- Junction table for many-to-many relationship between movies and actors
- Composite primary key using both foreign keys

### Sample Data Installation

To populate the tables with sample data, run these scripts from sample_data folder in order:

- directors.sql
- actors.sql
- movies.sql
- movies_actors.sql
- movies_revenues.sql

### After running the scripts, verify the data:

```sql
select * from directors;
select * from actors;
select * from movies;
SELECT * FROM movies_actors;
SELECT * FROM movies_revenues;
);
```

### Creating and droping table examples

```sql
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);
```
