---
x: SQL
title: Try SQL in X minutes
image: /try/cover.png
lastmod: 2024-02-18
original: https://gvwilson.github.io/sql-tutorial/
license: CC-BY-NC-4.0
contributors:
    - ["Greg Wilson", "https://github.com/gvwilson"]
    - ["Anton Zhiyanov", "https://antonz.org"]
---

This is an introduction to SQL from basic to fairly advanced queries. It uses the SQLite dialect, but most queries should work for PostgreSQL as well.

## Concepts: Database

A _database_ is a collection of data that can be searched and retrieved. A _database management system_ (DBMS) is a program that manages a particular kind of database.

Each DBMS stores data in its own way:

-   SQLite stores each database in a single file
-   PostgreSQL spreads information across many files for higher performance

DBMS can be a library embedded in other programs (SQLite) or a server (PostgreSQL).

A _relational_ database management system (RDBMS) stores data in _tables_ and uses SQL for queries. Unfortunately, every RDBMS has its own dialect of SQL.

## 1: Selecting a constant

```sql
select 42;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" template="list.sql" output>
</codapi-snippet>

```
42
```

`select` is a keyword. Normally it is used to select data from a table, but if all we want is a constant value, we don't need to specify one.

A semicolon terminator is required.

## 2: Selecting all values from table

Using the [`penguins`](https://gist.github.com/nalgeon/c2c7919909e7f38d245ff3fbd5c1b152) database:

```sql
select * from little_penguins;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌───────────┬───────────┬────────────────┬───────────────┬───────────────────┬─────────────┬────────┐
│  species  │  island   │ bill_length_mm │ bill_depth_mm │ flipper_length_mm │ body_mass_g │  sex   │
├───────────┼───────────┼────────────────┼───────────────┼───────────────────┼─────────────┼────────┤
│ Gentoo    │ Biscoe    │ 51.3           │ 14.2          │ 218.0             │ 5300.0      │ MALE   │
│ Adelie    │ Dream     │ 35.7           │ 18.0          │ 202.0             │ 3550.0      │ FEMALE │
│ Adelie    │ Torgersen │ 36.6           │ 17.8          │ 185.0             │ 3700.0      │ FEMALE │
│ Chinstrap │ Dream     │ 55.8           │ 19.8          │ 207.0             │ 4000.0      │ MALE   │
│ Adelie    │ Dream     │ 38.1           │ 18.6          │ 190.0             │ 3700.0      │ FEMALE │
│ Adelie    │ Dream     │ 36.2           │ 17.3          │ 187.0             │ 3300.0      │ FEMALE │
│ Adelie    │ Dream     │ 39.5           │ 17.8          │ 188.0             │ 3300.0      │ FEMALE │
│ Gentoo    │ Biscoe    │ 42.6           │ 13.7          │ 213.0             │ 4950.0      │ FEMALE │
│ Gentoo    │ Biscoe    │ 52.1           │ 17.0          │ 230.0             │ 5550.0      │ MALE   │
│ Adelie    │ Torgersen │ 36.7           │ 18.8          │ 187.0             │ 3800.0      │ FEMALE │
└───────────┴───────────┴────────────────┴───────────────┴───────────────────┴─────────────┴────────┘
```

Use `*` to select all columns and `from tablename` to specify a table.

## 3: Specifying columns

```sql
select species, island, sex
from little_penguins;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌───────────┬───────────┬────────┐
│  species  │  island   │  sex   │
├───────────┼───────────┼────────┤
│ Gentoo    │ Biscoe    │ MALE   │
│ Adelie    │ Dream     │ FEMALE │
│ Adelie    │ Torgersen │ FEMALE │
│ Chinstrap │ Dream     │ MALE   │
│ Adelie    │ Dream     │ FEMALE │
│ Adelie    │ Dream     │ FEMALE │
│ Adelie    │ Dream     │ FEMALE │
│ Gentoo    │ Biscoe    │ FEMALE │
│ Gentoo    │ Biscoe    │ MALE   │
│ Adelie    │ Torgersen │ FEMALE │
└───────────┴───────────┴────────┘
```

Specify column names separated by commas, in any order. Duplicates are allowed. Line breaks are allowed and encouraged for readability.

## 4: Sorting

```sql
select species, sex, island
from little_penguins
order by island asc, sex desc;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌───────────┬────────┬───────────┐
│  species  │  sex   │  island   │
├───────────┼────────┼───────────┤
│ Gentoo    │ MALE   │ Biscoe    │
│ Gentoo    │ MALE   │ Biscoe    │
│ Gentoo    │ FEMALE │ Biscoe    │
│ Chinstrap │ MALE   │ Dream     │
│ Adelie    │ FEMALE │ Dream     │
│ Adelie    │ FEMALE │ Dream     │
│ Adelie    │ FEMALE │ Dream     │
│ Adelie    │ FEMALE │ Dream     │
│ Adelie    │ FEMALE │ Torgersen │
│ Adelie    │ FEMALE │ Torgersen │
└───────────┴────────┴───────────┘
```

`order by` must follow `from` (which must follow select). `asc` is ascending, `desc` is descending. Default is ascending, but it's better to specify it while learning.

## 5: Limiting output

```sql
-- the full dataset has 344 rows,
-- let's select 10 of them
select species, sex, island
from penguins
order by species, sex, island
limit 10;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬────────┬───────────┐
│ species │  sex   │  island   │
├─────────┼────────┼───────────┤
│ Adelie  │        │ Dream     │
│ Adelie  │        │ Torgersen │
│ Adelie  │        │ Torgersen │
│ Adelie  │        │ Torgersen │
│ Adelie  │        │ Torgersen │
│ Adelie  │        │ Torgersen │
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ FEMALE │ Biscoe    │
└─────────┴────────┴───────────┘
```

Comments start with `--` and continue to the end of the line. `limit N` specifies the maximum number of rows returned by the query.

## 6: Paging output

```sql
select species, sex, island
from penguins
order by species, sex, island
limit 10 offset 3;
-- skip the first 3 records and shows the next 10
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬────────┬───────────┐
│ species │  sex   │  island   │
├─────────┼────────┼───────────┤
│ Adelie  │        │ Torgersen │
│ Adelie  │        │ Torgersen │
│ Adelie  │        │ Torgersen │
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ FEMALE │ Biscoe    │
└─────────┴────────┴───────────┘
```

`offset N` specifies the number of rows to skip from the start of the selection. It must follow the `limit` clause.

## 7: Removing duplicates

```sql
select distinct
  species, sex, island
from penguins;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌───────────┬────────┬───────────┐
│  species  │  sex   │  island   │
├───────────┼────────┼───────────┤
│ Adelie    │ MALE   │ Torgersen │
│ Adelie    │ FEMALE │ Torgersen │
│ Adelie    │        │ Torgersen │
│ Adelie    │ FEMALE │ Biscoe    │
│ Adelie    │ MALE   │ Biscoe    │
│ Adelie    │ FEMALE │ Dream     │
│ Adelie    │ MALE   │ Dream     │
│ Adelie    │        │ Dream     │
│ Chinstrap │ FEMALE │ Dream     │
│ Chinstrap │ MALE   │ Dream     │
│ Gentoo    │ FEMALE │ Biscoe    │
│ Gentoo    │ MALE   │ Biscoe    │
│ Gentoo    │        │ Biscoe    │
└───────────┴────────┴───────────┘
```

The `distinct` keyword leaves only distinct combinations of `select`ed columns. It must appear immediately after `select`.

Note that there are empty values in the `sex` column, indicating missing data. We'll talk about this later.

## 8: Filtering results

```sql
select distinct
  species, sex, island
from penguins
where island = 'Biscoe';
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬────────┬───────────┐
│ species │  sex   │ living at │
├─────────┼────────┼───────────┤
│ Adelie  │ FEMALE │ Biscoe    │
│ Adelie  │ MALE   │ Biscoe    │
│ Gentoo  │ FEMALE │ Biscoe    │
│ Gentoo  │ MALE   │ Biscoe    │
│ Gentoo  │        │ Biscoe    │
└─────────┴────────┴───────────┘
```

The `where` condition _filters_ the rows produced by the selection. The condition is evaluated independently for each row. Only rows that pass the test appear in results.

Use single quotes for `'text data'`.

## 9: Filtering with more complex conditions

```sql
select distinct
  species, sex, island
from penguins
where island = 'Biscoe' and sex <> 'MALE';
-- `<>` means "not equal"
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬────────┬────────┐
│ species │  sex   │ island │
├─────────┼────────┼────────┤
│ Adelie  │ FEMALE │ Biscoe │
│ Gentoo  │ FEMALE │ Biscoe │
└─────────┴────────┴────────┘
```

Logical operators:

-   `and`: both sub-conditions must be true
-   `or`: either or both sub-conditions must be true

Note that the row for Gentoo penguins on Biscoe island with unknown (empty) sex didn't pass the test. We'll talk about this later.

## 10: Doing calculations

```sql
select
  flipper_length_mm / 10.0,
  body_mass_g / 1000.0
from penguins
limit 3;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌──────────────────────────┬──────────────────────┐
│ flipper_length_mm / 10.0 │ body_mass_g / 1000.0 │
├──────────────────────────┼──────────────────────┤
│ 18.1                     │ 3.75                 │
│ 18.6                     │ 3.8                  │
│ 19.5                     │ 3.25                 │
└──────────────────────────┴──────────────────────┘
```

We can perform the usual kinds of arithmetic on individual values. The calculation is done for each row independently.

## 11: Renaming columns

```sql
select
  flipper_length_mm / 10.0 as flipper_cm,
  body_mass_g / 1000.0 as weight_kg,
  island as "found at"
from penguins
limit 3;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌────────────┬───────────┬───────────┐
│ flipper_cm │ weight_kg │ found at  │
├────────────┼───────────┼───────────┤
│ 18.1       │ 3.75      │ Torgersen │
│ 18.6       │ 3.8       │ Torgersen │
│ 19.5       │ 3.25      │ Torgersen │
└────────────┴───────────┴───────────┘
```

Use `<expression> as name` to give the result of the calculation a meaningful name. Use double quotes for aliases that contain spaces.

## 12: Calculating with missing values

```sql
select
  flipper_length_mm / 10.0 as flipper_cm,
  body_mass_g / 1000.0 as weight_kg,
  island as found_at
from penguins
limit 5;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌────────────┬───────────┬───────────┐
│ flipper_cm │ weight_kg │ found_at  │
├────────────┼───────────┼───────────┤
│ 18.1       │ 3.75      │ Torgersen │
│ 18.6       │ 3.8       │ Torgersen │
│ 19.5       │ 3.25      │ Torgersen │
│            │           │ Torgersen │
│ 19.3       │ 3.45      │ Torgersen │
└────────────┴───────────┴───────────┘
```

SQL uses a special value `null` to represent missing data. It is neither 0 nor an empty string, but "I don't know". Here, the flipper length and body weight are unknown for the fourth penguin.

`null` is viral, so calculations involving it will always return `null` ("I don't know" divided by 10 or 1000 is "I don't know").

## 13: Null equality

```sql
select distinct
  species, sex, island
from penguins
where island = 'Biscoe';
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬────────┬────────┐
│ species │  sex   │ island │
├─────────┼────────┼────────┤
│ Adelie  │ FEMALE │ Biscoe │
│ Adelie  │ MALE   │ Biscoe │
│ Gentoo  │ FEMALE │ Biscoe │
│ Gentoo  │ MALE   │ Biscoe │
│ Gentoo  │        │ Biscoe │
└─────────┴────────┴────────┘
```

Let's ask for female penguins only:

```sql
select distinct
  species, sex, island
from penguins
where island = 'Biscoe' and sex = 'FEMALE';
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬────────┬────────┐
│ species │  sex   │ island │
├─────────┼────────┼────────┤
│ Adelie  │ FEMALE │ Biscoe │
│ Gentoo  │ FEMALE │ Biscoe │
└─────────┴────────┴────────┘
```

The row with the `null` sex is removed from the results.

## 14: Null inequality

Let's ask for penguins that _aren't_ female:

```sql
select distinct
  species, sex, island
from penguins
where island = 'Biscoe' and sex <> 'FEMALE';
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬──────┬────────┐
│ species │ sex  │ island │
├─────────┼──────┼────────┤
│ Adelie  │ MALE │ Biscoe │
│ Gentoo  │ MALE │ Biscoe │
└─────────┴──────┴────────┘
```

The row with the `null` sex is also removed from the results.

## 15: Ternary logic

```sql
select null = null;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────────┐
│ null = null │
├─────────────┤
│             │
└─────────────┘
```

If we don't know the left and right values, we don't know if they're equal or not — so the result is `null`. The same is true for `null <> null`.

It's _ternary logic_ — a logic based on three values: true, false, and "don't know" (represented as `null`).

```text
  equality:
┌──────┬───────┬───────┬──────┐
│      │   X   │   Y   │ null │
├──────┼───────┼───────┼──────┤
│  X   │ true  │ false │ null │
│  Y   │ false │ true  │ null │
│ null │ null  │ null  │ null │
└──────┴───────┴───────┴──────┘
```

## 16: Handling null safely

```sql
select
  species, sex, island
from penguins
where sex is null;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬─────┬───────────┐
│ species │ sex │  island   │
├─────────┼─────┼───────────┤
│ Adelie  │     │ Torgersen │
│ Adelie  │     │ Torgersen │
│ Adelie  │     │ Torgersen │
│ Adelie  │     │ Torgersen │
│ Adelie  │     │ Torgersen │
│ Adelie  │     │ Dream     │
│ Gentoo  │     │ Biscoe    │
│ Gentoo  │     │ Biscoe    │
│ Gentoo  │     │ Biscoe    │
│ Gentoo  │     │ Biscoe    │
│ Gentoo  │     │ Biscoe    │
└─────────┴─────┴───────────┘
```

Use `is null` and `is not null` to handle null safely.

Other parts of SQL treat `null` differently, often ignoring it in calculations (e.g. when summing values).

## 17: Aggregating

```sql
select sum(body_mass_g) as total_mass
from penguins;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌────────────┐
│ total_mass │
├────────────┤
│ 1437000.0  │
└────────────┘
```

_Aggregation_ combines column values from multiple rows into a single value. `sum` is an _aggregation function_.

## 18: Common aggregation functions

```sql
select
  max(bill_length_mm) as longest_bill,
  min(flipper_length_mm) as shortest_flipper,
  avg(bill_length_mm) / avg(bill_depth_mm) as weird_ratio
from penguins;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌──────────────┬──────────────────┬──────────────────┐
│ longest_bill │ shortest_flipper │   weird_ratio    │
├──────────────┼──────────────────┼──────────────────┤
│ 59.6         │ 172.0            │ 2.56087082530644 │
└──────────────┴──────────────────┴──────────────────┘
```

Aggregation functions ignore `null` values, otherwise all three result values would be `null`.

## 19: Counting

```sql
select
  -- counts rows
  count(*) as count_star,
  -- counts non-null entries in column
  count(sex) as count_specific,
  -- counts distinct non-null entries
  count(distinct sex) as count_distinct
from penguins;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌────────────┬────────────────┬────────────────┐
│ count_star │ count_specific │ count_distinct │
├────────────┼────────────────┼────────────────┤
│ 344        │ 333            │ 2              │
└────────────┴────────────────┴────────────────┘
```

## 20: Grouping

```sql
select avg(body_mass_g) as average_mass_g
from penguins
group by sex;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌──────────────────┐
│  average_mass_g  │
├──────────────────┤
│ 4005.55555555556 │
│ 3862.27272727273 │
│ 4545.68452380952 │
└──────────────────┘
```

This query puts rows in groups based on distinct combinations of values in columns specified with `group by`, then performs aggregation separately for each group.

It's not very useful unless we list the `sex` value for each group in the result.

## 21: Aggregation key

```sql
select
  sex,
  avg(body_mass_g) as average_mass_g
from penguins
group by sex;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌────────┬──────────────────┐
│  sex   │  average_mass_g  │
├────────┼──────────────────┤
│        │ 4005.55555555556 │
│ FEMALE │ 3862.27272727273 │
│ MALE   │ 4545.68452380952 │
└────────┴──────────────────┘
```

Distinct `sex` values identify each of the groups.

## 22: Unaggregated columns

```sql
select
  sex,
  body_mass_g
from penguins
group by sex;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌────────┬─────────────┐
│  sex   │ body_mass_g │
├────────┼─────────────┤
│        │             │
│ FEMALE │ 3800.0      │
│ MALE   │ 3750.0      │
└────────┴─────────────┘
```

`sex` is an aggregation key, but `body_mass_g` is not (it is not listed in `group by`). We also didn't specify an aggregation function for `body_mass_g`, so the database engine doesn't know what to do with it.

SQLite is very forgiving, so it'll just return an arbitrary `body_mass_g` value for each `sex`. PostgreSQL (and other DBMS) will return an error:

```text
ERROR:  column "penguins.body_mass_g" must appear in the GROUP BY clause or be used in an aggregate function
LINE 3:     body_mass_g
            ^
```

## 23: Filtering aggregated values

```sql
select
  sex,
  avg(body_mass_g) as average_mass_g
from penguins
group by sex
having average_mass_g > 4000.0;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌──────┬──────────────────┐
│ sex  │  average_mass_g  │
├──────┼──────────────────┤
│      │ 4005.55555555556 │
│ MALE │ 4545.68452380952 │
└──────┴──────────────────┘
```

The `having` clause filters the results _after_ aggregation (as opposed to `where`, which filters _before_ aggregation).

## 24: Readable output

```sql
select
  sex,
  round(avg(body_mass_g), 1) as average_mass_g
from penguins
group by sex
having average_mass_g > 4000.0;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌──────┬────────────────┐
│ sex  │ average_mass_g │
├──────┼────────────────┤
│      │ 4005.6         │
│ MALE │ 4545.7         │
└──────┴────────────────┘
```

Use `round(value, decimals)` to round off a number.

## 25: Filtering aggregate inputs

```sql
select
  sex,
  round(
    avg(body_mass_g) filter (where body_mass_g < 4000.0),
    1
  ) as average_mass_g
from penguins
group by sex;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌────────┬────────────────┐
│  sex   │ average_mass_g │
├────────┼────────────────┤
│        │ 3362.5         │
│ FEMALE │ 3417.3         │
│ MALE   │ 3729.6         │
└────────┴────────────────┘
```

`filter (where <condition>)` filters the results after aggregation, just like `having`. But unlike `having`, it applies to each expression in the `select` list individually.

So we can define different filters for different `select` expressions:

```sql
select
  sex,
  max(body_mass_g) filter (where body_mass_g < 4000.0) as  max_4000,
  max(body_mass_g) filter (where species = 'Adelie') as max_adelie
from penguins
group by sex;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌────────┬──────────┬────────────┐
│  sex   │ max_4000 │ max_adelie │
├────────┼──────────┼────────────┤
│        │ 3700.0   │ 4250.0     │
│ FEMALE │ 3950.0   │ 3900.0     │
│ MALE   │ 3975.0   │ 4775.0     │
└────────┴──────────┴────────────┘
```

## 26: Creating tables

```sql
create table job (
  name text not null,
  billable real not null
);

create table work (
  person text not null,
  job text not null
);
```

<codapi-snippet id="s-create" sandbox="sqlite" command="run" editor="basic" output-mode="hidden">
</codapi-snippet>

To create a table, use `create table <name>` followed by a list of columns in parentheses. Each column has a name, a data type, and optional extra information (e.g., `not null` prohibits writing `null` values).

## 27: Inserting Data

```sql
insert into job values
('calibrate', 1.5),
('clean', 0.5);

insert into work values
('mik', 'calibrate'),
('mik', 'clean'),
('mik', 'complain'),
('po', 'clean'),
('po', 'complain'),
('tay', 'complain');

select * from job;
select * from work;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" depends-on="s-create" output>
</codapi-snippet>

```
┌───────────┬──────────┐
│   name    │ billable │
├───────────┼──────────┤
│ calibrate │ 1.5      │
│ clean     │ 0.5      │
└───────────┴──────────┘
┌────────┬───────────┐
│ person │    job    │
├────────┼───────────┤
│ mik    │ calibrate │
│ mik    │ clean     │
│ mik    │ complain  │
│ po     │ clean     │
│ po     │ complain  │
│ tay    │ complain  │
└────────┴───────────┘
```

## 28: Updating rows

```sql
update work
set person = 'tae'
where person = 'tay';
```

<codapi-snippet id="s-update" sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output-mode="hidden">
</codapi-snippet>

```sql
select * from work;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" depends-on="s-update" output>
</codapi-snippet>

```
┌────────┬───────────┐
│ person │    job    │
├────────┼───────────┤
│ mik    │ calibrate │
│ mik    │ clean     │
│ mik    │ complain  │
│ po     │ clean     │
│ po     │ complain  │
│ tae    │ complain  │
└────────┴───────────┘
```

The `where` clause specifies which rows to update. Without `where`, the query will update all rows in the table, which is usually not what you want.

## 29: Deleting rows

```sql
delete from work
where person = 'tae';

select * from work;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" depends-on="s-update" output>
</codapi-snippet>

```
┌────────┬───────────┐
│ person │    job    │
├────────┼───────────┤
│ mik    │ calibrate │
│ mik    │ clean     │
│ mik    │ complain  │
│ po     │ clean     │
│ po     │ complain  │
└────────┴───────────┘
```

As with `update`, you use `where` to specify which rows to delete.

## 30: Copying tables

```sql
create table work_bak (
  person text not null,
  job text not null
);

insert into work_bak
select person, job
from work;

select count(*) from work_bak;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌──────────┐
│ count(*) │
├──────────┤
│ 6        │
└──────────┘
```

`insert into ... select` inserts selected rows from one table into the other.

You can create and populate the table with a single query:

```sql
create table work_bak as
select person, job
from work;

select count(*) from work_bak;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌──────────┐
│ count(*) │
├──────────┤
│ 6        │
└──────────┘
```

The `work_bak` table structure is automatically defined based on the names and types of the `select` expressions (in this case, the `person` and `job` columns).

## 31: Combining information

```sql
select *
from work cross join job;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌────────┬───────────┬───────────┬──────────┐
│ person │    job    │   name    │ billable │
├────────┼───────────┼───────────┼──────────┤
│ mik    │ calibrate │ calibrate │ 1.5      │
│ mik    │ calibrate │ clean     │ 0.5      │
│ mik    │ clean     │ calibrate │ 1.5      │
│ mik    │ clean     │ clean     │ 0.5      │
│ mik    │ complain  │ calibrate │ 1.5      │
│ mik    │ complain  │ clean     │ 0.5      │
│ po     │ clean     │ calibrate │ 1.5      │
│ po     │ clean     │ clean     │ 0.5      │
│ po     │ complain  │ calibrate │ 1.5      │
│ po     │ complain  │ clean     │ 0.5      │
│ tay    │ complain  │ calibrate │ 1.5      │
│ tay    │ complain  │ clean     │ 0.5      │
└────────┴───────────┴───────────┴──────────┘
```

A _join_ combines information from two tables. `cross join` constructs their _cross product_ —
all pairwise combinations of rows from the first table with rows from the second table.

The result isn't very useful. `job` and `name` values don't match: the combined data has records not related to each other.

## 32: Inner join

```sql
select *
from work
  inner join job on work.job = job.name;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌────────┬───────────┬───────────┬──────────┐
│ person │    job    │   name    │ billable │
├────────┼───────────┼───────────┼──────────┤
│ mik    │ calibrate │ calibrate │ 1.5      │
│ mik    │ clean     │ clean     │ 0.5      │
│ po     │ clean     │ clean     │ 0.5      │
└────────┴───────────┴───────────┴──────────┘
```

Use the `<table>.<column>` notation to specify columns. Use `on <condition>` to specify the _join condition_. Here we are matching people from the `work` table with corresponding jobs from the `job` table, effectively selecting all jobs for each person.

Note that while some people in the `work` table have `job` = `complain`, there are no `complain` jobs in the `job` table. So for `work.job = 'complain'` there are no matching records in the `job` table, and these records are excluded from the result.

## 33: Aggregating joined data

```sql
select
  work.person,
  sum(job.billable) as pay
from work
  inner join job on work.job = job.name
group by work.person;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌────────┬─────┐
│ person │ pay │
├────────┼─────┤
│ mik    │ 2.0 │
│ po     │ 0.5 │
└────────┴─────┘
```

Here we select all jobs for each person (as in the previous query), and then aggregate them by person, calculating the total pay for each person.

Since Tay in the `work` table has only `complain` jobs, and the `jobs` table is missing `complain` jobs, Tay is excluded from the result.

## 34: Left join

```sql
select *
from work
  left join job on work.job = job.name;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌────────┬───────────┬───────────┬──────────┐
│ person │    job    │   name    │ billable │
├────────┼───────────┼───────────┼──────────┤
│ mik    │ calibrate │ calibrate │ 1.5      │
│ mik    │ clean     │ clean     │ 0.5      │
│ mik    │ complain  │           │          │
│ po     │ clean     │ clean     │ 0.5      │
│ po     │ complain  │           │          │
│ tay    │ complain  │           │          │
└────────┴───────────┴───────────┴──────────┘
```

A _left join_ (also known as a _left outer join_) keeps all rows from the _left_ table (`work`) and fills missing values from the right table (`job`) with `null`.

Now Tay has finally made it into the result, but since there are no jobs for them in the `job` table, the `name` and `billable` columns for Tay are empty.

## 35: Aggregating left joins

```sql
select
    work.person,
    sum(job.billable) as pay
from work
  left join job on work.job = job.name
group by work.person;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌────────┬─────┐
│ person │ pay │
├────────┼─────┤
│ mik    │ 2.0 │
│ po     │ 0.5 │
│ tay    │     │
└────────┴─────┘
```

As discussed in the previous query, Tay has made it into the result thanks to the `left join`. And since the individual `billable` values for Tay are `null`, their sum is also `null`.

## 36: Coalescing values

```sql
select
  work.person,
  coalesce(sum(job.billable), 0.0) as pay
from work
  left join job on work.job = job.name
group by work.person;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌────────┬─────┐
│ person │ pay │
├────────┼─────┤
│ mik    │ 2.0 │
│ po     │ 0.5 │
│ tay    │ 0.0 │
└────────┴─────┘
```

`coalesce(val1, val2, ...)` returns the first non-null value, so Tay gets 0 pay instead of `null`.

## 37: Full outer join

Suppose we add one more job to the `jobs` table:

```sql
insert into job values
('manage', 1);
```

<codapi-snippet id="s-job-manage" sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output-mode="hidden">
</codapi-snippet>

Now let's select people with their corresponding job, but using the `full join` instead of `left join`:

```sql
select *
from work
  full join job on work.job = job.name;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" depends-on="s-job-manage" output>
</codapi-snippet>

```
┌────────┬───────────┬───────────┬──────────┐
│ person │    job    │   name    │ billable │
├────────┼───────────┼───────────┼──────────┤
│ mik    │ calibrate │ calibrate │ 1.5      │
│ mik    │ clean     │ clean     │ 0.5      │
│ mik    │ complain  │           │          │
│ po     │ clean     │ clean     │ 0.5      │
│ po     │ complain  │           │          │
│ tay    │ complain  │           │          │
│        │           │ manage    │ 1.0      │
└────────┴───────────┴───────────┴──────────┘
```

A _full join_ (also known as a _full outer join_) selects the following:

-   matching rows from both tables,
-   rows from the _left_ table (`work`) that do not match the _right_ table (`job`).
-   rows from the _right_ table (`job`) that do not match the _left_ table (`work`).

So the query returns both Tay from the `work` table (whose job does not match the `job` table) and "manage" from the `job` table (whose name does not match the `work` table).

## 38: Negating incorrectly

Who doesn't calibrate?

```sql
select distinct person
from work
where job <> 'calibrate';
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌────────┐
│ person │
├────────┤
│ mik    │
│ po     │
│ tay    │
└────────┘
```

Mik made it into the result, which seems wrong: Mik _does_ calibrate (`name='mik', job='calibrate'`). The problem is that there's an entry for Mik cleaning (`name='mik', job='clean'`). And since `'clean' <> 'calibrate'`, this entry is included in the result.

So essentially this query is _Whose ONLY job is not calibrate?_. We need a different approach to answer the original question.

## 39: Set membership

```sql
select *
from work
where person not in ('mik', 'tay');
-- select all people except Mik and Tay
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌────────┬──────────┐
│ person │   job    │
├────────┼──────────┤
│ po     │ clean    │
│ po     │ complain │
└────────┴──────────┘
```

`in <values>` and `not in <values>` clauses work exactly as you'd expect.

## 40: Subqueries

So who doesn't calibrate?

```sql
select distinct person
from work
where person not in (
  select distinct person
  from work
  where job = 'calibrate'
);
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌────────┐
│ person │
├────────┤
│ po     │
│ tay    │
└────────┘
```

Here we use a _subquery_ to select the people who _do_ calibrate. Then we select all the people who are _not_ in that set (so essentially those who _do not_ calibrate).

## 41: Defining a primary key

A _primary key_ uniquely identifies each record in a table. A table can use any field (or combination of fields) as a primary key, as long as the value(s) are unique for each record.

```sql
create table lab_equipment (
  size real not null,
  color text not null,
  num integer not null,
  primary key (size, color)
);

insert into lab_equipment values
(1.5, 'blue', 2),
(1.5, 'green', 1),
(2.5, 'blue', 1);

select * from lab_equipment;

insert into lab_equipment values
(1.5, 'green', 2);
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" output>
</codapi-snippet>

```
┌──────┬───────┬─────┐
│ size │ color │ num │
├──────┼───────┼─────┤
│ 1.5  │ blue  │ 2   │
│ 1.5  │ green │ 1   │
│ 2.5  │ blue  │ 1   │
└──────┴───────┴─────┘
Runtime error near line 17: UNIQUE constraint failed: lab_equipment.size, lab_equipment.color (19)
 (exit status 1)
```

Since the table already contains the `size=1.5, color='green'` record, we can't add another one with the same values.

## 42: Autoincrementing and primary keys

```sql
create table person (
  ident integer primary key autoincrement,
  name text not null
);

insert into person values
(null, 'mik'),
(null, 'po'),
(null, 'tay');

select * from person;

insert into person values (1, 'prevented');
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" output>
</codapi-snippet>

```
┌───────┬──────┐
│ ident │ name │
├───────┼──────┤
│ 1     │ mik  │
│ 2     │ po   │
│ 3     │ tay  │
└───────┴──────┘
Runtime error near line 37: UNIQUE constraint failed: person.ident (19)
 (exit status 1)
```

The database _autoincrements_ `ident` each time a new record is added. Auto-incremented fields are unique for each record, so they are often used as primary keys.

Such _surrogate_ identifiers are also useful because if the "business" attribute of a record changes (say, Mik changes their name), the identifier remains the same, and we don't need to change the data in other tables that reference said record.

## 43: Altering tables

Let's add a unique identifier to the `job` table:

```sql
alter table job
add ident integer not null default -1;

update job
set ident = 1
where name = 'calibrate';

update job
set ident = 2
where name = 'clean';

select * from job;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output>
</codapi-snippet>

```
┌───────────┬──────────┬───────┐
│   name    │ billable │ ident │
├───────────┼──────────┼───────┤
│ calibrate │ 1.5      │ 1     │
│ clean     │ 0.5      │ 2     │
└───────────┴──────────┴───────┘
```

Here we add the `ident` column. Since it can't be null and there is already data in the table, we have to provide a default value.

Then we use `update` to modify existing records and set the actual `ident` values. This is an example of _data migration_.

## Concepts: M-to-N relationships

Relationships between entities are typically characterized as:

**1-to-1**. Fields in the same record (such as a person's first and last name)

**1-to-many**. Each record in table A can have multiple matching records in table B, but each record in table B has at most one matching record in table A (a person can have multiple toothbrushes, but each toothbrush belongs to at most one person).

**Many-to-many**. Each record in table A can have multiple matching records in table B, and vice versa (a person can have multiple jobs, and each job can be performed by multiple people).

## 44: Creating a join table

Our `work` and `job` tables have a many-to-many relationship. Typically, such relationships are implemented using a separate _join table_:

-   Extract people into table A.
-   Extract jobs into table B.
-   Create a join table with person-job pairs (referencing A and B).

Let's do this.

```sql
-- extract people
create table people (
  ident integer primary key autoincrement,
  name text not null
);

insert into people (name)
select distinct person
from work;
```

<codapi-snippet id="s-people" sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output-mode="hidden">
</codapi-snippet>

```sql
-- extract jobs
create table jobs (
  ident integer primary key autoincrement,
  name text not null,
  billable real not null
);

insert into jobs (name, billable)
select name, billable from job;
```

<codapi-snippet id="s-jobs" sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output-mode="hidden">
</codapi-snippet>

```sql
-- create a join table
create table people_jobs (
  person_id integer not null,
  job_id integer not null,
  foreign key (person_id) references people (ident),
  foreign key (job_id) references jobs (ident)
);
```

<codapi-snippet id="s-people-jobs" sandbox="sqlite" command="run" editor="basic" template="work_job.sql" depends-on="s-people s-jobs" output-mode="hidden">
</codapi-snippet>

The `foreign key` constraint defines references from `people_jobs` to `people` and `jobs`:

-   For each `person_id` value in `people_jobs`, there must be a record with the matching `ident` value in `people`.
-   For each `job_id` value in `people_jobs`, there must be a record with the matching `ident` value in `jobs`.

```sql
-- fill it with person-job pairs
insert into people_jobs
select
  people.ident as person_id,
  jobs.ident as job_id
from people
  inner join work on people.name = work.person
  inner join jobs on work.job = jobs.name;

select * from people_jobs;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" depends-on="s-people-jobs" output>
</codapi-snippet>

```
┌───────────┬────────┐
│ person_id │ job_id │
├───────────┼────────┤
│ 1         │ 1      │
│ 1         │ 2      │
│ 2         │ 2      │
└───────────┴────────┘
```

## 45: Removing Tables

Delete old tables:

```sql
drop table work;
drop table job;
```

<codapi-snippet id="s-drop-table" sandbox="sqlite" command="run" editor="basic" template="work_job.sql" output-mode="hidden">
</codapi-snippet>

Running `drop table` twice on the same table will result in error. So it's safer to delete a table only if it really exists and do nothing otherwise:

```sql
drop table if exists work;
drop table if exists job;
```

<codapi-snippet sandbox="sqlite" command="run" editor="basic" template="work_job.sql" depends-on="s-drop-table" output-mode="hidden">
</codapi-snippet>

## 46: Comparing individual values to aggregates

Going back to the [penguins.sql](https://gist.github.com/nalgeon/c2c7919909e7f38d245ff3fbd5c1b152) database, let's select penguins who weight more than the average:

```sql
select body_mass_g
from penguins
where
  body_mass_g > (
    select avg(body_mass_g)
    from penguins
  )
limit 5;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────────┐
│ body_mass_g │
├─────────────┤
│ 4675.0      │
│ 4250.0      │
│ 4400.0      │
│ 4500.0      │
│ 4650.0      │
└─────────────┘
```

Here, we calculate the average body mass in the subquery, and then compare each row to that average.

Running the query requires two scans of the data. There's no way to avoid this, unless we store the average in every record (but then we have to update all records every time we insert or update).

`null` values aren't included in the average or in the final results.

## 47: Comparing individual values to aggregates within groups

Find penguins that are heavier than average within their species:

```sql
select
  penguins.species,
  penguins.body_mass_g,
  round(averaged.avg_mass_g, 1) as avg_mass_g
from penguins
  inner join (
    select species, avg(body_mass_g) as avg_mass_g
    from penguins
    group by species
  ) as averaged
  on penguins.species = averaged.species
where penguins.body_mass_g > averaged.avg_mass_g
limit 5;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬─────────────┬────────────┐
│ species │ body_mass_g │ avg_mass_g │
├─────────┼─────────────┼────────────┤
│ Adelie  │ 3750.0      │ 3700.7     │
│ Adelie  │ 3800.0      │ 3700.7     │
│ Adelie  │ 4675.0      │ 3700.7     │
│ Adelie  │ 4250.0      │ 3700.7     │
│ Adelie  │ 3800.0      │ 3700.7     │
└─────────┴─────────────┴────────────┘
```

Here, the subquery runs first to create a temporary table `averaged` with the average mass per species. Then the database engine joins it with the `penguins` table, and finally filters to find penguins that are heavier than average within their species.

## 48: Common table expressions

```sql
with averaged as (
  select species, avg(body_mass_g) as avg_mass_g
  from penguins
  group by species
)

select
  penguins.species,
  penguins.body_mass_g,
  round(averaged.avg_mass_g, 1) as avg_mass_g
from penguins
  inner join averaged on penguins.species = averaged.species
where penguins.body_mass_g > averaged.avg_mass_g
limit 5;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌─────────┬─────────────┬────────────┐
│ species │ body_mass_g │ avg_mass_g │
├─────────┼─────────────┼────────────┤
│ Adelie  │ 3750.0      │ 3700.7     │
│ Adelie  │ 3800.0      │ 3700.7     │
│ Adelie  │ 4675.0      │ 3700.7     │
│ Adelie  │ 4250.0      │ 3700.7     │
│ Adelie  │ 3800.0      │ 3700.7     │
└─────────┴─────────────┴────────────┘
```

We've extracted the `averaged` subquery into a _common table expression_ (CTE) to make the query clearer. CTE is basically a named subquery that is defined before the main query and can be referenced by name like a regular table.

Nested subqueries quickly become hard to understand, so it's better to use CTEs. Do not worry about subqueries being more performant than CTEs — the database engine is (usually) smart enough to take care of that.

## 49: Conditionals

Assign a `size` to each penguin according to its weight, then calculate the number of penguins of each size within each species:

```sql
with sized_penguins as (
  select
    species,
    (
      case when body_mass_g < 3500
      then 'small' else 'large' end
    ) as size
  from penguins
  where body_mass_g is not null
)

select species, size, count(*) as num
from sized_penguins
group by species, size
order by species, num;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌───────────┬───────┬─────┐
│  species  │ size  │ num │
├───────────┼───────┼─────┤
│ Adelie    │ small │ 54  │
│ Adelie    │ large │ 97  │
│ Chinstrap │ small │ 17  │
│ Chinstrap │ large │ 51  │
│ Gentoo    │ large │ 123 │
└───────────┴───────┴─────┘
```

The following expression returns a single result according to the condition:

```sql
case when <condition> then <true_result> else <false_result> end
```

## 50: Selecting a case

Use three possible `size`s instead of two:

```sql
with sized_penguins as (
  select
    species,
    case
      when body_mass_g < 3500 then 'small'
      when body_mass_g < 5000 then 'medium'
      else 'large'
    end as size
  from penguins
  where body_mass_g is not null
)

select species, size, count(*) as num
from sized_penguins
group by species, size
order by species, num;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌───────────┬────────┬─────┐
│  species  │  size  │ num │
├───────────┼────────┼─────┤
│ Adelie    │ small  │ 54  │
│ Adelie    │ medium │ 97  │
│ Chinstrap │ small  │ 17  │
│ Chinstrap │ medium │ 51  │
│ Gentoo    │ medium │ 56  │
│ Gentoo    │ large  │ 67  │
└───────────┴────────┴─────┘
```

`case` can contain any number of conditions:

```sql
case
  when <condition_1> then <result_1>
  when <condition_2> then <result_2>
  when <condition_3> then <result_3>
  when ...
  else <result_else>
end
```

## 51: Checking a range

Consider the weight 3500 ≤ x ≤ 5000 as "normal", otherwise as "abnormal":

```sql
with sized_penguins as (
  select
    species,
    case
      when body_mass_g between 3500 and 5000 then 'normal'
      else 'abnormal'
    end as size
  from penguins
  where body_mass_g is not null
)

select species, size, count(*) as num
from sized_penguins
group by species, size
order by species, num;
```

<codapi-snippet sandbox="sqlite" command="penguins" editor="basic" output>
</codapi-snippet>

```
┌───────────┬──────────┬─────┐
│  species  │   size   │ num │
├───────────┼──────────┼─────┤
│ Adelie    │ abnormal │ 54  │
│ Adelie    │ normal   │ 97  │
│ Chinstrap │ abnormal │ 17  │
│ Chinstrap │ normal   │ 51  │
│ Gentoo    │ abnormal │ 61  │
│ Gentoo    │ normal   │ 62  │
└───────────┴──────────┴─────┘
```

`X between L and H` is equivalent to `X >= L and X <= H`.

## Assays database

Let's switch to the [`assays`](https://gist.github.com/nalgeon/87473cbad6918c579d00dc4561083d58) database:

```text
┌─────────────┐                   ┌─────────────┐
│ invalidated │──────────────────>│ plate       │──┐
└─────────────┘   ┌───────────┐   └─────────────┘  │
        └────────>│ staff     │   ┌─────────────┐  │
        ┌────────>│           │──>│ department  │  │
        │         └───────────┘   └─────────────┘  │
┌─────────────┐                   ┌─────────────┐  │
│ performed   │──────────────────>│ experiment  │<─┘
└─────────────┘                   └─────────────┘
```

Try selecting from different tables to understand the table structure and relationships:

```sql
select * from staff;
```

<codapi-snippet sandbox="sqlite" command="assays" editor="basic" output>
</codapi-snippet>

```
┌───────┬──────────┬───────────┬──────┬─────┐
│ ident │ personal │  family   │ dept │ age │
├───────┼──────────┼───────────┼──────┼─────┤
│ 1     │ Kartik   │ Gupta     │      │ 46  │
│ 2     │ Divit    │ Dhaliwal  │ hist │ 34  │
│ 3     │ Indrans  │ Sridhar   │ mb   │ 47  │
│ 4     │ Pranay   │ Khanna    │ mb   │ 51  │
│ 5     │ Riaan    │ Dua       │      │ 23  │
│ 6     │ Vedika   │ Rout      │ hist │ 45  │
│ 7     │ Abram    │ Chokshi   │ gen  │ 23  │
│ 8     │ Romil    │ Kapoor    │ hist │ 38  │
│ 9     │ Ishaan   │ Ramaswamy │ mb   │ 35  │
│ 10    │ Nitya    │ Lal       │ gen  │ 52  │
└───────┴──────────┴───────────┴──────┴─────┘
```

## 52: Pattern matching

```sql
select personal, family
from staff
where personal like '%ya%';
```

<codapi-snippet sandbox="sqlite" command="assays" editor="basic" output>
</codapi-snippet>

```
┌──────────┬────────┐
│ personal │ family │
├──────────┼────────┤
│ Nitya    │ Lal    │
└──────────┴────────┘
```

`like` matches the value against the pattern:

-   `_` matches a single character
-   `%` matches zero or more characters

`like` is case-sensitive in some DBMS (such as PostgreSQL) and case-insensitive in others (SQLite).

To be continued...
